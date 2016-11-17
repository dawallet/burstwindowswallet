package pocminer;

import static akka.actor.SupervisorStrategy.resume;

import java.io.File;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import nxt.util.Convert;
import fr.cryptohash.Shabal256;
import akka.actor.ActorRef;
import akka.actor.OneForOneStrategy;
import akka.actor.Props;
import akka.actor.SupervisorStrategy;
import akka.actor.UntypedActor;
import akka.actor.Cancellable;
import akka.actor.SupervisorStrategy.Directive;
import akka.japi.Function;
import scala.concurrent.duration.Duration;
import pocminer.MinerSupr;
import pocminer.ScoopChecker.msgBestScoop;
import pocminer.ScoopReader;
import pocminer.ScoopChecker;
import pocminer.util.MiningPlot;

public class Miner extends UntypedActor {
	MinerSupr.NetState state;
	
	ActorRef reader;
	ActorRef checker;
	
	BigInteger bestresult;
	long bestaddr;
	long bestnonce;
	Boolean newbest;
	
	Map<Long, String> passPhrases = null;
	
	int scoopnum;
	
	Cancellable tick = null;
	
	public Miner(MinerSupr.NetState state, Map<Long, String> passPhrases) {
		super();
		this.state = state;
		this.passPhrases = passPhrases;
	}
	
	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof ScoopReader.msgScoopChunk) {
			checker.tell(new ScoopChecker.msgCheckScoops((ScoopReader.msgScoopChunk)message, state.gensig), getSelf());
		}
		else if(message instanceof ScoopChecker.msgBestScoop) {
			ScoopChecker.msgBestScoop bs = (msgBestScoop) message;
			if(bs.result.compareTo(bestresult) < 0) {
				bestresult = bs.result;
				bestaddr = bs.address;
				bestnonce = bs.nonce;
				newbest = true;
			}
		}
		else if(message instanceof msgSendResults) {
			if(newbest) {
				newbest = false;
				getContext().parent().tell(new msgBestResult(bestaddr, bestnonce), getSelf());
			}
		}
		else {
			unhandled(message);
		}
		
	}
	
	@Override
	public void preStart() {
		init();
	}
	
	@Override
	public void postStop() {
		if(tick != null) {
			tick.cancel();
			tick = null;
		}
	}
	
	private void init() {
		bestresult = new BigInteger("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", 16);
		bestaddr = 0;
		bestnonce = 0;
		newbest = false;

		reader = getContext().actorOf(Props.create(ScoopReader.class));
		checker = getContext().actorOf(Props.create(ScoopChecker.class));
		
		ByteBuffer buf = ByteBuffer.allocate(32 + 8);
		buf.put(state.gensig);
		buf.putLong(state.height);
		
		Shabal256 md = new Shabal256();
		md.update(buf.array());
		BigInteger hashnum = new BigInteger(1, md.digest());
		scoopnum = hashnum.mod(BigInteger.valueOf(MiningPlot.SCOOPS_PER_PLOT)).intValue();
		
		File[] files = new File("plots").listFiles();
		for(int i = 0; i < files.length; i++) {
			PlotInfo pi = new PlotInfo(files[i].getName());
			if(passPhrases.containsKey(pi.address)) {
				reader.tell(new ScoopReader.msgReadScoops(pi, scoopnum), getSelf());
			}
			else {
				System.out.println("Warning: missing passphrase for address: " + Convert.toUnsignedLong(pi.address) + ". cannot mine with file: " + files[i].getName());
			}
		}
		
		tick = getContext().system().scheduler().schedule(Duration.create(10, TimeUnit.SECONDS),
				Duration.create(5, TimeUnit.SECONDS),
				getSelf(),
				new msgSendResults(),
				getContext().system().dispatcher(),
				null);
	}
	
	public static class PlotInfo {
		public String filename;
		public long address;
		public long startnonce;
		public long plots;
		public long staggeramt;
		public PlotInfo(String filename) {
			this.filename = filename;
			String[] parts = filename.split("_");
			this.address = Convert.parseUnsignedLong(parts[0]);
			this.startnonce = Long.valueOf(parts[1]);
			this.plots = Long.valueOf(parts[2]);
			this.staggeramt = Long.valueOf(parts[3]);
		}
	}
	
	public static class msgBestResult {
		public long bestaddress;
		public long bestnonce;
		public msgBestResult(long bestaddress, long bestnonce) {
			this.bestaddress = bestaddress;
			this.bestnonce = bestnonce;
		}
	}
	
	public static class msgSendResults {}
	
	private static SupervisorStrategy strategy =
		new OneForOneStrategy(10, Duration.create("1 minute"),
			new Function<Throwable, Directive>() {
				@Override
				public Directive apply(Throwable t) {
					return resume();
				}
		});
	
	@Override
	public SupervisorStrategy supervisorStrategy() {
		return strategy;
	}
}
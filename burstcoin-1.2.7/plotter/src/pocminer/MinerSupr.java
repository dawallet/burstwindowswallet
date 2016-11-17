package pocminer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;

import scala.concurrent.duration.Duration;
import nxt.crypto.Crypto;
import nxt.util.Convert;
import akka.actor.ActorRef;
import akka.actor.OneForOneStrategy;
import akka.actor.Props;
import akka.actor.SupervisorStrategy;
import akka.actor.SupervisorStrategy.Directive;
import static akka.actor.SupervisorStrategy.resume;
import akka.actor.UntypedActor;
import akka.japi.Function;

public class MinerSupr extends UntypedActor {

	String address;
	NetState state;
	
	ActorRef com = null;
	ActorRef miner = null;
	
	Map<Long, String> loadedPassPhrases = new HashMap<Long, String>();
	
	public MinerSupr(String address) {
		super();
		this.address = address;
		this.state = null;
		init();
	}
	
	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof NetState) {
			state = (NetState)message;
			
			if(miner != null) {
				getContext().stop(miner);
			}
			miner = getContext().actorOf(Props.create(Miner.class, state, loadedPassPhrases));
		}
		else if(message instanceof Miner.msgBestResult) {
			System.out.print("New best: ");
			System.out.print(Convert.toUnsignedLong(((Miner.msgBestResult)message).bestaddress));
			System.out.print(":");
			System.out.println(((Miner.msgBestResult)message).bestnonce);
			
			String passPhrase = loadedPassPhrases.get(((Miner.msgBestResult)message).bestaddress);
			
			com.tell(new msgSubmitResult(passPhrase, ((Miner.msgBestResult)message).bestnonce), getSelf());
		}
		else {
			unhandled(message);
		}
		
	}
	
	private void init() {
		//loadedPassPhrases = new HashMap<Long, String>();
		try {
			List<String> passphrases = Files.readAllLines(Paths.get("passphrases.txt"), Charset.forName("US-ASCII"));
			for(String ps : passphrases) {
				if(!ps.isEmpty()) {
					byte[] publicKey = Crypto.getPublicKey(ps);
					byte[] publicKeyHash = Crypto.sha256().digest(publicKey);
					Long id = Convert.fullHashToId(publicKeyHash);
					loadedPassPhrases.put(id, ps);
					System.out.println("Added key: " + ps + " -> " + Convert.toUnsignedLong(id));
				}
			}
		} catch (IOException e) {
			System.out.println("Warning: no passphrases.txt found");
			System.out.println("Mining without passphrases is currently not supported");
			getContext().system().shutdown();
			return;
		}
		com = getContext().actorOf(Props.create(MinerCom.class, address));
	}
	
	public static class NetState {
		public long height;
		public byte[] gensig;
		public NetState(long height, byte[] gensig) {
			this.height = height;
			this.gensig = gensig;
		}
	}
	
	public static class msgSubmitResult {
		public String passPhrase;
		public long nonce;
		public msgSubmitResult(String passPhrase, long nonce) {
			this.passPhrase = passPhrase;
			this.nonce = nonce;
		}
	}
	
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

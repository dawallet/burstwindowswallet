package pocminer_pool;

import java.math.BigInteger;

import akka.actor.ActorRef;
import akka.actor.UntypedActor;
import fr.cryptohash.Shabal256;
import pocminer_pool.ScoopChecker.msgBestScoop;
import pocminer_pool.ScoopChecker.msgCheckScoops;
import pocminer_pool.ScoopReader.msgScoopChunk;
import pocminer_pool.util.MiningPlot;

public class PoolScoopChecker extends UntypedActor {
	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof msgCheckPoolScoops) {
			checkScoops((msgCheckPoolScoops) message, getSender());
		}
		if(message instanceof Miner.msgCheckFlush) {
			getSender().tell(message, getSelf());
		}
		else {
			unhandled(message);
		}
	}
	
	private void checkScoops(msgCheckPoolScoops cs, ActorRef sender) {
		Shabal256 md = new Shabal256();
		for(long i = 0; i < cs.numscoops; i++) {
			md.reset();
			md.update(cs.gensig);
			md.update(cs.scoops, (int) (i * MiningPlot.SCOOP_SIZE), MiningPlot.SCOOP_SIZE);
			byte[] hash = md.digest();
			BigInteger num = new BigInteger(1, new byte[] {hash[7], hash[6], hash[5], hash[4], hash[3], hash[2], hash[1], hash[0]});
			//BigInteger num = new BigInteger(1, md.digest());
			BigInteger deadline = num.divide(BigInteger.valueOf(cs.baseTarget));
			if(deadline.compareTo(BigInteger.valueOf(cs.targetDeadline)) <= 0) {
				sender.tell(new MinerSupr.msgAddResult(cs.address, cs.startnonce + i, cs.height), sender);
			}
		}
	}
	
	public static class msgCheckPoolScoops {
		public long address;
		public long startnonce;
		public long numscoops;
		public byte[] scoops;
		public byte[] gensig;
		long baseTarget;
		long targetDeadline;
		long height;
		public msgCheckPoolScoops(msgScoopChunk sc, byte[] gensig, long baseTarget, long targetDeadline, long height) {
			this.address = sc.address;
			this.startnonce = sc.startnonce;
			this.numscoops = sc.numscoops;
			this.scoops = sc.scoops;
			this.gensig = gensig;
			this.baseTarget = baseTarget;
			this.targetDeadline = targetDeadline;
			this.height = height;
		}
	}

}

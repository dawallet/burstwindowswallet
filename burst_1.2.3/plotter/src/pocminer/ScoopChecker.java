package pocminer;

import java.math.BigInteger;

import akka.actor.ActorRef;
import akka.actor.UntypedActor;
import fr.cryptohash.Shabal256;
import pocminer.ScoopReader.msgScoopChunk;
import pocminer.util.MiningPlot;

public class ScoopChecker extends UntypedActor {

	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof msgCheckScoops) {
			checkScoops((msgCheckScoops) message, getSender());
		}
		else {
			unhandled(message);
		}
	}
	
	private void checkScoops(msgCheckScoops cs, ActorRef sender) {
		Shabal256 md = new Shabal256();
		BigInteger lowest = new BigInteger("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", 16);
		long lowestscoop = 0;
		for(long i = 0; i < cs.numscoops; i++) {
			md.reset();
			md.update(cs.gensig);
			md.update(cs.scoops, (int) (i * MiningPlot.SCOOP_SIZE), MiningPlot.SCOOP_SIZE);
			byte[] hash = md.digest();
			BigInteger num = new BigInteger(1, new byte[] {hash[7], hash[6], hash[5], hash[4], hash[3], hash[2], hash[1], hash[0]});
			//BigInteger num = new BigInteger(1, md.digest());
			if(num.compareTo(lowest) < 0) {
				lowest = num;
				lowestscoop = cs.startnonce + i;
			}
		}
		sender.tell(new msgBestScoop(cs.address, lowestscoop, lowest), sender);
	}

	public static class msgCheckScoops {
		public long address;
		public long startnonce;
		public long numscoops;
		public byte[] scoops;
		public byte[] gensig;
		public msgCheckScoops(msgScoopChunk sc, byte[] gensig) {
			this.address = sc.address;
			this.startnonce = sc.startnonce;
			this.numscoops = sc.numscoops;
			this.scoops = sc.scoops;
			this.gensig = gensig;
		}
	}
	
	public static class msgBestScoop {
		public long address;
		public long nonce;
		public BigInteger result;
		public msgBestScoop(long address, long nonce, BigInteger result) {
			this.address = address;
			this.nonce = nonce;
			this.result = result;
		}
	}
	
}

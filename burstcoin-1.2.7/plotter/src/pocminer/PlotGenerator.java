package pocminer;

import akka.actor.UntypedActor;

import pocminer.util.MiningPlot;

public class PlotGenerator extends UntypedActor {

	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof msgGenerate) {
			MiningPlot p = new MiningPlot(((msgGenerate)message).id,
										  ((msgGenerate)message).nonce);
		getSender().tell(new msgGenerateResult(((msgGenerate)message).nonce, p), getSelf());
		}
	}

	public static class msgGenerate {
		public long id;
		public long nonce;
		public msgGenerate(long id, long nonce) {
			this.id = id;
			this.nonce = nonce;
		}
	}
	
	public static class msgGenerateResult {
		public long nonce;
		public MiningPlot plot;
		public msgGenerateResult(long nonce, MiningPlot plot) {
			this.nonce = nonce;
			this.plot = plot;
		}
	}
}

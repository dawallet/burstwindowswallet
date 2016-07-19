package pocminer;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import nxt.util.Convert;
import akka.actor.*;
import akka.routing.RoundRobinPool;
import pocminer.PlotGenerator;
import pocminer.util.MiningPlot;

public class GenerateSupr extends UntypedActor {

	GenParams params = null;
	ActorRef workers = null;
	long currentNonce;
	long recvresults;
	byte[] outbuffer;
	
	FileOutputStream out;
	
	public GenerateSupr(GenParams params) {
		super();
		this.params = params;
	}
	
	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof PlotGenerator.msgGenerateResult) {
			recvresults++;
			processPlot(((PlotGenerator.msgGenerateResult)message).plot,
					    ((PlotGenerator.msgGenerateResult)message).nonce);
			if(recvresults >= params.staggeramt) {
				System.out.println("Writing from nonce " + currentNonce);
				out.write(outbuffer);
				currentNonce += params.staggeramt;
				
				if(currentNonce < params.startnonce + params.plots) {
					sendWork();
				}
				else {
					out.close();
					getContext().system().shutdown();
				}
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
	
	private void init() {
		workers = getContext().actorOf(new RoundRobinPool(params.threads).props(Props.create(PlotGenerator.class)));
		currentNonce = params.startnonce;
		outbuffer = new byte[(int) (params.staggeramt * MiningPlot.PLOT_SIZE)];
		
		String outname = Convert.toUnsignedLong(params.addr);
		outname += "_";
		outname += String.valueOf(params.startnonce);
		outname += "_";
		outname += String.valueOf(params.plots);
		outname += "_";
		outname += String.valueOf(params.staggeramt);
		
		try {
			File folder = new File("plots");
			if(!folder.exists()) {
				folder.mkdir();
			}
			out = new FileOutputStream(new File("plots/" + outname), false);
		} catch (FileNotFoundException e) {
			System.out.println("Failed to open file" + outname + "for writing");
			e.printStackTrace();
			getContext().system().shutdown();
		}
		
		sendWork();
	}
	
	private void processPlot(MiningPlot p, long nonce) {
		long off = nonce - currentNonce;
		for(int i = 0; i < MiningPlot.SCOOPS_PER_PLOT; i++) {
			System.arraycopy(p.data,
							 i * MiningPlot.SCOOP_SIZE,
							 outbuffer,
							 (int) ((i * MiningPlot.SCOOP_SIZE * params.staggeramt) + (off * MiningPlot.SCOOP_SIZE)),
							 MiningPlot.SCOOP_SIZE);
		}
	}
	
	private void sendWork() {
		recvresults = 0;
		System.out.println("Generating from nonce: " + currentNonce);
		for(long i = 0; i < params.staggeramt; i++) {
			workers.tell(new PlotGenerator.msgGenerate(params.addr, currentNonce + i), getSelf());
		}
	}
	
	public static class GenParams {
		public long addr;
		public long startnonce;
		public long plots;
		public long staggeramt;
		public int threads;
		
		public GenParams(long addr, long startnonce, long plots, long staggeramt, int threads) {
			this.addr = addr;
			this.startnonce = startnonce;
			this.plots = plots;
			this.staggeramt = staggeramt;
			this.threads = threads;
		}
	}
}

package pocminer;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

import akka.actor.ActorRef;
import akka.actor.UntypedActor;
import pocminer.Miner;
import pocminer.util.MiningPlot;

public class ScoopReader extends UntypedActor {

	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof msgReadScoops) {
			readFile((msgReadScoops) message, getSender());
		}
		else {
			unhandled(message);
		}
	}
	
	private void readFile(msgReadScoops rs, ActorRef sender) {
		try(RandomAccessFile f = new RandomAccessFile(new File("plots/" + rs.filename), "r")) {
			long chunks = rs.plots / rs.staggeramt;
			for(long i = 0; i < chunks; i++) {
				f.seek((i * rs.staggeramt * MiningPlot.PLOT_SIZE) + (rs.scoopnum * rs.staggeramt * MiningPlot.SCOOP_SIZE));
				byte[] chunk = new byte[(int) (rs.staggeramt * MiningPlot.SCOOP_SIZE)];
				f.readFully(chunk);
				sender.tell(new msgScoopChunk(rs.address, rs.startnonce + (i * rs.staggeramt), rs.staggeramt, chunk), getSelf());
			}
		} catch (FileNotFoundException e) {
			System.out.println("Cannot open file: " + rs.filename);
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("Error reading file: " + rs.filename);
		}
	}
	
	public static class msgReadScoops {
		public String filename;
		public long address;
		public long startnonce;
		public long plots;
		public long staggeramt;
		public int scoopnum;
		public msgReadScoops(Miner.PlotInfo pi, int scoopnum) {
			this.filename = pi.filename;
			this.address = pi.address;
			this.startnonce = pi.startnonce;
			this.plots = pi.plots;
			this.staggeramt = pi.staggeramt;
			this.scoopnum = scoopnum;
		}
	}
	
	public static class msgScoopChunk {
		public long address;
		public long startnonce;
		public long numscoops;
		public byte[] scoops;
		public msgScoopChunk(long address, long startnonce, long numscoops, byte[] scoops) {
			this.address = address;
			this.startnonce = startnonce;
			this.numscoops = numscoops;
			this.scoops = scoops;
		}
	}

}

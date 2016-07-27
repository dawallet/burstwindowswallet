package pocminer;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import nxt.crypto.Crypto;
import nxt.util.Convert;
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;
import pocminer.GenerateSupr;
import pocminer.MinerSupr;

public class POCMiner {

	public static void main(String[] args) {
		if(args.length < 1) {
			System.out.println("pocminer");
			System.out.println("generate data:");
			System.out.println("pocminer generate pubaddress startnonce plots staggeramt threads");
			System.out.println("mine:");
			System.out.println("pocminer mine http://ip:port");
			System.out.println("dump addresses");
			System.out.println("pocminer dumpaddr");
			return;
		}

		String action = args[0];
		switch(action) {
		case "generate":
			if(args.length < 6) {
				System.out.println("missing args");
				return;
			}
			if(Long.parseLong(args[4]) < 0 || Long.parseLong(args[4]) > 8191) {
				System.out.println("staggeramt must be 1-8191");
				return;
			}
			startGenerate(Convert.parseUnsignedLong(args[1]),
						  Long.parseLong(args[2]),
						  Long.parseLong(args[3]),
						  Long.parseLong(args[4]),
						  Integer.parseInt(args[5]));
			break;
		case "mine":
			if(args.length < 2) {
				System.out.println("missing args");
				return;
			}
			startMining(args[1]);
			break;
		case "dumpaddr":
			dumpAddresses();
			break;
		default:
			System.out.println("invalid action");
			break;
		}
	}
	
	private static void startGenerate(long addr, long startnonce, long plots, long staggeramt, int threads) {
		ActorSystem system = ActorSystem.create();
		ActorRef gensupr = system.actorOf(Props.create(GenerateSupr.class, new GenerateSupr.GenParams(addr, startnonce, plots, staggeramt, threads)));
	}
	
	private static void startMining(String addr) {
		ActorSystem system = ActorSystem.create();
		ActorRef minesupr = system.actorOf(Props.create(MinerSupr.class, addr));
	}
	
	private static void dumpAddresses() {
		try {
			List<String> passphrases = Files.readAllLines(Paths.get("passphrases.txt"), Charset.forName("US-ASCII"));
			for(String ps : passphrases) {
				if(!ps.isEmpty()) {
					byte[] publicKey = Crypto.getPublicKey(ps);
					byte[] publicKeyHash = Crypto.sha256().digest(publicKey);
					Long id = Convert.fullHashToId(publicKeyHash);
					System.out.println("Found address: " + ps + " -> " + Convert.toUnsignedLong(id));
				}
			}
		} catch (IOException e) {
			System.out.println("Error: no passphrases.txt found");
		}
	}

}

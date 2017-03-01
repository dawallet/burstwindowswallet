package pocminer_pool;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.eclipse.jetty.util.ssl.SslContextFactory;

import akka.actor.UntypedActor;
import akka.actor.Cancellable;
import scala.concurrent.duration.Duration;
import pocminer_pool.MinerSupr;
import nxt.util.Convert;

public class MinerCom extends UntypedActor {

	String addr;
	
	Cancellable tick = null;
	HttpClient client = null;
	SslContextFactory sslctx = null;
	
	MinerSupr.NetState laststate = null;
	
	public MinerCom(String addr) {
		super();
		this.addr = addr;
	}
	
	@Override
	public void onReceive(Object message) throws Exception {
		if(message instanceof msgRefreshNetState) {
			// get new state
			String netstatetext = null;
			try {
				ContentResponse response = client.newRequest(addr + "/burst?requestType=getMiningInfo").timeout(3, TimeUnit.SECONDS).send();
				netstatetext = response.getContentAsString();
			}
			catch(Exception e) {
				System.out.println("Error: Unable to get mining info from wallet");
				return;
			}
			JSONObject netstatejson = (JSONObject)JSONValue.parse(netstatetext);
			if(!netstatejson.containsKey("height") || !netstatejson.containsKey("generationSignature") || !netstatejson.containsKey("baseTarget")) {
				System.out.println("Error: Invalid json received");
				return;
			}
			String gsig = (String)netstatejson.get("generationSignature");
			if(gsig.length() != 64) {
				System.out.println("Invalid gensig received");
				return;
			}
			String h = (String)netstatejson.get("height");
			String bT = (String)netstatejson.get("baseTarget");
			
			byte[] b = Convert.parseHexString(gsig);
			long height = Convert.parseUnsignedLong(h);
			long baseTarget = Long.valueOf(bT);
			/*MinerSupr.NetState state = new MinerSupr.NetState(height, b, baseTarget, targetDeadline);
			if(laststate == null || state.height != laststate.height || !(Arrays.equals(state.gensig, laststate.gensig))) {
				laststate = state;
				getContext().parent().tell(state, getSelf());
				System.out.println(netstatetext);
			}*/
		}
		else if(message instanceof MinerSupr.msgSubmitResult) {
			System.out.println("Submitting local share");
			try {
				ContentResponse response = client.POST(addr + "/burst")
						.param("requestType", "submitNonce")
						.param("secretPhrase", ((MinerSupr.msgSubmitResult)message).passPhrase)
						.param("nonce", Convert.toUnsignedLong(((MinerSupr.msgSubmitResult)message).nonce))
						.timeout(5, TimeUnit.SECONDS)
						.send();
				String submitResult = response.getContentAsString();
				System.out.println(submitResult);
			}
			catch(Exception e) {
				System.out.println("Error: Failed to submit nonce");
			}
		}
		else {
			unhandled(message);
		}
	}
	
	@Override
	public void preStart() {
		sslctx = new SslContextFactory(true);
		client = new HttpClient(sslctx);
		try {
			client.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*tick = getContext().system().scheduler().schedule(Duration.Zero(),
				Duration.create(5, TimeUnit.SECONDS),
				getSelf(),
				(Object)new msgRefreshNetState(),
				getContext().system().dispatcher(),
				null);*/
	}
	
	@Override
	public void postStop() {
		if(tick != null) {
			tick.cancel();
			tick = null;
		}
		if(client != null) {
			client = null;
		}
	}
	
	public static class msgRefreshNetState {}
}

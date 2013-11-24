import java.io.IOException;


public class Invoker {

	public static void inicialize(int port) throws IOException{
		byte[]obj = ServerRequestHandler.waitRequest(port);
	}
	
}

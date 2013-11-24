import java.io.IOException;


public class Invoker{

	public static void inicialize(int port) throws IOException, ClassNotFoundException{
		byte[]obj = ServerRequestHandler.waitRequest(port);
		String h = (String) Marshaller.deserialize(obj);
		System.out.println(h);
		
	}
	
	public static void main(String[]args) throws ClassNotFoundException, IOException{
		Invoker.inicialize(2000);
	}
	
}

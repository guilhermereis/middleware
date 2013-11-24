import java.io.IOException;


public class Requestor {

	public static void main(String[] args) throws IOException {
		String send = "chegou";
		byte[] s = Marshaller.serialize(send);
		ClientRequestHandler.sendObj(s);

	}

}

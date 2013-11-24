import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;


public class ServerRequestHandler {

	private static ServerSocket socket;
	private static Socket client;

	public static byte[] waitRequest(int port) throws IOException{
		socket = new ServerSocket(port);
		return (readBytes());
	}

	public static void sendReply(byte[] obj) throws IOException{
		sendBytes(obj, 0, obj.length);
	}

	private static void sendBytes(byte[] obj, int start, int len) throws IOException {

		OutputStream out = client.getOutputStream(); 
		DataOutputStream dos = new DataOutputStream(out);

		dos.writeInt(len);

		if (len > 0) {
			dos.write(obj, start, len);
		}
		
		client.close();

	}

	private static byte[] readBytes() throws IOException {

		client = socket.accept();

		InputStream in = client.getInputStream();
		DataInputStream dis = new DataInputStream(in);

		int len = dis.readInt();
		byte[] data = new byte[len];

		if (len > 0) {
			dis.readFully(data);
		}

		return data;

	}

}

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;


public class ServerRequestHandler {
	
	private static ServerSocket socket;
	
	public static byte[] sendObj(byte[] obj) throws IOException{
		socket = new Socket("localhost",2000);
		sendBytes(obj, 0, obj.length);
		return (readBytes());
	}

	private static void sendBytes(byte[] obj, int start, int len) throws IOException {
		
	    OutputStream out = socket.getOutputStream(); 
	    DataOutputStream dos = new DataOutputStream(out);

	    dos.writeInt(len);
	    
	    if (len > 0) {
	        dos.write(obj, start, len);
	    }
	    
	}
	
	private static byte[] readBytes() throws IOException {
	  
	    InputStream in = socket.getInputStream();
	    DataInputStream dis = new DataInputStream(in);

	    int len = dis.readInt();
	    byte[] data = new byte[len];
	    
	    if (len > 0) {
	        dis.readFully(data);
	    }
	    
	    return data;
	}

}

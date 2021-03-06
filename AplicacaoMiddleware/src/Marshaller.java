import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;


public class Marshaller {
 
 public static byte[] serialize(Object obj) throws IOException {
        ByteArrayOutputStream byteOutStream = new ByteArrayOutputStream();
        ObjectOutputStream objOutStream = new ObjectOutputStream(byteOutStream);
        objOutStream.writeObject(obj);
        return byteOutStream.toByteArray();
    }

    public static Object deserialize(byte[] obj) throws IOException, ClassNotFoundException {
        ByteArrayInputStream byteInStream = new ByteArrayInputStream(obj);
        ObjectInputStream objInStream = new ObjectInputStream(byteInStream);
        return objInStream.readObject();
    }

}
package gateway;

import javax.persistence.*;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by dean on 2017/3/17.
 */ // 一个网关可连最多64个Zigbee节点
// 一个Zigbee节点最多接32个传感器或线圈
@Entity
@Table(name = "T_ZIGBEE_NODE")
class ZigbeeNode {
    private static final byte SENSORS_PER_NODE = 8;
    private static final byte REGISTERS_PER_SENSOR = 2;
    private static final byte BYTES_PER_REGISTER = 2;
    @Column(name = "NODE_ADDR")
    byte deviceAddr;
    @Column(name = "NODE_NAME")
    String nodeName;
    @OneToMany(targetEntity = CoilOrSensor.class, mappedBy = "node")
    List<CoilOrSensor> coilOrSensors;
    boolean online;
    boolean valid;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    public ZigbeeNode() {
    }

    public ZigbeeNode(byte deviceAddr, String nodeName) {
        this.coilOrSensors = new ArrayList<>();
        this.deviceAddr = deviceAddr;
        this.nodeName = nodeName;
    }


    public Long getId() {
        return id;
    }

    public byte getDeviceAddr() {
        return deviceAddr;
    }

    public String getNodeName() {
        return nodeName;
    }

    public List<CoilOrSensor> getCoilOrSensors() {
        return coilOrSensors;
    }


    public void dumpSensors() {
        for (CoilOrSensor sensor : coilOrSensors) {
            System.out.println(nodeName + ":" + Integer.toHexString(deviceAddr) + "\t" + sensor.toString());
        }
    }

    /**
     * 读取某个节点个的所有传感器或线圈值,只读前8个，因为一般节点只有几个传感器
     */
    public void readNodeSensors(OutputStream out, DataInputStream in) throws IOException {
        byte[] command = ModbusTCPPacket.NewCommandPacket(deviceAddr,
                FunctionCode.ReadNodeSensors.code,
                (new byte[]{0x00, 0x00, 0x00, REGISTERS_PER_SENSOR * SENSORS_PER_NODE })).toByteArray();
        out.write(command);
        out.flush();
        ModbusTCPPacket response = ModbusTCPPacket.ReadResponsePacket(in);
        if (response.function != FunctionCode.ReadNodeSensors.code) {
            throw new IOException("Invalid response, function code " + response.function);
        }
        parseNodeSensors(response);
    }

    private void parseNodeSensors(ModbusTCPPacket packet) throws IOException {
        int bytesPerSensor = BYTES_PER_REGISTER*REGISTERS_PER_SENSOR;
        int byteCount = packet.data[0];
        if (byteCount / SENSORS_PER_NODE !=  bytesPerSensor) {
            throw new IOException("invalid response byte count");
        }
        for (int i = 0; i < SENSORS_PER_NODE; i++) {
            int startIndex = i*bytesPerSensor+1;
            coilOrSensors.add(new CoilOrSensor(this, Arrays.copyOfRange(packet.data, startIndex,
                    startIndex+ bytesPerSensor)));
        }
    }

    /**
     * 写某个节点的某个线圈值
     * type : A1, A2....
     */
    public void writeCoil(OutputStream out, DataInputStream in, int channel, int type, boolean on) throws IOException {
        byte[] command;
        if (on) {
            command = ModbusTCPPacket.NewCommandPacket(deviceAddr, FunctionCode.WriteCoils.code,
                    (new byte[]{0x00, (byte) channel, 0x00, 0x02, 0x04, (byte) type, 0x40, (byte) 0xff, (byte) 0xff})).toByteArray();
        } else {
            command = ModbusTCPPacket.NewCommandPacket(deviceAddr, FunctionCode.WriteCoils.code,
                    (new byte[]{0x00, (byte) channel, 0x00, 0x02, 0x04, (byte) type, 0x40, (byte) 0x00, (byte) 0x00})).toByteArray();
        }
        out.write(command);
        out.flush();
        ModbusTCPPacket response = ModbusTCPPacket.ReadResponsePacket(in);
        if (response.function == FunctionCode.WriteCoils.code) {
            return;
        } else {
            throw new IOException("failed to write coil state");
        }

    }

    void persist() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("hello");
        EntityManager entityManager = factory.createEntityManager();
        entityManager.getTransaction().begin();
        entityManager.persist(this);
        this.coilOrSensors.forEach(coilOrSensor -> {
            entityManager.persist(coilOrSensor);
        });
        entityManager.getTransaction().commit();

    }
}

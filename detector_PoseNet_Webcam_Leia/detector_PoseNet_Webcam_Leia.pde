import java.util.Map;
import oscP5.*;
import netP5.*;
OscP5 oscP5;

NetAddress myRemoteLocation;
Detector detector = new Detector();

Pose[] poses = new Pose[0];
int nPoses = 0;

void setup() {
  size(640, 480);
  OscProperties myProperties = new OscProperties();
  myProperties.setDatagramSize(10000); 
  myProperties.setListeningPort(9527);
  myProperties.setRemoteAddress("127.0.0.1", 1000);
  
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);

  oscP5 = new OscP5(this, myProperties);
  oscP5.plug(this,"parseData","/poses/xml");
}

void draw() {
  background (180);
  detector.detectar(poses, nPoses);
  //ellipse(width - detector.x, detector.y, 15, 15);
}

public void parseData(String data) {
  // Recibir y acomodar data recibida por OSC
  XML xml = parseXML(data);
  nPoses = xml.getInt("nPoses");
  int w = xml.getInt("videoWidth");
  int h = xml.getInt("videoHeight");

  if (w != width || h != height) {
    surface.setSize(w, h);
  }

  poses = new Pose[nPoses];
  XML[] xmlposes = xml.getChildren("pose");
  for (int i = 0; i < xmlposes.length; i++) {
    XML[] xmlkeypoints = xmlposes[i].getChildren("keypoint");

    poses[i] = new Pose();
    poses[i].score = xmlposes[i].getFloat("score");

    for (int j = 0; j < xmlkeypoints.length; j++) {
      Keypoint kpt = new Keypoint();

      kpt.position.x = xmlkeypoints[j].getFloat("x");
      kpt.position.y = xmlkeypoints[j].getFloat("y");
      kpt.score = xmlkeypoints[j].getFloat("score");

      poses[i].keypoints.put(xmlkeypoints[j].getString("part"), kpt);
    }
  }
}

public class Keypoint{
  PVector position;
  float score;
  public Keypoint(){
    this.position = new PVector(0,0);
    this.score = 0;
  }
}
public class Pose{
  HashMap<String,Keypoint> keypoints;
  float score;
  public Pose(){
    this.keypoints = new HashMap<String,Keypoint>();
    this.score = 0;
  }
}

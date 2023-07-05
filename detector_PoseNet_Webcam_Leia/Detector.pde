class Detector {
  boolean haciendoPose = false;
  Posicion pose1 = new Posicion();

  Detector() {
  }

  void detectar(Pose[] poses, int nPoses) {
    if (nPoses > 0) {
      // si detecta persona
      HashMap<String, Keypoint> keypoints;
      try {
        keypoints = poses[0].keypoints; // guarda puntos
        haciendoPose = pose1.estaOcurriendo(keypoints);
        if(!haciendoPose){        
          text("no estoy haciendo pose", width/2, height/2);
        } else {
          text("estoy haciendo pose", width/2, height/2);
        }
        
      }
      catch(Exception e) {
        println(e.toString());
        return;
      }
    }
  }


  ////////
}

class Posicion {
  Timer timer;

  PVector ojoD;
  float ojoDConfianza;
  PVector ojoI;
  float ojoIConfianza;

  Posicion() {
    timer = new Timer(2);
  }

  boolean estaOcurriendo(HashMap<String, Keypoint> keypoints) {
    String texto = "";
    text(texto, width/2, height/2);
    
    if (!keypoints.containsKey("rightEye") || !keypoints.containsKey("leftEye")) {
      // no están las partes que busco
      println("?");
      return false;
    } else {
      // Guardo la posición de de las partes que me interesan y la confianza en su detección
      ojoD = keypoints.get("rightEye").position;
      ojoDConfianza = keypoints.get("rightEye").score;
      ojoI = keypoints.get("leftEye").position;
      ojoIConfianza = keypoints.get("leftEye").score;

      if (ojoD.y > ojoI.y) {
        // estoy haciendo pose
        return true;
      } else {
        // no estoy haciendo pose
        return false;
      }
    }
    
  }

  ////////
}

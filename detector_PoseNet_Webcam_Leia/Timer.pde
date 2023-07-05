class Timer {
  int espera;
  int time;

  Timer(int espera_) {
    espera = espera_*1000;
  }

  void guardarTiempo() {
    time = millis();
  }

  boolean pasoElTiempo() {
    if (millis() - time >= espera) {
      return true;
    }
    return false;
  }

  ////
}

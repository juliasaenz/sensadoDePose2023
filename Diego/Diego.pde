import processing.video.*;

Capture video;

color trackColor1;
float threshold1 = 25;
color trackColor2;
float threshold2 = 25;
ArrayList<PVector> ellipse1Positions;
ArrayList<PVector> ellipse2Positions;

ArrayList<Particula> particulas; 
float x1, y1, x2, y2;
float avgX1 = -50;
float avgY1 = -50;
float avgX2 = -50;
float avgY2 = -50;


void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[0]);
  video.start();
  trackColor1 = color(0, 0, 250);
  ellipse1Positions = new ArrayList<PVector>();
  ellipse2Positions = new ArrayList<PVector>();
  
  particulas = new ArrayList<Particula>();
  trackColor2 = color(200, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  x1 = avgX1;
  y1 = avgY1;
  x2 = avgX2;
  y2 = avgY2;

  background(255);
  translate(width, 0);
  scale (-1, 1);
  video.loadPixels();
  image(video, 0, 0);
  
  for (Particula p : particulas) {
    noStroke();
    fill(p.colorcito);
    float x2= p.x;
    float y2 = p.y;
    ellipse(x2, y2, 24, 24);
  }
  
  //---------------------Fijo
  threshold1 = 80;
  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor1);
      float g2 = green(trackColor1);
      float b2 = blue(trackColor1);

      float d = distSq(r1, g1, b1, r2, g2, b2);

      if (d < threshold1*threshold1) {
        //stroke(255);
        //strokeWeight(1);
        //point(x, y);
        avgX1 += x;
        avgY1 += y;
        count++;
        color c = color(0,0,255);
        particulas.add(new Particula(x1, y1, c )); // acá estoy agregando la particula azul
      }
    }
  }

  // We only consider the color found if its color distance is less than 10.
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 0) {
    avgX1 = avgX1 / count;
    avgY1 = avgY1 / count;
    // Draw a circle at the tracked pixel
    // ACÁ DIBUJA LOS CIRCULOS
  }


  threshold2 = 80;  // Ajusta el umbral para la detección del color rojo

  int count2 = 0;


  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor2);
      float g2 = green(trackColor2);
      float b2 = blue(trackColor2);

      float d = distSq(r1, g1, b1, r2, g2, b2);

      if (d < threshold2*threshold2) {
        avgX2 += x;
        avgY2 += y;
        count2++;
        color c = color(255,0,0);
        particulas.add(new Particula(x2, y2, c )); // acá estoy agregando la particula roja
      }
    }
  }

  if (count2 > 0) {
    avgX2 = avgX2 / count2;
    avgY2 = avgY2 / count2;
  }
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

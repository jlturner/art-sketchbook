PShape logo;
PGraphics logoMask;
import processing.pdf.*;

Flock flock;

void setup() {
  size(1000,500);
  beginRecord(PDF, "output.pdf");
  
  logo  = loadShape("urx-logo.svg");
  logo.disableStyle();
  logo.scale((width/2.0) / logo.width);
  
  logoMask = createGraphics(width, height);
  logoMask.beginDraw();
  logoMask.background(0);
  logoMask.translate(((width/2) / 8) + width /2, height/4 + height / 16);
  logoMask.scale(0.75);
  logoMask.fill(255);
  logoMask.shape(logo);
  logoMask.endDraw();
  
  smooth();
  background(color(255));
  
  flock = new Flock();
  for(int i = 0; i < 50; i++) {
    flock.addBoid(new Boid(random(width), height));
  }
}

void draw() {
  flock.run();
}

void mousePressed() {
 endRecord();
 exit(); 
}

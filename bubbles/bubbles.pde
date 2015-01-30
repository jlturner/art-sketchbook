class Bubble {
 float x, y, r, distanceRemaining;
 Bubble(float x, float y, float r) {
  this.x = x;
  this.y = y;
  this.r = r;
  this.distanceRemaining = r;
 }
 void draw() {
   boolean isOverLogo = false;
  if(logoMask.get(int(x), int(y)) == color(255)) {
    isOverLogo = true;
   }
  pushMatrix();
  int z = -1;
  if(isOverLogo) {
    z = 1;
  }
  translate(x, y, z);
  pushStyle();
  noFill();
  if(isOverLogo) {
   int variance = int(random(30));
   fill(variance, 121 + variance, 255); 
   noStroke();
  }
  ellipse(-r/2,-r/2, r, r);
  popStyle();
  popMatrix(); 
 }
}

ArrayList<Bubble> bubbles;
PShape logo;
PGraphics logoMask;

void setup() {
  size(500,500,OPENGL);
  
  logo  = loadShape("urx-logo.svg");
  logo.disableStyle();
  logo.scale(width / logo.width);
  
  logoMask = createGraphics(width, height);
  logoMask.beginDraw();
  logoMask.background(0);
  logoMask.translate(0, height/4 + height / 16);
  logoMask.scale(0.75);
  logoMask.fill(255);
  logoMask.shape(logo);
  logoMask.endDraw();
  
  smooth();
  background(color(255));
  bubbles = new ArrayList<Bubble>();
  for(int i = 0; i < 100; i++) {
   bubbles.add(new Bubble(random(width), random(height), 20 + random(60))); 
  }
}

void draw() {
  for(Bubble bubble : bubbles) {
   bubble.draw(); 
  }
}

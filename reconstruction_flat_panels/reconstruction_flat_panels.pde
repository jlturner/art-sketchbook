class Block {
  float x, y, z, rotation, w, h, d;
  int brightness;
  Block(float x, float y, float z, float rotation, float w, float h, float d, int brightness) {
   this.x = x;
   this.y = y;
   this.z = z;
   this.rotation = rotation;
   this.w = w;
   this.h = h;
   this.d = d;
   this.brightness = brightness;
  }
  void draw() {
   pushMatrix();
   translate(x, y, z);
   rotateY(rotation);
   pushStyle();
   fill(brightness, 50);
   if(logoMask.get(int(x), int(y)) == color(255)) {
    int variance = int(random(30));
    fill(variance, 121 + variance, 255); 
   }
   box(w, h, d);
   popStyle();
   popMatrix(); 
  }
}

ArrayList<Block> b; 
PShape logo;
PGraphics logoMask;

void setup() {
  size(5000,5000,OPENGL); 
  b = new ArrayList<Block>();
  logo  = loadShape("urx-logo.svg");
  logo.disableStyle();
  logo.scale(width / logo.width);
  
  logoMask = createGraphics(width, height);
  logoMask.beginDraw();
  logoMask.background(0);
  logoMask.translate(0, height/4 + height / 16);
  logoMask.fill(255);
  logoMask.shape(logo);
  logoMask.endDraw();
  
  for(int i = 0; i < 5000; i++) {
   b.add(new Block(random(width), random(height), random(200), (random(100) < 50 ? -PI/4 : PI), 10, 200, 100, int(random(150)) + 75)); 
  }
  background(255);
  smooth();
  noStroke();
  noLoop();
}

void draw() {
  lights();
  fill(0);
  rect(0, height/4, width, height/2);
  for(Block bl : b) { bl.draw(); }
  save("output.png");
}

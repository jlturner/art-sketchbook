class Region {
 float x, y, colorNumber;
 Region(float x, float y) {
  this.x = x;
  this.y = y;
  this.colorNumber = noise(x, y);
 }
 float distanceTo(float x, float y){
   return sqrt(sq(this.x - x) + sq(this.y - y));
 }
}

ArrayList<Region> regions;
PShape logo;
PGraphics logoMask;

void setup() {
  size(5000,5000);
  
  logo  = loadShape("urx-logo.svg");
  logo.disableStyle();
  logo.scale(width / logo.width);
  
  logoMask = createGraphics(width, height);
  logoMask.beginDraw();
  logoMask.background(0);
  logoMask.translate(width / 8, height/4 + height / 16);
  logoMask.scale(0.75);
  logoMask.fill(255);
  logoMask.shape(logo);
  logoMask.endDraw();
  
  smooth();
  background(color(255));
  regions = new ArrayList<Region>();
  for(int i = 0; i < 500; i++) {
   regions.add(new Region(random(width), random(height))); 
  }
  noLoop();
}

void draw() {
  PGraphics output = createGraphics(width,height);
  output.loadPixels();
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
     color c;
     float distanceToClosestRegion = Float.MAX_VALUE;
     Region closestRegion = null;
     for(Region r : regions) {
       float distance = r.distanceTo(x,y);
       if(distance < distanceToClosestRegion) {
         closestRegion = r;
         distanceToClosestRegion = distance;
       } 
     }
     c = color(map(closestRegion.colorNumber, 0.0, 1.0, 150, 0));
     if(logoMask.pixels[y * width + x] == color(255)) {
       int variance = round(map(closestRegion.colorNumber, 0.0, 1.0, 0, 150));
       c = color(variance, 120 + variance, 200 + variance);
     }
     output.pixels[y * width + x] = c;
   } 
   println(y);
  }
  output.updatePixels();
  output.save("output.png");
}

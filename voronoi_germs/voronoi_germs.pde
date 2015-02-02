class Region {
 float x, y;
 Region(float x, float y) {
  this.x = x;
  this.y = y;
 }
 float distanceTo(float x, float y){
   // Use cheaper manhattan distance calculation
   return sqrt(sq(this.x - x) + sq(this.y - y));
   //return abs(this.x - x) + abs(this.y - y);
   //return sqrt(pow((this.x - x) + (this.y - y),2));
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
     float distanceToClosestRegion = width;
     for(Region r : regions) {
       float distance = r.distanceTo(x,y);
       if(distance < distanceToClosestRegion) {
        distanceToClosestRegion = distance;
       } 
     }
     c = color(map(distanceToClosestRegion, 0, 120, 150, 0));
     if(logoMask.pixels[y * width + x] == color(255)) {
       int variance = round(map(distanceToClosestRegion, 0, 120, 150, -50));
       c = color(variance, 120 + variance, 200 + variance);
     }
     output.pixels[y * width + x] = c;
   } 
   println(y);
  }
  output.updatePixels();
  output.save("output.png");
}

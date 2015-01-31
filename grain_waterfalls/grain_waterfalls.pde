class Region {
 float x, y;
 Region(float x, float y) {
  this.x = x;
  this.y = y;
 }
 float distanceTo(float x, float y){
   return sqrt(sq(this.x - x) + (this.y - y));
 }
}

ArrayList<Region> regions;
PShape logo;
PGraphics logoMask;

void setup() {
  size(5000,5000,OPENGL);
  
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
  for(int i = 0; i < 2000; i++) {
   regions.add(new Region(random(width), random(height))); 
  }
  noLoop();
}

void draw() {
  for(int x = 0; x < width; x++) {
   for(int y = 0; y < height; y++) {
     color c;
     float distanceToClosestRegion = width;
     for(Region r : regions) {
       float distance = r.distanceTo(x,y);
       if(distance < distanceToClosestRegion) {
        distanceToClosestRegion = distance;
       } 
     }
     c = color(map(distanceToClosestRegion, 0, 100, 0, 255));
     set(x, y, c);
   } 
  }
  save("output.png");
}

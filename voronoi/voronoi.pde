import megamu.mesh.*;
// http://leebyron.com/mesh/ //

String image_file = "../src/base.jpg";
int countPoints = 1000;

PImage img;
float[][] points = new float[countPoints][2];
color[] colors = new color[countPoints];
Voronoi voronoi;

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(423, 640);
}

void setup() {
  smooth();
  noLoop();
  
  image(img, 0, 0, width, height);
  loadPixels();
  
  for(int i = 0; i < countPoints; i++){
    points[i][0] = random(width);
    points[i][1] = random(height);
    colors[i] = pixels[floor(points[i][1]) * width + floor(points[i][0])];
  }
  voronoi = new Voronoi(points);
}

void draw() {
  noStroke();
  MPolygon[] myRegions = voronoi.getRegions();
  for(int i = 0; i < myRegions.length; i++){
    fill(colors[i]);
    myRegions[i].draw(this);
  }
}


void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
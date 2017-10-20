import gab.opencv.*;

PImage img;
PImage imgOut;
OpenCV opencv;
ArrayList <Contour> contours;

void settings(){
 img = loadImage("../src/base.jpg");
 
 //size(1269, 1920);
 print(img.width / 3, img.height / 3);
 size(img.width / 3, img.height / 3);
}

void setup(){
  opencv = new OpenCV(this, width, height);
  background(0);
  smooth();
  img.resize(width, height);
  opencv.loadImage(img);
  
  int threshold = 80;
  opencv.gray();
  opencv.threshold(threshold);
  opencv.findCannyEdges(50, 200);
  
  contours = opencv.findContours();
  
  for (int i = 0; i < contours.size(); i++) {
    beginShape();
    for (PVector point : contours.get(i).getPolygonApproximation().getPoints()) {
      stroke(0, 150, 0);
      fill(0, 50, 0);
      vertex(point.x, point.y);
    }
    endShape();
  }
}

void draw(){

}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
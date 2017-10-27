import megamu.mesh.*;
// http://leebyron.com/mesh/ //

String image_file = "../src/base.jpg";
int countPoints = 500;

PImage img;
int[] mapPixels;
float[][] points = new float[countPoints + 4][3];
ArrayList<int[]> triangles = new ArrayList<int[]>();

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(423, 640);
}

void setup() {
  
  size(423, 640, P3D);
  smooth(8);
  noLoop();
  
  image(img, 0, 0, width, height);
  loadPixels();
  
  points[0][0] = width/2;
  points[0][1] = height/2;
  points[1][0] = width/2;
  points[1][1] = -height/2;
  points[2][0] = -width/2;
  points[2][1] = height/2;
  points[3][0] = -width/2;
  points[3][1] = -height/2;
  for(int i = 4; i < 4 + countPoints; i++){
    points[i][0] = width/2 * random(-1, 1);
    points[i][1] = height/2 * random(-1, 1);
  }
  
  Delaunay delaunay = new Delaunay(points);
  
  for (int i = 0; i < points.length; i++) {
    int[] links = delaunay.getLinked(i);
    for (int j = 0; j < links.length; j++) {
      int[] nearLinks = delaunay.getLinked(links[j]);
      for (int k = 0; k < links.length; k++) {
        for (int l = 0; l < nearLinks.length; l++) {
          if (links[k] == nearLinks[l] && i < links[j] && links[j] < links[k]) {
            triangles.add(new int[]{i, links[j], links[k], 0, 0, 0, 0});
          }
        }
      }
    }
  }
  
  mapPixels = new int[pixels.length];
  for (int i = 0; i < pixels.length; i++) {
    int x = i % width;
    int y = floor(i / width);
    for (int j = 0; j < triangles.size(); j++) {
      int[] triangle = triangles.get(j);
      float x0 = points[triangle[0]][0] + width / 2;
      float y0 = points[triangle[0]][1] + height / 2;
      float x1 = points[triangle[1]][0] + width / 2 - x0;
      float y1 = points[triangle[1]][1] + height / 2 - y0;
      float x2 = points[triangle[2]][0] + width / 2 - x0;
      float y2 = points[triangle[2]][1] + height / 2 - y0;
      float a = (calcDet(x, y, x2, y2) - calcDet(x0, y0, x2, y2)) / calcDet(x1, y1, x2, y2);
      float b = -(calcDet(x, y, x1, y1) - calcDet(x0, y0, x1, y1)) / calcDet(x1, y1, x2, y2);
      
      if (a > 0 && b > 0 && a + b < 1) {
        mapPixels[i] = j;
        break;
      }
    }
  }
  
  for (int i = 0; i < triangles.size(); i++) {
    int triangle[] = triangles.get(i);
    int count = 0;
    int r = 0;
    int g = 0;
    int b = 0;
    for (int j = 0; j < pixels.length; j++) {
      color c = pixels[j];
      if (mapPixels[j] == i) {
        count++;
        r += int(red(c));
        g += int(green(c));
        b += int(blue(c));
      }
    }
    triangle[3] = count + 1;
    triangle[4] = r/triangle[3];
    triangle[5] = g/triangle[3];
    triangle[6] = b/triangle[3];
    triangles.set(i, triangle);
  }
  
}

void draw() {
  translate(width / 2, height / 2);
  
  for (int i = 0; i < triangles.size(); i++) {
    int[] triangle = triangles.get(i);
    int count = 0;
    int switchCount = 1;
    
    while (triangle[3] == 1) {
      if (i + count == triangles.size() - 1) {
        count = 0;
        switchCount = -1;
      }
      count++;
      triangle = triangles.get(i + switchCount * count);
    }
    
    noStroke();
    fill(triangle[4], triangle[5], triangle[6]);
    pushMatrix();
    beginShape();
    for (int k = 0; k < 3; k++){
      vertex(points[triangle[k]][0], points[triangle[k]][1]);
    }
    endShape(CLOSE);
    popMatrix();
  }
}

float calcDet(float _x1, float _y1, float _x2, float _y2) {
  float calc = _x1 * _y2 - _y1 * _x2;
  return calc;
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
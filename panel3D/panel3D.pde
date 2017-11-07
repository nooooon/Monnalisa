PImage img;
int meshSize = 10;
int sizeX;
int sizeY;
int meshZ = 50;
color[][] colors;
float[][] brightness;

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(img.width / 3, img.height / 3, P3D);
}

void setup(){
  background(0);
  smooth();
  image(img, 0, 0, width, height);
  
  loadPixels();
  
  sizeX = int(width/meshSize);
  sizeY = int(height/meshSize);
  brightness = new float[sizeY][sizeX];
  colors = new color[sizeY][sizeX];
  
  for(int j = 0; j < sizeY; j++) {  
    for(int i = 0; i < sizeX; i++) {  
      colors[j][i] = pixels[j * meshSize * width + i * meshSize];
      brightness[j][i] = map(max(red(colors[j][i]), green(colors[j][i]), blue(colors[j][i])), 0, 255, 0, 60);
    }
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  
  ambientLight(80, 80, 80);
  pointLight(255, 255, 255, mouseX, mouseY, 300);
  camera(mouseX, mouseY, 800, width/2.0, height/2.0, 0, 0, 1, 0);
  
  noStroke();

  for(int j = 0; j < sizeY - 1; j++) {  
    for(int i = 0; i < sizeX - 1; i++) {
      fill(colors[j][i], 200);
      pushMatrix();
      beginShape(QUAD);
      translate(i * meshSize, j * meshSize);
      rotateY(radians(brightness[j][i]));
      rotateX(radians(brightness[j][i]));
      vertex(0, 0, meshZ);
      vertex(meshSize, 0, meshZ);
      vertex(meshSize, meshSize, meshZ);
      vertex(0, meshSize, meshZ);
      endShape(CLOSE);
      popMatrix();
    }
  }
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
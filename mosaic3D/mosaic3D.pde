PImage img;
int cubeSize = 20;
float rotX, rotY, rotZ;

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(img.width / 3, img.height / 3, P3D);
}

void setup(){
  //noLoop();
  background(0);
  smooth();
  image(img, 0, 0, width, height);
  
  loadPixels();
}

void draw(){
  background(0);
  
  ambientLight(80, 80, 80);
  pointLight(255, 255, 255, mouseX, mouseY, 300);
  camera(mouseX, mouseY, 500, width/2.0, height/2.0, 0, 0, 1, 0);
  
  for(int j = 0; j < height; j+=cubeSize) {  
    for(int i = 0; i < width; i+=cubeSize) {  
      color c = pixels[j * width + i];
      fill(c, 200);
      pushMatrix();
      translate(i, j);
      noStroke();
      box(20, 20, 20);
      popMatrix();
    }
  }
  
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
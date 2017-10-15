PImage img;
int dotSize = 10;

void settings(){
 img = loadImage("../src/base.jpg");
 
 //size(1269, 1920);
 print(img.width / 3, img.height / 3);
 size(img.width / 3, img.height / 3);
}


void setup(){
  //background(0);
  smooth();
  image(img, 0, 0, width, height);
  
  loadPixels();
  ellipseMode(CENTER);
}


void draw(){
  background(0);
  for(int j = 0; j < height; j+=dotSize) {  
    for(int i = 0; i < width; i+=dotSize) {  
      color c = pixels[j * width + i];
      fill(c, 200);
      pushMatrix();
      translate(i, j);
      noStroke();
      ellipse(0, 0, brightness(c)/255 * 10.0, brightness(c)/255 * 10.0);
      popMatrix();
    }
  }
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
PImage img;
int mosaicSize = 20;

void settings(){
 img = loadImage("../src/base.jpg");
 
 //size(1269, 1920);
 size(img.width / 3, img.height / 3);
}


void setup(){
 
}

void draw(){
  background(0);
  smooth();
  image(img, 0, 0, width, height);
  
  loadPixels();
  for(int j = 0; j < height; j += mosaicSize) {  
    for(int i = 0; i < width; i += mosaicSize) {  
      color c = pixels[j * width + i];
      fill(c);
      noStroke();
      rect(i, j, mosaicSize, mosaicSize);
    }
  }
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
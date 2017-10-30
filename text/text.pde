PImage img;

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(img.width / 3, img.height / 3);
}

void setup(){
  noLoop();
  background(0);
  smooth();
  image(img, 0, 0, width, height);
  
  loadPixels();
}

void draw(){
  
  for(int j = 0; j < 10000; j++){
    textAlign(CENTER);
    textSize(random(30, 72));
    int w = floor(random(width));
    int h = floor(random(height));
    color c = pixels[h * width + w];
    fill(c);
    text(int(random(10)), w, h);
  }
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
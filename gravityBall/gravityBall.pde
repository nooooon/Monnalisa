import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PImage img;
Box2DProcessing box2d;
ArrayList<Ball> balls;
ArrayList<Wall> walls;
int dotSize = 15;

void settings(){
 img = loadImage("../src/base.jpg");
 
 size(img.width / 3, img.height / 3, P3D);
}

void setup(){
  smooth(8);
  image(img, 0, 0, width, height);

  loadPixels();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -9.8);
  
  //wall
  walls = new ArrayList<Wall>();
  walls.add(new Wall(width/2, height + 10, width, 10));
  walls.add(new Wall(-10, height/2, 10, height));
  walls.add(new Wall(width + 10, height/2, 10, height));
  
  balls = new ArrayList<Ball>();
  
  for(int j = 0; j < height; j+=dotSize) {  
    for(int i = 0; i < width; i+=dotSize) {  
      color c = pixels[j * width + i];
      Ball p = new Ball(i, j - 100, dotSize, c);
      balls.add(p);
    }
  }
}

void draw(){
  background(0);

  box2d.step();

  for(Ball b: balls){
    b.display();
  }

  for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.done()) {
      balls.remove(i);
    }
  }
  
  for (Wall wall: walls) {
    wall.display();
  }
}

void keyPressed(){
  if(key == ' '){
    save("screenshot.png");
  }
}
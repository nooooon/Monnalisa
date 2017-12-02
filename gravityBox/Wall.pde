class Wall {
  
  float _x;
  float _y;
  float _w;
  float _h;
  
  Body body;
  
  Wall(float x, float y, float w, float h){
    _x = x;
    _y = y;
    _w = w;
    _h = h;
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    println(box2dW, box2dH);
    ps.setAsBox(box2dW, box2dH);
    
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.STATIC;
    bodyDef.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bodyDef);
    
    body.createFixture(ps, 1);
  }
  
  void display(){
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(_x, _y, _w, _h);
  }
}
class Box{
  Body body;
  
  float _size;
  color _c;

  Box(float x, float y, float size, color c){
    _size = size;
    _c = c;
    makeBody(new Vec2(x, y), _size, _size);
  }

  void kill(){
    box2d.destroyBody(body);
  }

  boolean done(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height + _size * _size) {
      kill();
      return true;
    }
    return false;
  }

  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(_c);
    noStroke();
    rect(0, 0, _size, _size);
    popMatrix();
  }

  void makeBody(Vec2 center, float w, float h) {

    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w / 2);
    float box2dH = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}
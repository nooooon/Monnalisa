class Ball{
  Body body;
  
  float _size;
  color _c;

  Ball(float x, float y, float size, color c){
    _size = size/2;
    _c = c;
    makeBody(new Vec2(x, y));
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

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(_c);
    noStroke();
    ellipse(0, 0, _size*2, _size*2);
    popMatrix();
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(_size);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-1, 1));
  }
}
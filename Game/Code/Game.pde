  Circle c1;
  Circle c2;
  Rectangle r1;
  Rectangle r2;

void setup (){
  c1 = new Circle(new PVector(width/2,height/2), 1, 1, false, 50);
  c2 = new Circle(new PVector(width/3,height/3), 1, 1, false, 50);
  r1 = new Rectangle(new PVector(width/2,height/3), 1, 1, false, 50, 50);
  r2 = new Rectangle(new PVector(width/3,height/2), 1, 1, false, 50, 50);
  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  background(51);
  if(Collisions.intersect(r1, c1) || Collisions.intersect(r1, c2) || Collisions.intersect(r1,r2)){
    fill(255,0,0);
  } else {
    fill(0, 255, 0);
  }
  circle(c1.getCoorX(), c1.getCoorY(), c1.getRadius()*2); 
  circle(c2.getCoorX(), c2.getCoorY(), c2.getRadius()*2); 
  rect(r1.getPosition().x, r1.getPosition().y, r1.getWidth(), r1.getHeight());
  rect(r2.getPosition().x, r2.getPosition().y, r2.getWidth(), r2.getHeight());
  
}

void keyPressed() {
  if(keyCode == UP) {
    r1.getPosition().add(new PVector(0,-10));
  }
  if(keyCode == DOWN) {
    r1.getPosition().add(new PVector(0,10));
  }
  if(keyCode == LEFT) {
    r1.getPosition().add(new PVector(-10,0));
  }
  if(keyCode == RIGHT) {
    r1.getPosition().add(new PVector(10,0));
  }
}

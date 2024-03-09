  Circle c1;
  Circle c2;
  Rectangle r1;

void setup (){
  c1 = new Circle(new PVector(width/2,height/2), 1, 1, false, 50);
  c2 = new Circle(new PVector(width/3,height/3), 1, 1, false, 50);
  r1 = new Rectangle(new PVector(width/2,height/3), 1, 1, false, 50, 50);
  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  background(51);
  Collisions.intersect(c1, c2);
  Collisions.intersect(c1,r1);
  fill(0, 255, 0);
  circle(c1.getCoorX(), c1.getCoorY(), c1.getRadius()*2); 
  circle(c2.getCoorX(), c2.getCoorY(), c2.getRadius()*2); 
  rect(r1.getPosition().x, r1.getPosition().y, r1.getWidth(), r1.getHeight());
  
}

void keyPressed() {
  if(keyCode == UP) {
    c1.setPosition(c1.getPosition().add(new PVector(0,-10)));
  }
  if(keyCode == DOWN) {
    c1.setPosition(c1.getPosition().add(new PVector(0,10)));
  }
  if(keyCode == LEFT) {
    c1.setPosition(c1.getPosition().add(new PVector(-10,0)));
  }
  if(keyCode == RIGHT) {
    c1.setPosition(c1.getPosition().add(new PVector(10,0)));
  }
}

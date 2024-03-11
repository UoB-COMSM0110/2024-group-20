
  World w;

void setup (){
  w = new World();
  w.addBody(new Circle(new PVector(width/2,height/2), 1, 1, false, 50));
  w.addBody(new Circle(new PVector(width/3,height/3), 1, 1, false, 50));
  w.addBody(new Rectangle(new PVector(width/2,height/3), 1, 1, false, 50, 50));
  w.addBody(new Rectangle(new PVector(width/3,height/2), 1, 1, false, 50, 50));
  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  background(51);
  if(w.collideBodies()){
    fill(255,0,0);
  } else {
    fill(0, 255, 0);
  }
  w.display();
  
}

void keyPressed() {
  RigidBody body = w.getBody(0);
  
  if(keyCode == UP) {
    body.getPosition().add(new PVector(0,-10));
  }
  if(keyCode == DOWN) {
    body.getPosition().add(new PVector(0,10));
  }
  if(keyCode == LEFT) {
    body.getPosition().add(new PVector(-10,0));
  }
  if(keyCode == RIGHT) {
    body.getPosition().add(new PVector(10,0));
  }
}

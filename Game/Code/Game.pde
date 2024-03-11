
  World w;

void setup (){
  w = new World();
  w.addBody(new BirdRed(new PVector(width/2,height/2)));
  w.addBody(new BirdBlue(new PVector(width/3,height/3)));
  w.addBody(new Rectangle(new PVector(width/2,height/3), 1, 1, false, 50, 50));
  w.addBody(new Rectangle(new PVector(width/4,height/2), 1, 1, false, 50, 50));
  w.addBody(new Rectangle(new PVector(width/3,height/4), 1, 1, false, 50, 50));
  w.addBody(new BirdBlack(new PVector(width/4,height/4)));
  w.addBody(new Pig(new PVector(width/6,height/4)));
  w.addBody(new Pig(new PVector(width/6,height/6)));

  Pig newPig = (Pig) w.getBody(6);
  newPig.killPig();
  
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
  RigidBody body = w.getBody(2);  
  
  if(keyCode == UP) {
    body.getPosition().add(new PVector(0,-5));
  }
  if(keyCode == DOWN) {
    body.getPosition().add(new PVector(0,5));
  }
  if(keyCode == LEFT) {
    body.getPosition().add(new PVector(-5,0));
  }
  if(keyCode == RIGHT) {
    body.getPosition().add(new PVector(5,0));
  }
  
  RigidBody body2 = w.getBody(0);
  
  if(key == 'W' || key == 'w') {
    body2.getPosition().add(new PVector(0,-5));
  }
  if(key == 'S' || key == 's') {
    body2.getPosition().add(new PVector(0,5));
  }
  if(key == 'a' || key == 'A') {
    body2.getPosition().add(new PVector(-5,0));
  }
  if(key == 'd' || key == 'D') {
    body2.getPosition().add(new PVector(5,0));
  }

}

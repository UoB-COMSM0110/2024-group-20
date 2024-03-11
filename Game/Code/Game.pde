
  World w;
  ArrayList<Integer> keysPressed;

void setup (){
  w = new World();
  keysPressed = new ArrayList();
  w.addBody(new Circle(new PVector(width/2,height/2), 1, 1, false, 50));
  w.addBody(new Circle(new PVector(width/3,height/3), 1, 1, false, 50));
  w.addBody(new Rectangle(new PVector(width/2,height/3), 1, 1, false, 50, 50));
  w.addBody(new Rectangle(new PVector(width/4,height/2), 1, 1, false, 50, 50));
  w.addBody(new Rectangle(new PVector(width/3,height/4), 1, 1, false, 50, 50));
  w.addBody(new Circle(new PVector(width/4,height/4), 1, 1, false, 50));

  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  if(keyPressed){
    RigidBody body = w.getBody(2);
    RigidBody body2 = w.getBody(0);
    
    for(int i=0; i<keysPressed.size(); i++){
      int currentKey = keysPressed.get(i);
      if(currentKey == UP) {
        body.getPosition().add(new PVector(0,-5));
      }
      if(currentKey == DOWN) {
        body.getPosition().add(new PVector(0,5));
      }
      if(currentKey == LEFT) {
        body.getPosition().add(new PVector(-5,0));
      }
      if(currentKey == RIGHT) {
        body.getPosition().add(new PVector(5,0));
      }
      if(currentKey == 'W' || currentKey == 'w') {
        body2.getPosition().add(new PVector(0,-5));
      }
      if(currentKey == 'S' || currentKey == 's') {
        body2.getPosition().add(new PVector(0,5));
      }
      if(currentKey == 'a' || currentKey == 'A') {
        body2.getPosition().add(new PVector(-5,0));
      }
      if(currentKey == 'd' || currentKey == 'D') {
        body2.getPosition().add(new PVector(5,0));
      }
    }
    
  }
  background(51);
  if(w.collideBodies()){
    fill(255,0,0);
  } else {
    fill(0, 255, 0);
  }
  w.display();
  
}

void keyPressed() {
  if(!keysPressed.contains(Integer.valueOf(keyCode))){
    keysPressed.add(keyCode);
  }
}

void keyReleased(){
  keysPressed.remove(Integer.valueOf(keyCode));
}

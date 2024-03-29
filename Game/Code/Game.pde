
  World w;
  ArrayList<Integer> keysPressed;

void setup (){
  w = new World();
  keysPressed = new ArrayList();
  w.addBody(new BirdRed(new PVector(width/4,height/3)));
  w.addBody(new BirdBlack(new PVector(width/4*2,height/3)));
  w.addBody(new BirdBlue(new PVector(width/4*3,height/3)));
  w.addBody(new Rectangle(new PVector(width/5*1,height/3*2), 1, 1, false, 50, 100, PI/8*0));
  w.addBody(new Rectangle(new PVector(width/5*2,height/3*2), 1, 1, false, 50, 100, PI/8*1));
  w.addBody(new Rectangle(new PVector(width/5*3,height/3*2), 1, 1, false, 50, 100, PI/8*3));
  w.addBody(new Rectangle(new PVector(width/5*4,height/3*2), 1, 1, false, 50, 100, PI/8*5));


  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  if(keyPressed){
    RigidBody body = w.getBody(0);
    RigidBody body2 = w.getBody(3);
    for(int i=0; i<keysPressed.size(); i++){

      float dx = 0;
      float dy = 0;
      float forceMagnitude = 1900000;
      
      int currentKey = keysPressed.get(i);
      if(currentKey == UP) {
        dy = dy - 1;
      }
      if(currentKey == DOWN) {
        dy = dy + 1;
      }
      if(currentKey == LEFT) {
        dx = dx - 1;
      }
      if(currentKey == RIGHT) {
        dx = dx + 1;
      }
      
      if(dx != 0 || dy != 0){
        PVector direction = new PVector(dx, dy).normalize();
        PVector force = PVector.mult(direction, forceMagnitude);
        body.applyForce(force);
      }
      /*if(currentKey == 'W' || currentKey == 'w') {
        body2.getPosition().add(new PVector(0,-4));
      }
      if(currentKey == 'S' || currentKey == 's') {
        body2.getPosition().add(new PVector(0,4));
      }
      if(currentKey == 'a' || currentKey == 'A') {
        body2.getPosition().add(new PVector(-4,0));
      }
      if(currentKey == 'd' || currentKey == 'D') {
        body2.getPosition().add(new PVector(4,0));
      }*/
    }
  }
  background(51);
  
  w.step(1/frameRate);
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

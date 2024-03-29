
  World w;
  ArrayList<Integer> keysPressed;

void setup (){
  w = new World();
  keysPressed = new ArrayList();
  // (PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation)
  w.addBody(new Rectangle(new PVector(width/2,height + 10), 1, 1, true, width, 20, 0));
  w.addBody(new Rectangle(new PVector(0 - 10, height/2), 1, 1, true, 20, height - 10, 0));
  w.addBody(new Rectangle(new PVector(width + 10, height/2), 1, 1, true, 20, height - 10, 0));
  // Shapes
  w.addBody(new Rectangle(new PVector(width/5*1,height/3*2), 1, 1, false, 50, 100, PI/8*0));
  w.addBody(new Rectangle(new PVector(width/5*2,height/3*2), 1, 1, false, 50, 100, PI/8*1));
  w.addBody(new Rectangle(new PVector(width/5*3,height/3*2), 1, 1, true, 50, 100, PI/8*3));
  w.addBody(new Rectangle(new PVector(width/5*4,height/3*2), 1, 1, false, 50, 100, PI/8*5));


  fullScreen();  
  rectMode(CENTER);
}

void draw (){
  if(keyPressed){
    RigidBody body = w.getBody(3);
    for(int i=0; i<keysPressed.size(); i++){

      float dx = 0;
      float dy = 0;
      float forceMagnitude = 2500000;
      
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
      
      if(currentKey == ENTER){
        float xPosition = random(width);
        w.addBody(new BirdRed(new PVector(xPosition, 0)));
        float forceX = random(-80, 80);
        float forceY = random(0, 80);

        PVector direction = new PVector(forceX, forceY);
        PVector force = PVector.mult(direction, forceMagnitude);
        w.getBody(w.getListSize() - 1).applyForce(force);
      }

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

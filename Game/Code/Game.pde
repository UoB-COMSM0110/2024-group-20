import processing.javafx.*;
import java.io.*;

HashMap<String, PImage> imageMap;
ScreenManager screenManager;
PFont font;

void setup (){
  font = createFont("angrybirds-regular.ttf", 128);
  fullScreen(FX2D);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  textFont(font);

  loadImages();
  screenManager = new ScreenManager();
}

void draw(){
  screenManager.display();
}

void mousePressed(){
  screenManager.mousePressed();
}

void keyPressed(){
  screenManager.keyPressed();
}

void mouseDragged() {
  screenManager.mouseDragged();

}

void mouseReleased() {
  screenManager.mouseReleased();
}


void loadImages() {
  imageMap = new HashMap();
  File directoryPath = new File(sketchPath("../Images"));
  File filesList[] = directoryPath.listFiles();
  for(int i=0; i<filesList.length; i++) {
    File file = filesList[i];
    String fileName = file.getName();
    String imageName = fileName.replaceFirst("[.][^.]+$", "");
    String imagePath = "../Images/" + fileName;
    PImage image = loadImage(imagePath);
    imageMap.put(imageName, image);
  }
}


 //World w;
 //ArrayList<Integer> keysPressed;
 //float frictionRes = 0.8;
 //float restitution = 0.8;
  

 //void setup (){
 //  imageMode(CENTER);
 //  rectMode(CENTER);
 //  loadImages();
 //  w = new World();
 //  keysPressed = new ArrayList();
 //  //w.addBody(new Circle(new PVector(width/4,height/3), 1, 1, false, 50, 0));
 //  w.addBody(new Pig(new PVector(width/4,height/3)));
 //  //w.addBody(new Circle(new PVector(width/4*2,height/3), 1, 1, false, 50, 0));
 //  w.addBody(new BirdBlack(new PVector(width/4*2,height/3)));
 //  w.addBody(new Circle(new PVector(width/4*3,height/3), 1, 1, true, 50, 2.5));
 //  w.addBody(new Rectangle(new PVector(width/5*1,height/3*2), 1, 1, false, 100, 400, PI/8*0));
 //  //w.getBody(3).mass = Float.MAX_VALUE/1E10;
 //  w.addBody(new Rectangle(new PVector(width/5*2,height/3*2), 1, 1, false, 50, 200, PI/8*1));
 //  w.addBody(new Rectangle(new PVector(width/5*3,height/3*2), 1, 1, false, 50, 200, PI/8*3));
 //  w.addBody(new Rectangle(new PVector(width/5*4,height/3*2), 1, 1, false, 50, 200, PI/8*5));
 //  w.addBody(new Rectangle(new PVector(50,height/2), 1, 1, true, 50, height, 0));
 //  w.addBody(new Rectangle(new PVector(width-50,height/2), 1, 1, true, 50, height, 0));
 //  w.addBody(new Rectangle(new PVector(width/2,50), 1, 1, true, width, 50, 0));
 //  w.addBody(new Rectangle(new PVector(width/2,height-50), 1, 1, true, width, 50, 0));
 //  for(int i=0; i<w.getBodyListSize(); i++) {
 //    w.getBody(i).frictionRestitution = frictionRes;
 //    w.getBody(i).restitution = restitution;
 //  }

 //  fullScreen(FX2D);  
 //  //fullScreen(P2D);  
 //}

 //void draw (){
 //  thread("keysPressed");
 //  thread("wSteps");
 //  background(51);
 //  w.display();
 //}

 //void keysPressed() {
 //  if(keyPressed){
 //    RigidBody body1 = w.getBody(0);
 //    RigidBody body2 = w.getBody(3);
 //    for(int i=0; i<keysPressed.size(); i++){
 //      int currentKey = keysPressed.get(i);
 //      if(currentKey == UP) {
 //        body1.getLinearVelocity().add(new PVector(0,-40));
 //      }
 //      if(currentKey == DOWN) {
 //        body1.getLinearVelocity().add(new PVector(0,40));
 //      }
 //      if(currentKey == LEFT) {
 //        body1.getLinearVelocity().add(new PVector(-40,0));
 //      }
 //      if(currentKey == RIGHT) {
 //        body1.getLinearVelocity().add(new PVector(40,0));
 //      }
 //      if(currentKey == 'W') {
 //        body2.getLinearVelocity().add(new PVector(0,-20));
 //      }
 //      if(currentKey == 'S') {
 //        body2.getLinearVelocity().add(new PVector(0,20));
 //      }
 //      if(currentKey == 'A') {
 //        body2.getLinearVelocity().add(new PVector(-20,0));
 //      }
 //      if(currentKey == 'D') {
 //        body2.getLinearVelocity().add(new PVector(20,0));
 //      }
 //      if(currentKey == 'J') {
 //        body1.setAngularVelocity(body1.getAngularVelocity() + 0.5);
 //      }
 //      if(currentKey == 'K') {
 //        body2.setAngularVelocity(body2.getAngularVelocity() + 0.5);
 //      }
 //    }
 //  }
 //}


 //void keyPressed() {
 //  if(!keysPressed.contains(Integer.valueOf(keyCode))){
 //    keysPressed.add(keyCode);
 //  }
 //  if(key=='=') {
 //    //w.addBody(new Circle(new PVector(width/4*2,height/3), 1, 1, false, 50, 2.5));
 //    w.addBody(new BirdBlack(new PVector(width/4,height/3)));
 //    w.getBody(w.getBodyListSize()-1).frictionRestitution = frictionRes;
 //    w.getBody(w.getBodyListSize()-1).restitution = restitution;
 //  }
 //}

 //void keyReleased() {
 //  keysPressed.remove(Integer.valueOf(keyCode));
 //}

 //void mouseClicked() {
 //  for(int i=0; i<w.getBodyListSize(); i++) {
 //    print(w.getBody(i).largestImpulse + "\n");
 //  }
 //}


 //void wSteps() {
 //  for(int i=0; i<20; i++) {
 //    w.step(1/frameRate/20);
 //    w.collideBodies();
 //  }
 //  //if(w.getBody(0).largestImpulse > 2.3E7) {
 //  //  w.removeBody(w.getBody(0));
 //  //}
 //}

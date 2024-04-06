import processing.javafx.*;

ScreenManager screenManager;
PFont font;

void setup (){
  font = createFont("angrybirds-regular.ttf", 128);
  fullScreen(FX2D);
  rectMode(CENTER);
  imageMode(CENTER);
  //textMode(CENTER);
  textAlign(CENTER);
  textFont(font);
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

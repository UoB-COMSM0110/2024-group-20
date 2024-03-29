ScreenManager screenManager;
PFont font;

void setup (){
  font = createFont("angrybirds-regular.ttf", 128);
  fullScreen();
  
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

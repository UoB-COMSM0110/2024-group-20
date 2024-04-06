class LooseScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  PImage bgImage, menuImage;
  ImageButton menuButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  LooseScreen(ScreenManager screenManager,UserScore playerScore) {
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    bgImage = loadImage("../Images/map.png");
    menuImage = loadImage("../Images/menuButton.png");
    menuButton = new ImageButton(menuImage, width/2 - width/10,height/2 - height/20 + height/7,width/5,height/10);  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, 0, 0, width, height);
    // lose text
    fill(0,0,0);
    textFont(font);
    text("You LOST!!!", width/2, height/3);
    playerScore.printFinalScore();
    
    menuButton.update();
    menuButton.display();
 
  }

  void mousePressed(){
    if(menuButton.clicked()){
      playerScore.deletePlayer();
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
    }
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  
}

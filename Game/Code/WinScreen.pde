class WinScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  PImage bgImage, menuImage;
  ImageButton menuButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  WinScreen(ScreenManager screenManager,UserScore playerScore) {
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    bgImage = loadImage("../Images/map.png");
    menuImage = loadImage("../Images/menuButton.png");
    menuButton = new ImageButton(menuImage, width - width/10,height - height/20, width/5,height/10);  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    // win text
    fill(0,0,0);
    text("You WON!!!", width/2, height/3);
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

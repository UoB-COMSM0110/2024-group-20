class ScoreScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  PImage bgImage, woodBoardImage, menuImage;
  ImageButton menuButton;
  //ArrayList<ImageButton> buttons;
  
    //constuctor
    ScoreScreen(ScreenManager screenManager,UserScore playerScore) {
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    bgImage = loadImage("../Images/map.png");
    woodBoardImage = loadImage("../Images/woodBoard.png");
    menuImage = loadImage("../Images/menuButton.png");
    menuButton = new ImageButton(menuImage, width - width/5,height - height/10,width/5,height/10);  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, 0, 0, width, height);
    // Board to display scores on
    image(woodBoardImage, width/5, height/10, width - 2 * width/5, height - height/5);
    // printing scores from a text file
    playerScore.printScoresFile();
    
    menuButton.update();
    menuButton.display();
  }

  void mousePressed(){
    if(menuButton.clicked()){screenManager.setCurrentScreen(ScreenType.STARTSCREEN);}
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  
}
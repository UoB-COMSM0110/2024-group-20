class StartScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  PImage bgImage, logoImage, startImage, scoreImage, exitImage;
  ImageButton startButton, scoreButton, exitButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  StartScreen(ScreenManager screenManager,UserScore playerScore) {
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    bgImage = loadImage("../Images/map.png");
    logoImage = loadImage("../Images/AnxiousPigsLogo.png");
    startImage = loadImage("../Images/startButton.png");
    scoreImage = loadImage("../Images/scoreButton.png");
    exitImage = loadImage("../Images/exitButton.png");
    
    buttons = new ArrayList<ImageButton>();
    
    startButton = new ImageButton(startImage, width/2,height/2 - height/20+height/10,width/5,height/10);
    buttons.add(startButton);
    //score button
    scoreButton = new ImageButton(scoreImage, width/2,height/2 - height/20 + height/7+height/10,width/5,height/10);
    buttons.add(scoreButton);
    //exit
    exitButton = new ImageButton(exitImage, width/2,height/2 - height/20 + 2*height/7+height/10,width/5,height/10);
    buttons.add(exitButton);
    
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    //setting logo
    image(logoImage, width/2,height/2 - height/4,width/3,height/3);
    
    for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }
  }

  void mousePressed(){
    if(startButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.DIFFICULTYSCREEN);
    }
    if(scoreButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.SCORESCREEN);
    }
    if(exitButton.clicked()){exit();}
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  void mouseReleased(){}
  
}

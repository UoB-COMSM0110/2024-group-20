class DifficultyScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  Level allLevels[];
  PImage bgImage, easyImage, hardImage;
  ImageButton easyButton, hardButton;
  ArrayList<ImageButton> buttons;
  
  
  //constuctor
  DifficultyScreen(ScreenManager screenManager,UserScore playerScore, Level allLevels[]) {
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    this.allLevels = allLevels;
    
    bgImage = loadImage("../Images/map.png");
    buttons = new ArrayList<ImageButton>();

    easyImage = loadImage("../Images/easyButton.png");
    easyButton = new ImageButton(easyImage, width/4,height/2  - height/10, width/5, height/10); 
    buttons.add(easyButton);
    
    hardImage = loadImage("../Images/hardButton.png");    
    hardButton = new ImageButton(hardImage, 3 * width/4 - width/5, height/2 -height/10 , width/5, height/10);  
    buttons.add(hardButton);
  }
  
  //load all the image
  void display(){
    // setting background
    image(bgImage, 0, 0, width, height);

    for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
    }
  }
  
  void mousePressed(){
    if(easyButton.clicked()){
      setEasyLevels();
      screenManager.setCurrentScreen(ScreenType.GAMESCREEN);
    }
    if(hardButton.clicked()){
      setHardLevels();
      screenManager.setCurrentScreen(ScreenType.GAMESCREEN);
    }
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  
  private void setEasyLevels(){
    allLevels[0] = new Level(200, 1, 3, 0, 0, Difficulty.EASY);
    allLevels[1] = new Level(150, 2, 3, 3, 0, Difficulty.EASY);
    allLevels[2] = new Level(100, 3, 3, 3, 3, Difficulty.EASY);
  }

  private void setHardLevels(){
    allLevels[0] = new Level(200, 1, 3, 3, 0, Difficulty.HARD);
    allLevels[1] = new Level(150, 2, 3, 3, 3, Difficulty.HARD);
    allLevels[2] = new Level(100, 3, 0, 6, 6, Difficulty.HARD);
  }
}

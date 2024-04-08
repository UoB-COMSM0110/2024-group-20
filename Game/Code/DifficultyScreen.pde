class DifficultyScreen extends Screen {
  ScreenManager screenManager;
  Player player;
  Level allLevels[];
  PImage bgImage, easyImage, hardImage;
  ImageButton easyButton, hardButton;
  ArrayList<ImageButton> buttons;
  
  
  //constuctor
  DifficultyScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.allLevels = screenManager.allLevels;
    
    bgImage = gameImages.get("map");
    buttons = new ArrayList<ImageButton>();

    easyImage = gameImages.get("easyButton");
    easyButton = new ImageButton(easyImage, width/3,height/2, width/5, height/10); 
    buttons.add(easyButton);
    
    hardImage = gameImages.get("hardButton");  
    hardButton = new ImageButton(hardImage, 2 * width/3, height/2 , width/5, height/10);  
    buttons.add(hardButton);
  }
  
  //load all the image
  void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);

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
  void mouseReleased(){}
  
  private void setEasyLevels(){
    allLevels[0] = new Level(200, 1, 3, 0, 0, Difficulty.EASY, 0);
    allLevels[1] = new Level(150, 2, 3, 3, 0, Difficulty.EASY, 1);
    allLevels[2] = new Level(100, 3, 3, 3, 3, Difficulty.EASY, 2);
  }

  private void setHardLevels(){
    allLevels[0] = new Level(200, 1, 3, 3, 0, Difficulty.HARD, 0);
    allLevels[1] = new Level(150, 2, 3, 3, 3, Difficulty.HARD, 1);
    allLevels[2] = new Level(100, 3, 0, 6, 6, Difficulty.HARD, 2);
  }
}

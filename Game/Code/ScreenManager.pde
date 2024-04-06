class ScreenManager {
  private HashMap<ScreenType, Screen> screens;
  private Screen currentScreen;
  UserScore playerScore;
  Level allLevels[];


  ScreenManager() {
    screens = new HashMap<ScreenType, Screen>();
    playerScore = new UserScore();
    allLevels = new Level[3];   


    setupScreens();
    setCurrentScreen(ScreenType.STARTSCREEN);
  }
  
  private void setupScreens() {
    screens.put(ScreenType.STARTSCREEN, new StartScreen(this,playerScore));
    screens.put(ScreenType.DIFFICULTYSCREEN, new DifficultyScreen(this,playerScore, allLevels));
    screens.put(ScreenType.GAMESCREEN, new GameScreen(this,playerScore, allLevels));
    screens.put(ScreenType.SCORESCREEN, new ScoreScreen(this,playerScore));
    screens.put(ScreenType.WINSCREEN, new WinScreen(this,playerScore));
    screens.put(ScreenType.LOOSESCREEN, new LooseScreen(this,playerScore));
  }
  
  void setCurrentScreen(ScreenType screenType) {
    currentScreen = screens.get(screenType);
  }
  
  void display() {
    if (currentScreen != null) {
      currentScreen.display();
    }
  }
  
  void mousePressed() {
    if (currentScreen != null) {
      currentScreen.mousePressed();
    }
  }
  
  void keyPressed() {
    if (currentScreen != null) {
      currentScreen.keyPressed(); 
    }
  }
   void mouseDragged() {
    if (currentScreen != null) {
      currentScreen.mouseDragged(); 
    }
  }
  void mouseReleased() {
    if (currentScreen != null) {
      currentScreen.mouseReleased();
    }
  }
}

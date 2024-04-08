class ScreenManager {
  private HashMap<ScreenType, Screen> screens;
  private Screen currentScreen;
  Player player;
  Level allLevels[];


  ScreenManager() {
    screens = new HashMap<ScreenType, Screen>();
    player = new Player();
    allLevels = new Level[3];   

    setupScreens();
    setCurrentScreen(ScreenType.STARTSCREEN);
  }
  
  private void setupScreens() {
    screens.put(ScreenType.STARTSCREEN, new StartScreen(this));
    screens.put(ScreenType.DIFFICULTYSCREEN, new DifficultyScreen(this));
    screens.put(ScreenType.GAMESCREEN, new GameScreen(this));
    screens.put(ScreenType.SCORESCREEN, new ScoreScreen(this));
    screens.put(ScreenType.WINSCREEN, new WinScreen(this));
    screens.put(ScreenType.LOOSESCREEN, new LooseScreen(this));
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

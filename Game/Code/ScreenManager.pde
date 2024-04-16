public enum ScreenType {
  STARTSCREEN,
  PLAYERNAMESCREEN,
  SCORESCREEN,
  GAMESCREEN,
  ATTACKSCREEN,
  DIFFICULTYSCREEN,
  WINSCREEN,
  LOSESCREEN
}

public class ScreenManager {
  private HashMap<ScreenType, Screen> screens;
  private Screen currentScreen;
  private Player player;

  public ScreenManager() {
    screens = new HashMap<ScreenType, Screen>();
    player = new Player();

    setupScreens();
    setCurrentScreen(ScreenType.STARTSCREEN);
  }
  
  private void setupScreens() {
    screens.put(ScreenType.STARTSCREEN, new StartScreen(this));
    screens.put(ScreenType.PLAYERNAMESCREEN, new PlayerNameScreen(this));
    screens.put(ScreenType.DIFFICULTYSCREEN, new DifficultyScreen(this));
    screens.put(ScreenType.GAMESCREEN, new GameScreen(this));
    screens.put(ScreenType.SCORESCREEN, new ScoreScreen(this));
    screens.put(ScreenType.WINSCREEN, new WinScreen(this));
    screens.put(ScreenType.LOSESCREEN, new LoseScreen(this));
  }
  
  public HashMap<ScreenType, Screen> getScreens() {
    return screens;
  }
  
  public void setCurrentScreen(ScreenType screenType) {
    currentScreen = screens.get(screenType);
    if(screenType == ScreenType.STARTSCREEN) {
      gameAudios.get("loseMusic").pause();
      gameAudios.get("winMusic").pause();
      gameAudios.get("backgroundMusic").loop();
    }
    else if(screenType == ScreenType.LOSESCREEN) {
      gameAudios.get("backgroundMusic").pause();
      gameAudios.get("loseMusic").loop();
      gameAudios.get("loseMusic").amp(0.4);
    }
    else if(screenType == ScreenType.WINSCREEN) {
      gameAudios.get("backgroundMusic").pause();
      gameAudios.get("winMusic").loop();
      gameAudios.get("winMusic").amp(0.5);
    }
  }
  
  public Player getPlayer() {
    return this.player;
  }
  
  public void display() {
    if (currentScreen != null) {
      currentScreen.display();
    }
  }
  
  public void mousePressed() {
    if (currentScreen != null) {
      currentScreen.mousePressed();
    }
  }
  
  public void keyPressed() {
    if (currentScreen != null) {
      currentScreen.keyPressed(); 
    }
  }
  public void mouseDragged() {
    if (currentScreen != null) {
      currentScreen.mouseDragged(); 
    }
  }
  public void mouseReleased() {
    if (currentScreen != null) {
      currentScreen.mouseReleased();
    }
  }
}

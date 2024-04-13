public class DifficultyScreen extends Screen {
  private ScreenManager screenManager;
  private PImage bgImage, easyImage, hardImage;
  private ImageButton easyButton, hardButton;
  private ArrayList<ImageButton> buttons;
  
  
  //constuctor
  public DifficultyScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    
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
  public void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);

    for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
    }
  }
  
  public void mousePressed(){
    if(easyButton.clicked()){
      setEasyLevels();
    }
    if(hardButton.clicked()){
      setHardLevels();
    }
    if(easyButton.clicked() || hardButton.clicked()) {
      screenManager.setCurrentScreen(ScreenType.GAMESCREEN);
      GameScreen gameScreen = (GameScreen) screenManager.getScreens().get(ScreenType.GAMESCREEN);
      gameScreen.setLevel(0);
    }
  }
  
  public void keyPressed(){}
  public void mouseDragged(){}
  public void mouseReleased(){}
  
  private void setEasyLevels(){
    screenManager.getPlayer().setDifficulty(Difficulty.EASY);
  }

  private void setHardLevels(){
    screenManager.getPlayer().setDifficulty(Difficulty.HARD);
  }
}

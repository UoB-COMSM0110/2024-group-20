public class GameScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private Menu levelMenu;
  private Tutorial tutorial;
  private Level currentLevel;
  private int currentLevelNumber;
  
  private PImage menuImage;
  private ImageButton menuButton;
  private ArrayList<ImageButton> buttons;
  
  //constuctor
  public GameScreen(ScreenManager screenManager){
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.currentLevelNumber = 0;
    this.currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
  
    setButtons();
    tutorial = new Tutorial();  
    levelMenu = new Menu(width/2, height/2, width/2, height/2);
  }

  public void display(){
    currentLevel.display();
    for (ImageButton button : buttons) {
      button.update(); 
      button.display(); 
    }
    if(currentLevelNumber<gameLevelData.length && currentLevelNumber>0){
      levelMenu.displayMenu();
      levelMenu.clicked();
    }
    textDisplay();
    tutorial.display(); 
  }
  
  public void endLevel(){
    player.updateScore(currentLevel, currentLevelNumber);
    if(currentLevel.numberPigsAlive() == 0){
      currentLevelNumber = 0;
      currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
      screenManager.setCurrentScreen(ScreenType.LOSESCREEN); 
    }
    else if(currentLevelNumber < gameLevelData.length-1){
      currentLevelNumber++;
      currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
      levelMenu.resetMenu();
    }else{
      currentLevelNumber = 0;
      currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
      screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
    }
    
  }

  private void textDisplay(){
    //score Display
    fill(0, 0, 0);
    textSize(40);
    text(player.getPlayerName() + "   Score: " + str(player.getPlayerScore()), width-width/5,height/15);
  }
  
  public void mousePressed(){
    //check tutorial
    tutorial.mousePressed();
    currentLevel.mousePressed();
    
    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      player.deletePlayer();
      currentLevelNumber = 0;
      currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
    }
  }
  
  public void keyPressed(){
    currentLevel.keyPressed();
////////////////////////////////JUST FOR DEMONSTRATION PURPOSES////////////
    if(key == '['){
      if(currentLevelNumber < gameLevelData.length-1){
        currentLevelNumber++;
        currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
      }else{
        currentLevelNumber = 0;
        currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
        screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
      }
    }
    if(key == ']'){
      currentLevelNumber = 0;
      currentLevel = new Level(this, gameLevelData[currentLevelNumber]);
      screenManager.setCurrentScreen(ScreenType.LOSESCREEN); 
    }
//////////////////////////////////////////////////////////////////////////
  }

  public void mouseDragged() {
    currentLevel.mouseDragged();
  }

  public void mouseReleased() {
    currentLevel.mouseReleased();
  }
  
  private void setButtons(){
    buttons = new ArrayList<ImageButton>();
    //menu
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width - width/10 - 10,height - height/20 - 10,width/5,height/10);
    buttons.add(menuButton);
  }
}

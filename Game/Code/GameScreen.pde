public class GameScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private Menu levelMenu;
  private Tutorial tutorial;
  private Level currentLevel;
  private int currentLevelNumber;
  
  private PImage menuImage, tutorialImage;
  private ImageButton menuButton, tutorialButton;
  private ArrayList<ImageButton> buttons;
  
  //constuctor
  public GameScreen(ScreenManager screenManager){
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.currentLevelNumber = 0;
  
    setButtons();
    tutorial = new Tutorial();  
    levelMenu = new Menu(width/2, height/2, width/2, height/2);
  }

  public void display(){
    currentLevel.display();
    for (ImageButton button : buttons) {
      button.display(); 
    }
    if(currentLevelNumber < gameLevelData.get(player.getDifficulty()).length && currentLevelNumber>0){
      levelMenu.displayMenu(currentLevelNumber-1);
      levelMenu.clicked();
    }
    otherDisplay();
    tutorial.display(); 
  }
  
  public Player getPlayer() {
    return this.player;
  }
  
  public void setLevel(int levelNumber) {
    Difficulty difficulty = player.getDifficulty();
    currentLevelNumber = levelNumber;
    currentLevel = new Level(this, gameLevelData.get(difficulty)[currentLevelNumber]);
  }
  
  public void endLevel(){
    Difficulty difficulty = player.getDifficulty();
    player.updateScore(currentLevel, currentLevelNumber);
    if(difficulty == Difficulty.EASY) {
      if(currentLevel.numberPigsAlive() == 0){
        setLevel(0);
        screenManager.setCurrentScreen(ScreenType.LOSESCREEN);
        return;
      }
    }
    else {
      if(currentLevel.numberPigsAlive() != currentLevel.numberPigsTotal()){
        setLevel(0);
        screenManager.setCurrentScreen(ScreenType.LOSESCREEN);
        return;
      }
    }
    
    if(currentLevelNumber < gameLevelData.get(player.getDifficulty()).length-1){
      setLevel(currentLevelNumber+1);
      levelMenu.resetMenu();
    }else{
      setLevel(0);
      screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
    }
  }

  private void otherDisplay(){
    //score Display
    fill(0, 0, 0);
    textSize(40);
    text(player.getPlayerName() + "   Score: " + str(player.getPlayerScore()), 3 * width/4, height/10);
    text("Level: " + str(currentLevelNumber+1) + " / " + str(gameLevelData.get(player.getDifficulty()).length), 1 * width/4, height/10);
  }
  
  public void mousePressed(){
    //check tutorial
    tutorial.mousePressed();
    currentLevel.mousePressed();
    
    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      setLevel(0);
      player.deletePlayer();
    }
    if(tutorialButton.clicked()){
      tutorial.resetTutorial();
    }
  }
  
  public void keyPressed(){
    currentLevel.keyPressed();
////////////////////////////////JUST FOR DEMONSTRATION PURPOSES////////////
    if(key == '['){
      if(currentLevelNumber < gameLevelData.get(player.getDifficulty()).length-1){
        setLevel(currentLevelNumber+1);
      }else{
        setLevel(0);
        screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
      }
    }
    if(key == ']'){
      setLevel(0);
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
    //tutorial
    tutorialImage = gameImages.get("tutorialButton");
    tutorialButton = new ImageButton(tutorialImage, 11 * width/12, height/10,  height/10, height/10);
    buttons.add(tutorialButton);
  }
}

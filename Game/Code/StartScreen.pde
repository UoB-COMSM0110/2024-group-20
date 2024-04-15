public class StartScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private PImage bgImage, logoImage, startImage, scoreImage, exitImage;
  private ImageButton startButton, scoreButton, exitButton;
  private ArrayList<ImageButton> buttons;
  
  //constuctor
  public StartScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    bgImage = gameImages.get("map");
    logoImage = gameImages.get("AnxiousPigsLogo");
    startImage = gameImages.get("startButton");
    scoreImage = gameImages.get("scoreButton");
    exitImage = gameImages.get("exitButton");
    
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
  public void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    //setting logo
    image(logoImage, width/2,height/2 - height/4,width/3,height/3);

    
    for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }

  }

  public void mousePressed(){
    if(startButton.clicked()){
      if(player.isNameSet()) {
        screenManager.setCurrentScreen(ScreenType.DIFFICULTYSCREEN);
      }
      else {
        screenManager.setCurrentScreen(ScreenType.PLAYERNAMESCREEN);
      }
    }
    if(scoreButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.SCORESCREEN);
    }
    if(exitButton.clicked()){exit();}
  }
  
  public void keyPressed(){}
  public void mouseDragged(){}
  public void mouseReleased(){}
  
}

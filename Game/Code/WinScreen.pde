public class WinScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private PImage bgImage, menuImage;
  private ImageButton menuButton;
  //private ArrayList<ImageButton> buttons;
  
  //constuctor
  public WinScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    bgImage = gameImages.get("map");
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width/2,height/2 + height/4, width/5,height/10);  
  }

  //load all the image
  public void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    // win text
    fill(0,0,0);
    textSize(80);
    text("You WON!!!", width/2, height/3);
    textSize(40);
    text("Your Final Score is: " + str(player.getPlayerScore()), width/2, height/2);
    player.updateScoresFile();
    
    menuButton.update();
    menuButton.display();
 
  }

  public void mousePressed(){
    if(menuButton.clicked()){
    player.deletePlayer();
    screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
    }
  }
  
  public void keyPressed(){}
  public void mouseDragged(){}
  public void mouseReleased(){}
}

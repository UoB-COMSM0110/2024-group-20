class WinScreen extends Screen {
  ScreenManager screenManager;
  Player player;
  PImage bgImage, menuImage;
  ImageButton menuButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  WinScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    bgImage = gameImages.get("map");
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width - width/10,height - height/20, width/5,height/10);  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    // win text
    fill(0,0,0);
    text("You WON!!!", width/2, height/3);
    player.printFinalScore();
    
    menuButton.update();
    menuButton.display();
 
  }

  void mousePressed(){
    if(menuButton.clicked()){
    player.deletePlayer();
    screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
    }
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  void mouseReleased(){}
  
}

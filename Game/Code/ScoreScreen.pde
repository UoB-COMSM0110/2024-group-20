class ScoreScreen extends Screen {
  ScreenManager screenManager;
  Player player;
  PImage bgImage, woodBoardImage, menuImage;
  ImageButton menuButton;
  //ArrayList<ImageButton> buttons;
  
    //constuctor
    ScoreScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    bgImage = gameImages.get("map");
    woodBoardImage = gameImages.get("woodBoard");
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width - width/10 - 10,height - height/20 - 10,width/5,height/10);  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    // Board to display scores on
    image(woodBoardImage, width/2, height/2, width - 2 * width/5, height - height/5);
    // printing scores from a text file
    printScoresFile();
    
    menuButton.update();
    menuButton.display();
  }

  void mousePressed(){
    if(menuButton.clicked()){screenManager.setCurrentScreen(ScreenType.STARTSCREEN);}
  }
  
  void keyPressed(){}
  void mouseDragged(){}
  void mouseReleased(){}
  
  // Method for scoreScreen printin the score.txt file to screen
  public void printScoresFile(){
    fill(0, 0, 0);
    textSize(50);
    String[] scores = loadStrings("scores.txt");
    for(int i=0; i<6;i=i +2){
      int noDots = 40 - 2*scores[i].length()- 2*scores[i + 1].length();
      fill(0,0,0);
      String toPrint = scores[i];
      for(int j = 0; j < noDots; j++){
        toPrint = toPrint + ".";
      }
      toPrint = toPrint + scores[i+1];
      text(toPrint,width/2 - width/7.5,height/3+i*height/10);
    }
  }
  
}

public class ScoreScreen extends Screen {
  private ScreenManager screenManager;
  private PImage bgImage, woodBoardImage, menuImage;
  private ImageButton menuButton;
  //ArrayList<ImageButton> buttons;
  
    //constuctor
  public ScoreScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    bgImage = gameImages.get("map");
    woodBoardImage = gameImages.get("woodBoard");
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width - width/10 - 10,height - height/20 - 10,width/5,height/10);  
  }

  //load all the image
  public void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    // Board to display scores on
    image(woodBoardImage, width/2, height/2, width/2, 2*height/3);
    //print the score title
    fill(0, 0, 0);
    textSize(60);
    text("\nBest Pig Protectors",width/2,height/2-height/7,width/3,height/3);
    // printing scores from a text file
    printScoresFile();
    
    menuButton.update();
    menuButton.display();
  }

  public void mousePressed(){
    if(menuButton.clicked()){screenManager.setCurrentScreen(ScreenType.STARTSCREEN);}
  }
  
  public void keyPressed(){}
  public void mouseDragged(){}
  public void mouseReleased(){}
  
  // Method for scoreScreen printin the score.csv file to screen
  public void printScoresFile(){
    fill(0, 0, 0);
    textSize(40);
    StringBuilder toPrint = new StringBuilder();
    int count = 0;

    toPrint.append("\n");

    for (TableRow row : scoreTable.rows()) {
      if (count >= 7 ){
        break;
      }

      String player = row.getString("Player");
      int score = row.getInt("Score");
      int noDots = 40 - 2*player.length()- 2*String.valueOf(score).length();
      toPrint.append(player);
      for (int i = 0; i< noDots; i++){
        toPrint.append(".");
      }

      toPrint.append(score).append("\n\n");
      
      count++;
    }
    String scores = toPrint.toString();

    text(scores,width/2,height/3);


  }
  
}

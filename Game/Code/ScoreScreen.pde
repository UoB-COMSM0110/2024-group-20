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
    textSize(65);
    text("Best Pig Protectors",width/2,height/2-height/4);
    textSize(45);
    text("EASY",width/2-width/8,height/2-height/6);
    text("HARD",width/2+width/8,height/2-height/6);
    strokeWeight(8);
    line(width/2,height/2-height/6,width/2,5*height/7);
    strokeWeight(1);
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
    textSize(35);
    StringBuilder easyToPrint = new StringBuilder();
    StringBuilder hardToPrint = new StringBuilder();
    int eCount = 0,hCount = 0;

    easyToPrint.append("\n");
    hardToPrint.append("\n");

    for (TableRow row : easyScoreTable.rows()) {
      if (eCount >= 7 ){
        break;
      }

      String player = row.getString("Player");
      int score = row.getInt("Score");
      int noDots = 20 - 2*player.length()- 2*String.valueOf(score).length();
      easyToPrint.append(player);
      for (int i = 0; i< noDots; i++){
        easyToPrint.append(".");
      }

      easyToPrint.append(score).append("\n\n");
      
      eCount++;
    }

    for (TableRow row : hardScoreTable.rows()) {
      if (hCount >= 7 ){
        break;
      }

      String player = row.getString("Player");
      int score = row.getInt("Score");
      int noDots = 30 - 2*player.length()- 2*String.valueOf(score).length();
      hardToPrint.append(player);
      for (int i = 0; i< noDots; i++){
        hardToPrint.append(".");
      }

      hardToPrint.append(score).append("\n\n");
      
      hCount++;
    }
    String easyScores = easyToPrint.toString();
    text(easyScores,width/2-width/8,height/3);

    String hardScores = hardToPrint.toString();
    text(hardScores,width/2+width/8,height/3);


  }
  
}

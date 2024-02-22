public class Score{
  
  String playerName;
  int playerScore;
  
  public void setScore(int score){
    playerScore = score;  
  }
  
  public int getScore(){
    return playerScore;
  }
  
  /////
  // Need to add a function updating the score based on the result of the level
  /////
  
  public void setName(String name){
    playerName = name;  
  }
  
  public String getName(){
    return playerName;
  }
  
  // Method writting current player's score to the text file
  public void updateScoresFile(){
    int flag = 0;
    String[] loadedScores = loadStrings("scores.txt");
    String[] finalScores = loadStrings("scores.txt");
    
    for(int i = 0; i < 6; i = i + 2){
      if(Integer.parseInt(loadedScores[i]) <= playerScore && flag == 0){
        finalScores[i] = str(playerScore);
        finalScores[i+1] = playerName;
        if(i+2 < 6){
          finalScores[i+2] = loadedScores[i];
          finalScores[i+3] = loadedScores[i+1];
          i = i + 2;
          flag = 1;
        }
      }else{
        finalScores[i] = loadedScores[i];
        finalScores[i+1] = loadedScores[i+1];
      }
    }
    saveStrings("scores.txt", finalScores);
  }
  
  // Method for scoreScreen printin the score.txt file to screen
  public void printScoresFile(){
    String[] scores = loadStrings("scores.txt");
    for(int i=0; i<6;i=i +2){
      fill(0,0,0);
      text(scores[i],width/2,height/2+i*height/20);
      text(scores[i+1],width/2 + 40,height/2+i*height/20);
    }
  }  
  
  // Method for gameScreen printin the name and score to screen
  public void printCurrentPlayerScore(){
     fill(0, 0, 0);
     textSize(30);
     text(playerName + "   Score: " + str(playerScore), width-width/5,height/20);
  }  
}

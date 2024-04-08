public enum Difficulty {
  NOTSET, EASY, HARD
}

public class Player{
  
  private String playerName;
  private int playerScore;
  private boolean scoreSet;
  private boolean nameSet;
  private Difficulty difficulty;

  
  Player(){
    playerName = "";
    scoreSet = false;
    nameSet = false;
    difficulty = Difficulty.NOTSET;
  }
  
  public void setPlayerName(String str) {
    playerName = str;
    nameSet = true;
  }
  
  public String getPlayerName() {
    return playerName;
  }
  
  public boolean isNameSet(){
    return nameSet;  
  }
  
  public void setScore(int score){
    playerScore = score;  
  }
  
  public int getPlayerScore(){
    return playerScore;
  }
  
  public Difficulty getDifficulty(){
    return difficulty;
  }
  
  ////SETTING GAME DIFFICULTY/////////////////////////////////////////////////////////////////////////
  public void setDifficulty(Difficulty chosen){
    if(chosen == Difficulty.EASY){
      this.difficulty = Difficulty.EASY;
    }
    if(chosen == Difficulty.HARD){
      this.difficulty = Difficulty.HARD;
    }
  }
  
  void deletePlayer(){
    playerName = ""; 
    playerScore = 0;
    scoreSet = false;
    nameSet = false;
    difficulty = Difficulty.NOTSET;
  }
  
  ////SCORE RELATED/////////////////////////////////////////////////////////////////////////
  
  // Method for updating the user's score
  public void updateScore(Level currentLevel, int levelNo){
    // Budget left  
    int newPoints = currentLevel.getBudget();
    // Pigs Alive
    newPoints = newPoints + currentLevel.numberPigsAlive() * 100;
    // Level
    newPoints = newPoints + levelNo * 100;
    playerScore = playerScore + newPoints;
    // Difficulty Bonus (extra 100 points for HARD)
    newPoints = newPoints + 100;
    playerScore = playerScore + newPoints;    
  }
  
  // Method writting current player's score to the text file
  public void updateScoresFile(){
    if(!this.scoreSet){
      int flag = 0;
      String[] loadedScores = loadStrings("scores.txt");
      String[] finalScores = loadStrings("scores.txt");
    
      for(int i = 0; i < 6; i = i + 2){
        if(Integer.parseInt(loadedScores[i]) <= playerScore && flag == 0){
          if(i == 0){
            finalScores[i+4] = loadedScores[i+2];
            finalScores[i+5] = loadedScores[i+3];
            finalScores[i+2] = loadedScores[i];
            finalScores[i+3] = loadedScores[i+1];
            finalScores[i] = str(playerScore);
            finalScores[i+1] = playerName;
            flag = 1;  
          }else if(i == 2){
            finalScores[i+2] = loadedScores[i];
            finalScores[i+3] = loadedScores[i+1];
            finalScores[i] = str(playerScore);
            finalScores[i+1] = playerName;
            flag = 1;
          }else{
            finalScores[i] = str(playerScore);
            finalScores[i+1] = playerName;
          }
        }
      }
      saveStrings("scores.txt", finalScores);
      this.scoreSet = true;
    }
  }
  
  ////PRINTING/////////////////////////////////////////////////////////////////////////
  
  
  // Method for gameScreen printin the name and score to screen
  public void printCurrentPlayerScore(){
     fill(0, 0, 0);
     textSize(40);
     text(playerName + "   Score: " + str(playerScore), width-width/5,height/15);
  }  
  
}

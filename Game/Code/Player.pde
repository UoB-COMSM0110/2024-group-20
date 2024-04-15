public enum Difficulty {
  NOTSET, EASY, HARD
}

public class Player{
  
  private String playerName;
  private int playerScore;
  private boolean scoreSet;
  private boolean nameSet;
  private Difficulty difficulty;

  public Player(){
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
    this.difficulty = chosen;
  }
  
  public void deletePlayer(){
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
      if (this.difficulty == Difficulty.EASY){
        TableRow newRow = easyScoreTable.addRow();
        newRow.setString("Player", playerName);
        newRow.setInt("Score", playerScore);
        easyScoreTable.sortReverse("Score");

        saveTable(easyScoreTable,"easyScores.csv");
      }
      if (this.difficulty == Difficulty.HARD){
        TableRow newRow = hardScoreTable.addRow();
        newRow.setString("Player", playerName);
        newRow.setInt("Score", playerScore);
        hardScoreTable.sortReverse("Score");

        saveTable(hardScoreTable,"hardScores.csv");
      }
      this.scoreSet = true;
    }
  }
  
}

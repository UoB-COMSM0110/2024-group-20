public class UserScore{
  
  String playerName;
  String tempName;
  int noLetters;
  int indx;
  int playerScore;
  
  UserScore(){
    playerName = "";
    tempName = "_ _ _ _ _ _ _ _ _ _";  
    noLetters = 0;
    indx = 0;
  }
  
  public void setScore(int score){
    playerScore = score;  
  }
  
  public int getScore(){
    return playerScore;
  }
  
  public int getNoLetters(){
    return noLetters;  
  }
  
  // Function detecting which key was pressed and updating players name according to that
  public void pressedKey(char key){
    if('a' <= key && key <= 'z'){
      addLetter(key);
    }
    if('A' <= key && key <= 'Z'){
      addLetter(key);
    }
    if('0' <= key && key <= '9'){
      addLetter(key);
    }
    if(key == BACKSPACE){
      deleteLetter();
    } 
    if(key == ENTER){
      noMoreLettes();
    } 
  }
  
  // Function for adding letters and numbers to the name of the user 
  public void addLetter(char letter){
    tempName = tempName.substring(0, indx) + letter + tempName.substring(indx + 1);
    indx = indx + 2;
    noLetters = noLetters + 1;
    if(noLetters == 10){
      setToFinalName();
    }
  }
  
  // Function to delete a letter or number entered bu the user in their name 
  public void deleteLetter(){
    indx = indx - 2;
    noLetters = noLetters - 1;   
    tempName = tempName.substring(0, indx) + '_' + tempName.substring(indx + 1);
  }
  
  // Function for signaling that the user entered their name
  public void noMoreLettes(){
    tempName = tempName.replaceAll("_", "");
    noLetters = 10;
    setToFinalName();
  }
  
  // Displaying to the player what name they entered so far
  public void printTempName(){
   text(tempName, width/2, height/2); 
   textAlign(CENTER);
  }
  
  // Function allowing player to enter their name
  void enterPlayerName(){
      fill(0 ,0, 0);
      textSize(50);
      text("Enter your name:", width/2, height/3);
      textAlign(CENTER);
      printTempName();    
  }
  
  // Updating name to the final name that player chose
  public void setToFinalName(){
    playerName = tempName.replaceAll(" ", "");
  }
  
  // Method for updating the user's score
  public void updateScore(int newPoints){
    playerScore = playerScore + newPoints;
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
  
  // Method for gameScreen printin the name and score to screen
  public void printCurrentPlayerScore(){
     fill(0, 0, 0);
     textSize(40);
     text(playerName + "   Score: " + str(playerScore), width-width/5,height/15);
  }  


}

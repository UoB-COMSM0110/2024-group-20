Score testScore;

void setup (){

  testScore = new Score();
  
  testScore.setScore(30);
  testScore.setName("Anna");
  testScore.updateScoresFile();
    
  testScore.setScore(20);
  testScore.setName("Zuza");
  testScore.updateScoresFile();
  
  testScore.setScore(10);
  testScore.setName("Maja");
  testScore.updateScoresFile();
  
  testScore.setScore(20);
  testScore.setName("Zuza");
  testScore.updateScoresFile();
}

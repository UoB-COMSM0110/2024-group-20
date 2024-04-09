public enum Resource {
  WOOD, GLASS, STONE
}

public class Level{
  private boolean levelFailed;
  private int levelStage; // 0 - not set, 1 - set and building, 2 - structures build, birds attack
  private int levelNo;
  private Difficulty difficulty;
  private int budget;
  
  private int noPigs;
  private Pig pigsOnLevel[];
  
  private int noBirds;
  private Bird birdsOnLevel[];
  
/////////////////////////////////////////////////////////////////////////////////////////////////
  public Level(int budget, int noPigs, int noBirdsRed, int noBirdsBlue, int noBirdsBlack, Difficulty difficulty, int levelNo){
    this.levelFailed = false;
    this.levelStage = 0;
    this.levelNo = levelNo;
    this.difficulty = difficulty;
    
    this.budget = budget;
    this.noPigs = noPigs;
    pigsOnLevel = new Pig[noPigs];
    for(int i = 0; i < noPigs; i++){
      pigsOnLevel[i] = new Pig(new PVector(width/5 + (10 * i), height/5));
    }
    setPigPositions();


    this.noBirds = noBirdsRed + noBirdsBlue + noBirdsBlack;
    birdsOnLevel = new Bird[this.noBirds];
    for(int i = 0; i < noBirdsRed; i++){
     birdsOnLevel[i] = new BirdBlack(new PVector(2 * width/5 + (10 * i), 2*  height/5));
    }
    for(int i = noBirdsRed; i <  noBirdsRed + noBirdsBlue; i++){
      birdsOnLevel[i] = new BirdBlue(new PVector(2 * width/5 + (10 * i), 3 * height/5));
    }
    for(int i = noBirdsRed + noBirdsBlue; i < this.noBirds; i++){
      birdsOnLevel[i] = new BirdBlack(new PVector(2 * width/5 + (10 * i), 4 * height/5));
    }
  }
  
  public int getBudget(){
    return budget;
  }
  
  public int getNoBirds(){
   return noBirds; 
  }
  
  public boolean isLevelFailed(){
    return levelFailed;
  }
  
  public int getStage(){
   return levelStage; 
  }
  
  // Adding all Pigs to the level
  public void stagePigsOnLevel(World w, ArrayList<Circle> animals){
    for(Pig currentPig:pigsOnLevel){
      w.addBody(currentPig);
      animals.add(currentPig);
    }
    levelStage = 1;
  }
  
  private void setPigPositions(){
    if(levelNo == 0){
      pigsOnLevel[0].setPosition(new PVector(width/2, height - 160));
    }
    if(levelNo == 1){
      pigsOnLevel[0].setPosition(new PVector(width/4, height - 160));
      pigsOnLevel[1].setPosition(new PVector(3*width/4, height - 160));

    }
    if(levelNo == 2){
      pigsOnLevel[0].setPosition(new PVector(width/6, height - 160));
      pigsOnLevel[1].setPosition(new PVector(2 * width/6, height - 160));
      pigsOnLevel[2].setPosition(new PVector(4 * width/6, height - 160));

    }
    
  }
  
  public void stageBirdsOnLevel(ArrayList<Circle> animals){
    for(Bird currentBird:birdsOnLevel){
      animals.add(currentBird);
    } 
  }
  
  public void stageStructuresReady(){
    levelStage = 2; 
  }
  
  
  public boolean buyResource(Resource material){
    if(material == Resource.GLASS){
      if(budget >= 50){
        budget = budget - 50;
        return true;
      }
    }
    if(material == Resource.WOOD){
      if(budget >= 100){
        budget = budget - 100;
        return true;
      }
    }
    if(material == Resource.STONE){
      if(budget >= 150){
        budget = budget - 150;
        return true;
      }
    }
    return false;
  }

  public void printLevelBudget(){
     fill(0, 0, 0);
     textSize(40);
     text("Budget: " + str(budget), width-width/5,height/10);
  }  
  
  public int numberPigsAlive(){
    int alivePigs = 0;
    for(int i = 0; i < noPigs; i++){
       if(pigsOnLevel[i].isAlive()){
         alivePigs ++; 
       }
    }
    return alivePigs;
  }
  
}

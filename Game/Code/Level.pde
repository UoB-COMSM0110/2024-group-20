public enum Resource {
  WOOD, GLASS, STONE
}

class Level{
  
  private boolean levelFailed;
  private boolean structureBuild;
  private Difficulty difficulty;
  private int budget;
  
  private int noPigs;
  private Pig pigsOnLevel[];
  
  private int noBirds;
  private Bird birdsOnLevel[];
    
  public int getBudget(){
    return budget;
  }
  
  public boolean isLevelFailed(){
    return levelFailed;
  }
  
  public Level(int budget, int noPigs, int noBirdsRed, int noBirdsBlue, int noBirdsBlack, Difficulty difficulty){
    this.levelFailed = false;
    this.structureBuild = false;
    this.difficulty = difficulty;
    
    this.budget = budget;
    this.noPigs = noPigs;
    pigsOnLevel = new Pig[noPigs];
    for(int i = 0; i < noPigs; i++){
      pigsOnLevel[i] = new Pig(new PVector(width/5 + (10 * i), height/5));
    }
    
    this.noBirds = noBirdsRed + noBirdsBlue + noBirdsBlack;
    birdsOnLevel = new Bird[this.noBirds];
    for(int i = 0; i < noBirdsRed; i++){
     birdsOnLevel[i] = new BirdRed(new PVector(2 * width/5 + (10 * i), 2*  height/5));
    }
    for(int i = noBirdsRed; i <  noBirdsRed + noBirdsBlue; i++){
      birdsOnLevel[i] = new BirdBlue(new PVector(2 * width/5 + (10 * i), 3 * height/5));
    }
    for(int i = noBirdsRed + noBirdsBlue; i < this.noBirds; i++){
      birdsOnLevel[i] = new BirdBlack(new PVector(2 * width/5 + (10 * i), 4 * height/5));
    }
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
  
  public void readyWithStructure(){
    structureBuild = true;
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
  
  public void printAllPigs(){
    for(int i = 0; i < noPigs; i++){
      pigsOnLevel[i].display();  
    }
  }

  public void printAllBirds(){
    if(structureBuild){
      for(int i = 0; i < noBirds; i++){
        birdsOnLevel[i].display();  
      }
    }
  }
  
}

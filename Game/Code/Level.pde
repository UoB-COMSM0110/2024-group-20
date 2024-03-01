/*class Level{
  
  boolean levelFailed;
  int budget;
  int noPigs;
  Pig pigsOnLevel[];
  int noBirds;
  Bird birdsOnLevel[];
  // Array of structures(wood, glass, steel)
  
  public Level(int budget, int noPigs, int noBirdsRed, int noBirdsBlue, int noBirdsBlack){
   this.levelFailed = false;
   this.budget = budget;
   this.noPigs = noPigs;
   for(int i = 0; i < noPigs; i++){
     pigsOnLevel[i] = new Pig(new PVector(0,0));
   }
   this.noBirds = this.noBirds + noBirdsRed;
   for(int i = 0; i < noBirdsRed; i++){
     birdsOnLevel[i] = new BirdRed(new PVector(0,0));
   }
   for(int i = this.noBirds; i < noBirdsRed; i++){
     birdsOnLevel[i] = new BirdBlue(new PVector(0,0));
   }
   this.noBirds = this.noBirds + noBirdsBlue;
   for(int i = this.noBirds; i < noBirdsBlack; i++){
     birdsOnLevel[i] = new BirdBlack(new PVector(0,0));
   }
   this.noBirds = this.noBirds + noBirdsBlack;
    
  }
  

  
  
  
  
  
}*/

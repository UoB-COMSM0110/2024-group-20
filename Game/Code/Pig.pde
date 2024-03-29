PImage pigDead;
PImage pigAlive;

public class Pig extends Circle{
  
  // If pig gets hit by a bird it get's killed and dissapears
  private boolean alive;
  
  public Pig(PVector location){
    super(location, 0.6f, 0.5f, false, 5.0, 54, new PVector(0,0));
    alive = true;
  }

  public void display(){
    pigAlive = loadImage("../Images/pigAlive.png");
    pigDead = loadImage("../Images/pigDead.png");
    if(alive == true){
      image(pigAlive, position.x - 54, position.y - 56); 
    }else{
      image(pigDead, position.x - 54, position.y - 56);       
    }
  }
  
  // Add how to kill the pig
  public void killPig(){
    alive = false;
  }
  
  public boolean isAlive(){
    return alive;
  }
  
  
}

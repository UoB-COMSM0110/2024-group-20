PImage pigDead;
PImage pigAlive;

public class Pig extends Circle{
  
  // If pig gets hit by a bird it get's killed and dissapears
  private boolean alive;
  
  public Pig(PVector location){
    //PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation
    super(location, 0.6f, 0.5f, false, 55, 54);
    alive = true;
    pigAlive = loadImage("../Images/pigAlive.png");
    pigDead = loadImage("../Images/pigDead.png");
  }

  public void display(){
    if(alive == true){
      image(pigAlive, this.getCoorX(), this.getCoorY() - 2); 
    }else{
      image(pigDead, this.getCoorX(), this.getCoorY() - 2);       
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

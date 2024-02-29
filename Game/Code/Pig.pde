public class Pig extends Circle{
  
  // If pig gets hit by a bird it get's killed and dissapears
  boolean alive;
  
  public Pig(PVector location){
    super(location, 0.6f, 0.5f, false, 5.0);
    alive = true;
  }

  public void drawPig(){
    fill(0, 255, 0);
    circle(this.getCoorX(), this.getCoorY(),width/20); 
  }
  
  // How to kill the pig
  public void killPig(){
    alive = false;
  }
  
  
}

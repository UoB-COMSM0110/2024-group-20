public class Pig extends Circle{
  
  // If pig gets hit by a bird it get's killed and dissapears
  private boolean alive;
  
  public Pig(PVector location){
    //PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation
    super(location, 0.6f, 0.5f, false, 55, 54);
    alive = true;
  }

  @Override
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    if(alive == true){
      image(imageMap.get("pigAlive"), 2, 0); 
    }else{
      image(imageMap.get("pigDead"), 2, 0);       
    }
    popMatrix();
  }
  
  // Add how to kill the pig
  public void killPig(){
    alive = false;
  }
  
  public boolean isAlive(){
    return alive;
  }
  
  
}


public enum BirdType {
  RED, BLUE, BLACK
}

public class Bird extends Circle{
  
  BirdType birdType;
  
  public Bird(PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType){
    super(location, density, restitution, isStatic, radius, 0);
    this.birdType = birdType;
  }
  
  public void drawBird(){
  }

}

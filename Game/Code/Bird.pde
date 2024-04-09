public enum BirdType {
  RED, BLUE, BLACK
}

public class Bird extends Circle{
  protected float impulseToughness;
  
  BirdType birdType;
  
  public Bird(PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType){
    //PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation
    super(location, density, restitution, isStatic, radius, 0);
    this.birdType = birdType;
  }
  
  public void display(){}
  
  public float getImpulseToughness(){
    return impulseToughness;
  }
  
}

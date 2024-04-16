public enum BirdType {
  RED, BLUE, BLACK, PURPLE
}

public class Bird extends Circle{
  protected float impulseToughness;
  
  protected BirdType birdType;
  protected PImage icon;
  float iconOffsetX, iconOffsetY;
  
  public Bird(PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType){
    //PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation
    super(location, density, restitution, isStatic, radius, 0);
    this.birdType = birdType;
  }
  
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    image(icon, iconOffsetX, iconOffsetY); 
    popMatrix();
  }
  
  public float getImpulseToughness(){
    return impulseToughness;
  }
  
  public PImage getIcon(){
    return icon;
  }
  
}

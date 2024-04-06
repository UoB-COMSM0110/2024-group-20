PImage redBird;

public class BirdRed extends Bird{
  
  public BirdRed(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 53, BirdType.RED);
    redBird = loadImage("../Images/birdRed.png");
  }

  @Override
  public void display(){
    image(redBird, this.getCoorX(), this.getCoorY() - 20); 
  }
}

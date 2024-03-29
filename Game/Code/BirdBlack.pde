PImage blackBird;

public class BirdBlack extends Bird{
  
  public BirdBlack(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 60, BirdType.BLACK);
  }

  public void display(){
    blackBird = loadImage("../Images/birdBlack.png");
    image(blackBird, position.x - 60, position.y - 72); 
  }
}

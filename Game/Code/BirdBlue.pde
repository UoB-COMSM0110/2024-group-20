PImage blueBird;

public class BirdBlue extends Bird{
  
  public BirdBlue(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 49, BirdType.BLUE);
  }

  public void display(){
    blueBird = loadImage("../Images/birdBlue.png");
    image(blueBird, this.getCoorX() - 50, this.getCoorY() - 70); 
  }
}

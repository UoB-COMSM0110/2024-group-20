//PImage birdBlack;

public class BirdBlack extends Bird{
  
  public BirdBlack(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 60, BirdType.BLACK);
    //birdBlack = loadImage("../Images/birdBlack.png");
    
  }

  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    //image(blackBird, -60, -72); 
    image(imageMap.get("birdBlack"), 0, -12); 
    popMatrix();
  }
}

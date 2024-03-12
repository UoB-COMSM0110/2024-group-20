
public class BirdBlack extends Bird{
  
  public BirdBlack(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 4, BirdType.BLACK);
  }

  public void drawBird(){
    fill(0, 0, 0);
    circle(this.getPosition().x, this.getPosition().y,width/20); 
  }
}

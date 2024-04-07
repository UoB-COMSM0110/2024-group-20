public class BirdRed extends Bird{
  
  public BirdRed(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 53, BirdType.RED);
  }

  @Override
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    image(gameImages.get("birdRed"), 0, -10); 
    popMatrix();
  }
}

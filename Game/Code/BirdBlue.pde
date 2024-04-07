public class BirdBlue extends Bird{
  
  public BirdBlue(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 49, BirdType.BLUE);
  }

  @Override
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    image(imageMap.get("birdBlue"), 0, -10); 
    popMatrix();
  }
}

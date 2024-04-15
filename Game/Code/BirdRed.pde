public class BirdRed extends Bird{
  
  public BirdRed(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 53, BirdType.RED);
    impulseToughness = 1e7;
    icon = gameImages.get("birdRed");
    iconOffsetY = -10;
  }
}

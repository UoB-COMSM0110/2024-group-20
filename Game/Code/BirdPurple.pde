public class BirdPurple extends Bird{
  private boolean hasAbility = true;
  
  public BirdPurple(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 49, BirdType.PURPLE);
    impulseToughness = 12e6;
    icon = gameImages.get("birdPurple");
    iconOffsetY = -10;
  }
  
  public boolean hasAbility() {
    return hasAbility;
  }
  
  public void reverseGravity(PVector gravity) {
    RigidBody body = this.lastContactBody;
    body.setLinearAcceleration(PVector.mult(gravity, -2));
    hasAbility = false;
  }
}

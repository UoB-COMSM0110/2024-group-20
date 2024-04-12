public class BirdBlue extends Bird{
  private boolean hasAbility = true;
  
  public BirdBlue(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 49, BirdType.BLUE);
    impulseToughness = 6e6;
  }

  @Override
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    image(gameImages.get("birdBlue"), 0, -10); 
    popMatrix();
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

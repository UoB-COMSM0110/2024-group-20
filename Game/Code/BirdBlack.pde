public class BirdBlack extends Bird{
  private float explosionImpulse = 5E7;
  private float explosionRadius = circleRadius * 4;
  
  public BirdBlack(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 60, BirdType.BLACK);
    icon = gameImages.get("birdBlack");
    iconOffsetY = -6;
  }
  
  public void explode(World w) {
    ArrayList<RigidBody> bodyList = w.getBodyList();
    float distance, impulse;
    PVector body1Position = this.getPosition();
    PVector body2Position, body2LinVelocity, body2NewLinVelocity;
    for(RigidBody body2:bodyList) {
      body2Position = body2.getPosition();
      distance = PVector.dist(body1Position, body2Position);
      if(distance < explosionRadius) {
        impulse = explosionImpulse * (explosionRadius - distance) / explosionRadius;
        body2.updateLargestImpulse(impulse);
        
        body2LinVelocity = body2.getLinearVelocity();
        body2NewLinVelocity = PVector.add(body2LinVelocity, PVector.sub(body2Position, body1Position).normalize().mult(impulse / body2.getMass()));
        body2.setLinearVelocity(body2NewLinVelocity);
      }
    }
  }
}

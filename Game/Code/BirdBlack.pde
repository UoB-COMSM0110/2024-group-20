public class BirdBlack extends Bird{
  float explosionImpulse = 5E7;
  float explosionRadius = circleRadius * 4;
  
  public BirdBlack(PVector location){
    //PVector location,float density, float restitution, boolean isStatic, float radius, BirdType birdType
    super(location, 0.5f, 0.4f, false, 60, BirdType.BLACK);
  }

  @Override
  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    image(gameImages.get("birdBlack"), 0, -6); 
    popMatrix();
  }
  
  void explode(World w) {
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

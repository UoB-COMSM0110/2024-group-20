public enum ShapeType {
  CIRCLE, RECTANGLE
}

public abstract class RigidBody{
  
  protected PVector position = new PVector(0,0);
  protected PVector linearVelocity = new PVector(0,0);
  protected PVector linearAcceleration = new PVector(0,0);
  protected float rotation;
  protected float angularVelocity;
  protected float angularAcceleration;
  
  protected float density;
  protected float area;
  protected float mass;
  protected float restitution;
  protected float frictionRestitution;
  protected float angularInertia;
  protected ShapeType shapeType;
  protected boolean isStatic;
  protected float largestImpulse;
  
  public void calculateMass() {
    if(isStatic) {
      mass = Float.MAX_VALUE/1E10;
    }
    else {
      mass = area * density;
    }
  }
  
  protected abstract void calculateArea();
  protected abstract void calculateAngularInertia();
  
  public float getMass() {
    return mass;
  }
  
  public PVector getPosition() {
    return position;
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public float getRestitution() {
    return restitution;
  }
  
  public PVector getLinearVelocity(){
    return linearVelocity;
  }
  
  public void setLinearVelocity(PVector linearVelocity) {
    this.linearVelocity = linearVelocity;
  }
  
  public PVector getLinearAcceleration(){
    return this.linearAcceleration;
  }
  
  public float getAngularVelocity(){
    return angularVelocity;
  }
  
  public void setAngularVelocity(float angularVelocity){
    this.angularVelocity = angularVelocity;
  }
  
  public float getAngularInertia() {
    return angularInertia;
  }
  
  public boolean isStatic() {
    return isStatic;
  }
  
  public float getFrictionRestitution() {
    return frictionRestitution;
  }
  
  public void step(float frameTime, PVector gravity, float linearVelocityFactor) {
    if(this.isStatic) {
      return;
    }
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    linearVelocity.add(PVector.mult(linearAcceleration, frameTime)).add(PVector.mult(gravity, frameTime)).mult(linearVelocityFactor);
    
    rotation += angularVelocity * frameTime + 0.5 * angularAcceleration * frameTime * frameTime;
    angularVelocity +=  angularAcceleration * frameTime;
  }
  
  public abstract void display();
  
  public abstract boolean intersect(RigidBody other);
  public abstract boolean intersect(Circle other);
  public abstract boolean intersect(Rectangle other);
  
  public void resolveCollision(RigidBody body1, RigidBody body2, PVector body1ContactPosition, PVector body2ContactPosition, PVector forceDirection, float overlap) {
    // for without friction
    PVector body1LinVelocity = body1.getLinearVelocity();
    float body1AngVelocity = body1.getAngularVelocity();
    float body1Restitution = body1.getRestitution();
    float body1Mass = body1.getMass();
    float body1AngInertia = body1.getAngularInertia();
    
    PVector body2LinVelocity = body2.getLinearVelocity();
    float body2AngVelocity = body2.getAngularVelocity();
    float body2Restitution = body2.getRestitution();
    float body2Mass = body2.getMass();
    float body2AngInertia = body2.getAngularInertia();
    
    // Push objects away from each other
    float massSum = body1Mass + body2Mass;
    body1.getPosition().sub(PVector.mult(forceDirection,overlap*body2Mass/massSum));
    body2.getPosition().add(PVector.mult(forceDirection,overlap*body1Mass/massSum));
    
    
    // velocities at contact point
    PVector body1ContactLinAngVelocity = new PVector(-body1AngVelocity * body1ContactPosition.y, body1AngVelocity * body1ContactPosition.x);
    PVector body1ContactLinVelocity = PVector.add(body1LinVelocity, body1ContactLinAngVelocity);
    PVector body2ContactLinAngVelocity = new PVector(-body2AngVelocity * body2ContactPosition.y, body2AngVelocity * body2ContactPosition.x);
    PVector body2ContactLinVelocity = PVector.add(body2LinVelocity, body2ContactLinAngVelocity);
    
    PVector diffLinVelocity = PVector.sub(body2ContactLinVelocity, body1ContactLinVelocity);
    float normDiffLinVelocity = PVector.dot(diffLinVelocity, forceDirection);
  
    // If the two contact points are moving away from each other, do not proceed
    if (normDiffLinVelocity > 0) {
      return;
    }
    
    PVector tangentDirection = forceDirection.copy().rotate(HALF_PI);
    float body1MomentLength = PVector.dot(body1ContactPosition, tangentDirection);
    float body2MomentLength = PVector.dot(body2ContactPosition, tangentDirection);
    
    // Calculate the value of impulse
    float cor = body1Restitution * body2Restitution;
    float impulse = -(1 + cor) * normDiffLinVelocity / (1 / body1Mass + 1 / body2Mass + body1MomentLength*body1MomentLength/body1AngInertia + body2MomentLength*body2MomentLength/body2AngInertia);
    
    // apply reaction to body1
    PVector body1NewLinVelocity = PVector.sub(body1LinVelocity, PVector.mult(forceDirection, impulse / body1Mass));
    //body1.setLinearVelocity(body1NewLinVelocity);
    float body1AngImpulse = impulse * body1MomentLength;
    float body1DiffAngVelocity = body1AngImpulse / body1AngInertia;
    float body1NewAngVelocity = body1AngVelocity + body1DiffAngVelocity;
    //body1.setAngularVelocity(body1NewAngVelocity);
    
    // apply reaction to body2
    PVector body2NewLinVelocity = PVector.add(body2LinVelocity, PVector.mult(forceDirection, impulse / body2Mass));
    //body2.setLinearVelocity(body2NewLinVelocity);
    float body2AngImpulse = -impulse * body2MomentLength;
    float body2DiffAngVelocity = body2AngImpulse / body2AngInertia;
    float body2NewAngVelocity = body2AngVelocity + body2DiffAngVelocity;
    //body2.setAngularVelocity(body2NewAngVelocity);
    
    body1.largestImpulse = max(body1.largestImpulse, abs(impulse));
    body2.largestImpulse = max(body2.largestImpulse, abs(impulse));
    
    // for friction  //////////////////////////////////////////////////////////
    float tangDiffLinVelocity = PVector.dot(diffLinVelocity, tangentDirection);
    float body1FrictionRes = body1.getFrictionRestitution();
    float body2FrictionRes = body2.getFrictionRestitution();
    
    body1MomentLength = PVector.dot(body1ContactPosition, forceDirection);
    body2MomentLength = PVector.dot(body2ContactPosition, forceDirection);
    
    float frictionCOR = body1FrictionRes * body2FrictionRes;
    float frictionImpulse = -0.5*frictionCOR * tangDiffLinVelocity / (1 / body1Mass + 1 / body2Mass + body1MomentLength*body1MomentLength/body1AngInertia + body2MomentLength*body2MomentLength/body2AngInertia);
    
    // apply reaction to body1
    body1NewLinVelocity = PVector.sub(body1NewLinVelocity, PVector.mult(tangentDirection, frictionImpulse / body1Mass));
    body1AngImpulse = -frictionImpulse * body1MomentLength;
    body1DiffAngVelocity = body1AngImpulse / body1AngInertia;
    body1NewAngVelocity = body1NewAngVelocity + body1DiffAngVelocity;
    
    // apply reaction to body2
    body2NewLinVelocity = PVector.add(body2NewLinVelocity, PVector.mult(tangentDirection, frictionImpulse / body2Mass));
    body2AngImpulse = frictionImpulse * body2MomentLength;
    body2DiffAngVelocity = body2AngImpulse / body2AngInertia;
    body2NewAngVelocity = body2NewAngVelocity + body2DiffAngVelocity;
    
    body1.setLinearVelocity(body1NewLinVelocity);
    body1.setAngularVelocity(body1NewAngVelocity);
    body2.setLinearVelocity(body2NewLinVelocity);
    body2.setAngularVelocity(body2NewAngVelocity);
  }
}

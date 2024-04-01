public enum ShapeType {
  CIRCLE, RECTANGLE
}

public abstract class RigidBody{
  
  protected PVector position = new PVector(0,0);
  protected PVector linearVelocity = new PVector(0,0);
  protected PVector linearAcceleration = new PVector(0,0);
  protected float rotation;
  protected float rotationVelocity;
  protected float rotationAcceleration;
  protected float density;
  protected float mass;
  protected float massInvers;
  protected float restitution;
  protected float area;
  protected float angularInertia;
  protected ShapeType shapeType;
  protected boolean isStatic;
  protected boolean isSelected = false;
  
  public boolean getIsSelected(){
   return isSelected; 
  }
  
  public void calculateMass() {
    mass = area * density;
    calculateMassInvers();
  }
  
  public void calculateMassInvers() {
    if(!this.isStatic){
      massInvers = 1/mass;
    }
    else{
     massInvers = 0; 
    }
  }
  
  protected abstract void calculateArea();
  protected abstract void calculateAngularInertia();
  
  public PVector getPosition() {
    return position;
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public PVector getLinearVelocity(){
    return this.linearVelocity;
  }
  
  public PVector getLinearAcceleration(){
    return this.linearAcceleration;
  }
  
  public void noForces(){
    isSelected = true; 
  }
  
  public void allowForces(){
    isSelected = false; 
  }
  
  public void step(float frameTime, PVector gravity, float dragCoefficient) {
    //Change velocity to the next step
    if(isSelected){
      linearVelocity = new PVector(0 ,0); 
    }
    else if(!isStatic){
      linearVelocity.add(PVector.mult(linearAcceleration, frameTime)).add(PVector.mult(gravity, frameTime)).mult(dragCoefficient); 
    }
    else{
      linearVelocity.add(PVector.mult(linearAcceleration, frameTime)); 
    }
    //Change position to the next step
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    
    //Change rotation to the next step
    rotation += rotationVelocity * frameTime + 0.5 * rotationAcceleration * frameTime * frameTime;
    rotationVelocity += rotationAcceleration * frameTime;
    this.linearAcceleration = new PVector(0,0);
  }
  
  public void applyForce(PVector force){
    calculateMass();
    this.linearAcceleration = PVector.div(force, this.mass);
    print(this.mass + "\n");
  }
  
  public abstract void display();
  
  public abstract boolean intersect(RigidBody other);
  public abstract boolean intersect(Circle other);
  public abstract boolean intersect(Rectangle other);
  
  public void resolveCollision(RigidBody other, PVector forceDirection, float overlap){
    float e = min(this.restitution, other.restitution);
    PVector relativeVelocity = PVector.sub(other.linearVelocity, this.linearVelocity);

    float j = -(1 + e) * PVector.dot(relativeVelocity, forceDirection);
    j = j / (this.massInvers + other.massInvers);
    PVector impulse = PVector.mult(forceDirection, j);
    PVector resolutionA = PVector.mult(impulse, this.massInvers);
    this.linearVelocity.sub(resolutionA);

    PVector resolutionB = PVector.mult(impulse, other.massInvers);
    other.linearVelocity.add(resolutionB);
  }
  
}

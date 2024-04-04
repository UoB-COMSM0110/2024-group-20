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
  protected float mass;
  protected float restitution;
  protected float area;
  protected float angularInertia;
  protected ShapeType shapeType;
  protected boolean isStatic;
  
  public void calculateMass() {
    mass = area * density;
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
  
  public void step(float frameTime, PVector gravity, float dragCoefficient) {
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    linearVelocity.add(PVector.mult(linearAcceleration, frameTime)).add(PVector.mult(gravity, frameTime)).mult(dragCoefficient);
    
    rotation += angularVelocity * frameTime + 0.5 * angularAcceleration * frameTime * frameTime;
    angularVelocity +=  angularAcceleration * frameTime;
  }
  
  public abstract void display();
  
  public abstract boolean intersect(RigidBody other);
  public abstract boolean intersect(Circle other);
  public abstract boolean intersect(Rectangle other);
  
  
}

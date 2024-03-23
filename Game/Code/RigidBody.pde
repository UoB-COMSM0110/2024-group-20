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
  
  public void step(float frameTime, PVector gravity, float dragCoefficient) {
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    linearVelocity.add(PVector.mult(linearAcceleration, frameTime)).add(PVector.mult(gravity, frameTime)).mult(dragCoefficient);
    
    rotation += rotationVelocity * frameTime + 0.5 * rotationAcceleration * frameTime * frameTime;
    rotationVelocity += rotationAcceleration * frameTime;
  }
  
  public abstract void display();
  
  public abstract boolean intersect(RigidBody other);
  public abstract boolean intersect(Circle other);
  public abstract boolean intersect(Rectangle other);
  
}

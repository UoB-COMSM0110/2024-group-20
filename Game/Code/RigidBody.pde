public enum ShapeType {
  CIRCLE, RECTANGLE
}

public abstract class RigidBody extends PShape{
  
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
  
  protected String errorMessage = "";
  
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
  
  public boolean areValuesValid() {
    if (area < 0.01f * 0.01f){
      errorMessage = "Area is too small. Min area is 0.01f * 0.01f.";
      return false;
    }
    if (area > 64f * 64f){
      errorMessage = "Area is too large. Min area is 64f * 64f.";
      return false;
    }
    if (density < 0.5f){
      errorMessage = "Density is too small. Min density is 0.5f.";
      return false;
    }
    if (density > 21.4f){
      errorMessage = "Density is too large. Min density is 21.4f.";
      return false;
    }
    restitution = constrain(restitution, 0f, 1f);
    return true;
  }
  
  public void step(float frameTime, PVector gravity, float dragCoefficient) {
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    linearVelocity.add(PVector.mult(linearAcceleration, frameTime)).add(PVector.mult(gravity, frameTime)).mult(dragCoefficient);
    
    rotation += rotationVelocity * frameTime + 0.5 * rotationAcceleration * frameTime * frameTime;
    rotationVelocity += rotationAcceleration * frameTime;
  }
  
  public abstract void display();
}

public enum ShapeType {
  CIRCLE, RECTANGLE
}

public abstract class RigidBody extends PShape{
  
  protected PVector position;
  protected PVector linearVelocity;
  protected PVector linearAcceleration;
  protected float rotation;
  protected float rotationVelocity;
  protected float rotationAcceleration;
  
  protected float density;
  protected float mass;
  protected float restitution;
  protected float area;
  protected ShapeType shapeType;
  protected boolean isStatic;
  
  protected String errorMessage = "";
  
  public void calculateMass() {
    mass = area * density;
  }
  
  protected abstract void calculateArea();
  
  public PVector getPosition() {
    return position;
  }
  
  public void setPosition(PVector position) {
    this.position = position;
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
  
  public float getCoorX(){
    return position.x;
  }
  
   public float getCoorY(){
    return position.y;
   }
  
  public void step(float frameTime) {
    position.add(PVector.mult(linearVelocity, frameTime)).add(PVector.mult(linearAcceleration, frameTime*frameTime*0.5));
    linearVelocity.add(PVector.mult(linearAcceleration, frameTime));
    rotation += rotationVelocity * frameTime + 0.5 * rotationAcceleration * frameTime * frameTime;
    rotationVelocity += rotationAcceleration * frameTime;
    
  }
  
  public abstract void display();
}

// area, mass, speed, position, density

public abstract class RigidBody {
  private enum ShapeType {
    CIRCLE, RECTANGLE
  }
  
  private PVector position;
  private PVector linearVelocity;
  private float rotation;
  private float rotationVelocity;
  
  private float density;
  private float mass;
  private float restitution;
  private float area;
  
  private boolean isStatic;
  
  private ShapeType shapeType;
  
  public void calculateMass() {
    mass = area * density;
  }
  
  public abstract void calculateArea();
  
}

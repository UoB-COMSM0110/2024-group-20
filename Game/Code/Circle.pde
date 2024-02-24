public class Circle extends RigidBody {
  protected float radius;
 
  public Circle(PVector position, float density, float restitution, boolean isStatic, float radius) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.radius = radius;
    this.shapeType = ShapeType.CIRCLE;
    calculateArea();
    calculateMass();
  }
  
  protected void calculateArea() {
    area = radius * radius * (float)Math.PI;
  }
}

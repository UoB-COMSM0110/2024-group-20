public class Circle extends RigidBody {
  protected float circleRadius;
 
  public Circle(PVector position, float density, float restitution, boolean isStatic, float circleRadius) {
    this.position = position;
    this.force = new PVector(0, 0);
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.circleRadius = circleRadius;
    this.shapeType = ShapeType.CIRCLE;
    calculateArea();
    calculateMass();
  }
  
  protected void calculateArea() {
    area = circleRadius * circleRadius * (float)Math.PI;
  }
  
  public float getRadius() {
    return circleRadius;
  }
}

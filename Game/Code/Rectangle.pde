public class Rectangle extends RigidBody{
  protected float width;
  protected float height;
    
  public Rectangle(PVector position, float density, float restitution, boolean isStatic, float width, float height) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.width = width;
    this.height = height;
  }
  
  public void calculateArea() {
    area = width * height;
  }
}
  

public class Rectangle extends RigidBody{
  protected float rectWidth;
  protected float rectHeight;
    
  public Rectangle(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
    this.shapeType = ShapeType.RECTANGLE;
    calculateArea();
    calculateMass();
  }
  
  protected void calculateArea() {
    area = rectWidth * rectHeight;
  }
  
  public float getWidth() {
    return rectWidth;
  }
  
  public float getHeight() {
    return rectHeight;
  }
  
  public PVector getVertex(int index) {
    PVector relativePosition;
    switch(index%4) {
      case 0: 
        relativePosition = new PVector(-rectWidth/2, rectHeight/2);
        break;
      case 1: 
        relativePosition = new PVector(rectWidth/2, rectHeight/2);
        break;
      case 2: 
        relativePosition = new PVector(rectWidth/2, -rectHeight/2);
        break;
      case 3: 
        relativePosition = new PVector(-rectWidth/2, -rectHeight/2);
        break;
    }
    return position.add(relativePosition.rotate(rotation));
  }
}
  

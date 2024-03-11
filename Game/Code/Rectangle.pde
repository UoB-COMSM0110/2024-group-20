public class Rectangle extends RigidBody{
  protected float rectWidth;
  protected float rectHeight;
  protected float rectAngle;
    
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
  

  public void display(){
    rect(position.x, position.y, rectWidth, rectHeight);
  }
  
  public PVector getVertex(int index) {
    PVector relativePosition = new PVector(0,0);

    switch(index%4) {
      case 0: 
        relativePosition.set(-rectWidth/2, rectHeight/2);
        break;
      case 1: 
        relativePosition.set(rectWidth/2, rectHeight/2);
        break;
      case 2: 
        relativePosition.set(rectWidth/2, -rectHeight/2);
        break;
      case 3: 
        relativePosition.set(-rectWidth/2, -rectHeight/2);
        break;
    }

    return PVector.add(position,relativePosition.rotate(rotation));
  }

}
  

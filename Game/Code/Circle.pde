public class Circle extends RigidBody {
  protected float circleRadius;
 
  public Circle(PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.circleRadius = circleRadius;
    this.rotation = rotation;
    this.shapeType = ShapeType.CIRCLE;
    calculateArea();
    calculateMass();
    calculateAngularInertia();
    
  }
  
  public float getCoorX(){
    return position.x;
  }
  
  public float getCoorY(){
    return position.y;
  }
  
  protected void calculateArea() {
    area = circleRadius * circleRadius * (float)Math.PI;
  }
  
  protected void calculateAngularInertia(){
    angularInertia = 0.5 * mass * circleRadius * circleRadius;
  }
  
  public void display(){
    circle(position.x, position.y, circleRadius*2);
  }
  
  public float getRadius() {
    return circleRadius;
  }

  public boolean intersect(RigidBody other) {
    return other.intersect(this);
  }
  
  public boolean intersect(Rectangle other) {
    return other.intersect(this);
  }

  public boolean intersect(Circle other) {
    PVector circle1Position =  this.getPosition();
    PVector circle2Position = other.getPosition();
    
    float distance = PVector.dist(circle1Position, circle2Position);
    float radiusSum = this.getRadius() + other.getRadius();
    
    if(distance >= radiusSum){
      return false;
    }
    
    PVector forceDirection = PVector.sub(circle2Position, circle1Position).normalize();
    float overlap = radiusSum - distance;
    
    circle1Position.sub(PVector.mult(forceDirection,overlap/2));
    circle2Position.add(PVector.mult(forceDirection,overlap/2));
    
    resolveCollision(other, forceDirection, overlap);
    return true;
  }
  
  private void resolveCollision(RigidBody other, PVector forceDirection, float overlap){
    float e = min(this.restitution, other.restitution);
    PVector relativeVelocity = PVector.sub(other.linearVelocity, this.linearVelocity);
    float j = -(1 + e) * PVector.dot(relativeVelocity, forceDirection);
    j = j / (1 / this.mass + (1/other.mass));
    
    PVector resolutionA = PVector.mult(forceDirection, (j / this.mass));
    this.linearVelocity.sub(resolutionA);

    
    PVector resolutionB = PVector.mult(forceDirection, (j / other.mass));
    other.linearVelocity.add(resolutionB);

  }

}

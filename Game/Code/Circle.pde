public class Circle extends RigidBody {
  protected float circleRadius;
 
  public Circle(PVector position, float density, float restitution, boolean isStatic, float circleRadius, float rotation, PVector linearVelocity) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.circleRadius = circleRadius;
    this.rotation = rotation;
    this.linearVelocity = linearVelocity;
    this.shapeType = ShapeType.CIRCLE;
    calculateArea();
    calculateMass();
    calculateAngularInertia();
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

  public boolean intersect(Circle other) {
    PVector circle1Position =  this.getPosition();
    PVector circle2Position = other.getPosition();

    PVector circle1LinearVelocity =  this.getLinearVelocity();
    PVector circle2LinearVelocity = other.getLinearVelocity();
    
    float distance = PVector.dist(circle1Position, circle2Position);
    float radiusSum = this.getRadius() + other.getRadius();

    if(distance >= radiusSum){
      return false;
    }
    
    PVector forceDirection = PVector.sub(circle2Position, circle1Position).normalize();
    PVector relativeLinearVelocity = PVector.sub(circle2LinearVelocity, circle1LinearVelocity);
    float velocityNormal = PVector.dot(relativeLinearVelocity, forceDirection);
    
    // If two circles are away from each other, do not proceed
    if (velocityNormal > 0) {
      return false;
    }
    
    // Setting coefficient of restitution
    float cor = 1;
    
    // Calculate the value of impulse
    float j = -(1 + cor) * velocityNormal / (1 / this.mass + 1 / other.mass);
    PVector impulse = PVector.mult(forceDirection, j);
    
    // Calculate the new linear velocity of two circles after collision
    PVector circle1NewLinearVelocity = PVector.sub(circle1LinearVelocity, PVector.div(impulse, this.mass));
    PVector circle2NewLinearVelocity = PVector.add(circle2LinearVelocity, PVector.div(impulse, other.mass));
    
    this.setLinearVelocity(circle1NewLinearVelocity);
    other.setLinearVelocity(circle2NewLinearVelocity);
    
    return true;
  }

  public boolean intersect(Rectangle other) {
    return other.intersect(this);
  }
  
}

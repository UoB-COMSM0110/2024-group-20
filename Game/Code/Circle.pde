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

//  Intersects circle  ///////////////////////////////////////////////////////////////////////////////////////////////
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
    
    float cor = this.restitution * other.restitution;
    
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


//  Intersects rectangle  ///////////////////////////////////////////////////////////////////////////////////////////////
  public boolean intersect(Rectangle other) {
    PVector circlePosition = this.getPosition();
    float circleRadius = this.getRadius();
    // Rectangle
    PVector rectPosition = other.getPosition();
    float rectWidth = other.getWidth();
    float rectHeight = other.getHeight();
    // Others
    boolean isSideContact = false;
    
    // Getting 4 verticeses from the rectangle
    PVector[] vertices = new PVector[4];
    for(int i=0; i<4; i++) {
      vertices[i] = other.getVertex(i);
    }
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleCentre, circleMax;
    
    // For the vertical axis of rectangle (using Vertex 1 and vertices 2)
    normalVector = PVector.sub(vertices[2],vertices[1]).normalize();
    
    // PROJECTION ON Axis
    rectMin = PVector.dot(normalVector, rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleCentre = PVector.dot(normalVector,circlePosition);
    circleMin = circleCentre-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    if(circleCentre > rectMin && circleCentre < rectMax){
      isSideContact = true;
    }
    
    // Getting values for collision resolution
    float overlap = min(circleMax - rectMin, rectMax - circleMin);
    PVector forceDirection = normalVector.copy();
    
    // For the vertical axis of rectangle (using Vertex 0 and vertices 1)
    normalVector = PVector.sub(vertices[1],vertices[0]).normalize();
    
    rectMin = PVector.dot(normalVector,rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleCentre = PVector.dot(normalVector,circlePosition);
    circleMin = circleCentre-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    if(circleCentre > rectMin && circleCentre < rectMax){
      isSideContact = true;
    }
    
    // Getting values for collision resolution
    float overlapTemp = min(circleMax - rectMin, rectMax - circleMin);  
    if( overlapTemp < overlap){
      overlap = overlapTemp;
      forceDirection = normalVector.copy();
    }
    
    if(isSideContact){
      // Making sure the force vector is pointing in the good direction
    
      PVector desiredDirection = PVector.sub(rectPosition, circlePosition);
      if(PVector.dot(desiredDirection, forceDirection) < 0){
        forceDirection.mult(-1);
      }
      
      // Reaction to overlap
      circlePosition.sub(PVector.mult(forceDirection,overlap/2));
      rectPosition.add(PVector.mult(forceDirection,overlap/2));
    }
    else{
      // Finding the point of contact
      float minCircleVertexDist = Float.MAX_VALUE;
      float minCircleVertexDistTemp;
      for(int i=0; i<4; i++){
        minCircleVertexDistTemp = PVector.dist(vertices[i], circlePosition);
        if(minCircleVertexDistTemp < minCircleVertexDist){
          minCircleVertexDist = minCircleVertexDistTemp;
          forceDirection = PVector.sub(vertices[i], circlePosition).normalize();
        }
      }
      
      if(minCircleVertexDist > circleRadius){
        return false;
      }
      
      overlap = circleRadius - minCircleVertexDist;
      circlePosition.sub(PVector.mult(forceDirection,overlap/2));
      rectPosition.add(PVector.mult(forceDirection,overlap/2));
    }
    
    return true;
  }
  
}

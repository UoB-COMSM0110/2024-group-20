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
    float circle1Radius = this.getRadius();
    PVector circle1Position =  this.getPosition();
    
    float circle2Radius = other.getRadius();
    PVector circle2Position = other.getPosition();
    
    float distance = PVector.dist(circle2Position, circle1Position);
    float radiusSum = circle1Radius + circle2Radius;
    float overlap = radiusSum - distance;

    if(overlap <= 0){
      return false;
    }
    
    PVector forceDirection = PVector.sub(circle2Position, circle1Position).normalize();
    PVector circle1ContactPosition = PVector.mult(forceDirection, circle1Radius);
    PVector circle2ContactPosition = PVector.mult(forceDirection, -circle2Radius);
    
    resolveCollision(this, other, circle1ContactPosition, circle2ContactPosition, forceDirection, overlap);
    return true;
  }


//  Intersects rectangle  ///////////////////////////////////////////////////////////////////////////////////////////////
  public boolean intersect(Rectangle other) {
    float circleRadius = this.getRadius();
    PVector circlePosition = this.getPosition();
    // Rectangle
    float rectWidth = other.getWidth();
    float rectHeight = other.getHeight();
    PVector rectPosition = other.getPosition();
    // Others
    boolean isSideContact = false;
    
    // Getting 4 verticeses from the rectangle
    PVector[] vertices = new PVector[4];
    for(int i=0; i<4; i++) {
      vertices[i] = other.getVertex(i);
    }
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleCentre, circleMax;
    PVector forceDirection;
    float positiveOverlap, negativeOverlap, overlap;
    
    // For the vertical axis of rectangle (using Vertex 1 and vertices 2)
    normalVector = PVector.sub(vertices[1],vertices[2]).normalize();
    
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
    positiveOverlap = rectMax - circleMin;
    negativeOverlap = circleMax - rectMin;
    if(positiveOverlap < negativeOverlap) {
      overlap = positiveOverlap;
      forceDirection = normalVector.copy().mult(-1);
    }
    else {
      overlap = negativeOverlap;
      forceDirection = normalVector.copy();
    }
    
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
    positiveOverlap = rectMax - circleMin;
    negativeOverlap = circleMax - rectMin;
    if(positiveOverlap < negativeOverlap && positiveOverlap < overlap) {
      overlap = positiveOverlap;
      forceDirection = normalVector.copy().mult(-1);
    }
    else if(negativeOverlap < overlap) {
      overlap = negativeOverlap;
      forceDirection = normalVector.copy();
    }
    
    if(!isSideContact){
      // Finding the point of contact
      float minCircleVertexDist = Float.MAX_VALUE;
      float minCircleVertexDistTemp;
      PVector closestVertex = vertices[0];
      for(int i=0; i<4; i++){
        minCircleVertexDistTemp = PVector.dist(vertices[i], circlePosition);
        if(minCircleVertexDistTemp < minCircleVertexDist){
          minCircleVertexDist = minCircleVertexDistTemp;
          closestVertex = vertices[i];
        }
      }
      
      if(minCircleVertexDist > circleRadius){
        return false;
      }
      
      forceDirection = PVector.sub(closestVertex, circlePosition).normalize();
      overlap = circleRadius - minCircleVertexDist;
    }
    
    PVector circleContactPosition = PVector.mult(forceDirection, circleRadius);
    PVector rectContactPosition = PVector.add(circlePosition, PVector.mult(forceDirection, circleRadius-overlap)).sub(rectPosition);
    
    resolveCollision(this, other, circleContactPosition, rectContactPosition, forceDirection, overlap);
    return true;
  }
  
}

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
    float circle1Mass = this.getMass();
    float circle1Restitution = this.getRestitution();
    PVector circle1Position =  this.getPosition();
    PVector circle1LinVelocity =  this.getLinearVelocity();
    float circle2Radius = other.getRadius();
    float circle2Mass = other.getMass();
    float circle2Restitution = other.getRestitution();
    PVector circle2Position = other.getPosition();
    PVector circle2LinVelocity = other.getLinearVelocity();
    
    float distance = PVector.dist(circle2Position, circle1Position);
    float radiusSum = circle1Radius + circle2Radius;
    float overlap = radiusSum - distance;

    if(overlap <= 0){
      return false;
    }
    
    PVector forceDirection = PVector.sub(circle2Position, circle1Position).normalize();
    PVector relativeLinVelocity = PVector.sub(circle2LinVelocity, circle1LinVelocity);
    float velocityNormal = PVector.dot(relativeLinVelocity, forceDirection);
    
    // If two circles are away from each other, do not proceed
    if (velocityNormal > 0) {
      return false;
    }
    
    float cor = circle1Restitution * circle2Restitution;
    
    // Calculate the value of impulse
    float impulse = -(1 + cor) * velocityNormal / (1 / circle1Mass + 1 / circle2Mass);
    
    // Calculate the new linear velocity of two circles after collision
    PVector circle1NewLinVelocity = PVector.sub(circle1LinVelocity, PVector.mult(forceDirection, impulse / circle1Mass));
    PVector circle2NewLinVelocity = PVector.add(circle2LinVelocity, PVector.mult(forceDirection, impulse / circle2Mass));
    
    this.setLinearVelocity(circle1NewLinVelocity);
    other.setLinearVelocity(circle2NewLinVelocity);
    
    PVector pushedPosition = PVector.mult(forceDirection,overlap/2);
    circle1Position.sub(pushedPosition);
    circle2Position.add(pushedPosition);
    return true;
  }


//  Intersects rectangle  ///////////////////////////////////////////////////////////////////////////////////////////////
  public boolean intersect(Rectangle other) {
    float circleRadius = this.getRadius();
    float circleMass = this.getMass();
    float circleRestitution = this.getRestitution();
    PVector circlePosition = this.getPosition();
    PVector circleLinVelocity = this.getLinearVelocity();
    // Rectangle
    float rectWidth = other.getWidth();
    float rectHeight = other.getHeight();
    float rectMass = other.getMass();
    float rectAngInertia = other.getAngularInertia();
    float rectRestitution = other.getRestitution();
    PVector rectPosition = other.getPosition();
    PVector rectLinVelocity = other.getLinearVelocity();
    float rectAngVelocity = other.getAngularVelocity();
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
      PVector relativePosition = PVector.sub(rectPosition, circlePosition);
      if(PVector.dot(relativePosition, forceDirection) < 0) {
        forceDirection.mult(-1);
      }
      PVector tangentDirection = forceDirection.copy().rotate(HALF_PI);
      
      // velocities at contact point
      PVector contactPosition = PVector.add(circlePosition, PVector.mult(forceDirection, circleRadius));
      PVector rectRelativeContactPosition = PVector.sub(contactPosition, rectPosition);
      PVector rectContactLinAngVelocity = new PVector(-rectAngVelocity * rectRelativeContactPosition.y, rectAngVelocity * rectRelativeContactPosition.x);
      PVector rectContactLinVelocity = PVector.add(rectLinVelocity, rectContactLinAngVelocity);
      
      PVector diffLinVelocity = PVector.sub(rectContactLinVelocity, circleLinVelocity);
      float normDiffLinVelocity = PVector.dot(diffLinVelocity, forceDirection);
    
      // If two circles are away from each other, do not proceed
      if (normDiffLinVelocity >= 0) {
        return true;
      }
      
      float momentLength = PVector.dot(relativePosition, tangentDirection);
      float absMomentLength = abs(momentLength);
      float rectLinAngMass = rectAngInertia / absMomentLength / absMomentLength;
      
      // Calculate the value of impulse
      float cor = circleRestitution * rectRestitution;
      float impulse = -(1 + cor) * normDiffLinVelocity / (1 / circleMass + 1 / rectLinAngMass);
      
      // Reaction to circle and angular velocity of rectangle
      PVector circleNewLinVelocity = PVector.sub(circleLinVelocity, PVector.mult(forceDirection, impulse / circleMass));
      this.setLinearVelocity(circleNewLinVelocity);
      float diffAngVelocity = impulse / rectLinAngMass / momentLength;
      float rectNewAngVelocity = rectAngVelocity + diffAngVelocity;
      other.setAngularVelocity(rectNewAngVelocity);
      
      // Reaction to linear velocity of rectangle
      float angularImpulse = diffAngVelocity * rectAngInertia;
      PVector rectNewLinVelocity = PVector.add(rectLinVelocity, PVector.mult(forceDirection, angularImpulse / momentLength / rectMass));
      other.setLinearVelocity(rectNewLinVelocity);
      
      // Reaction to overlap
      PVector pushedPosition = PVector.mult(forceDirection,overlap/2);
      circlePosition.sub(pushedPosition);
      rectPosition.add(pushedPosition);
      print(forceDirection + "\n");
      print(tangentDirection + "\n");
      print(momentLength + "\n");
      
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

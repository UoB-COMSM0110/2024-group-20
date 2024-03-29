public class Rectangle extends RigidBody {
  protected float rectWidth;
  protected float rectHeight;
  protected float rectAngle;
    
  public Rectangle(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    this.position = position;
    this.density = density;
    this.restitution = restitution;
    this.isStatic = isStatic;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
    this.rotation = rotation;
    this.shapeType = ShapeType.RECTANGLE;
    calculateArea();
    calculateMass();
    calculateAngularInertia();
    
    }
  
  protected void calculateArea() {
    area = rectWidth * rectHeight;
  }
  
  protected void calculateAngularInertia(){
    angularInertia = mass * (rectWidth*rectWidth + rectHeight*rectHeight) / 12;
  }
  
  public float getWidth() {
    return rectWidth;
  }
  
  public float getHeight() {
    return rectHeight;
  }
  

  public void display(){
    pushMatrix();
    translate(position.x,position.y);
    rotate(rotation);
    rect(0,0, rectWidth, rectHeight);
    popMatrix();
    
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
  
  
  public boolean intersect(RigidBody other) {
    return other.intersect(this);
  }
  

  public boolean intersect(Circle other) {
    PVector circlePosition = other.getPosition();
    float circleRadius = other.getRadius();
    // Rectangle
    PVector rectPosition = this.getPosition();
    float rectWidth = this.getWidth();
    float rectHeight = this.getHeight();
    // Others
    boolean isSideContact = false;
    
    // Getting 4 verticeses from the rectangle
    PVector[] vertices = new PVector[4];
    for(int i=0; i<4; i++) {
      vertices[i] = this.getVertex(i);
    }
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleCentre, circleMax;
    
    // For the vertical axis of rectangle (Vertex 1 and vertices 2)
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
    
    // For the vertical axis of rectangle (Vertex 0 and vertices 1)
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


  public boolean intersect(Rectangle other) {
    // Rectangle A
    PVector[] verticesA = new PVector[4];
    PVector rectAPosition = this.getPosition();
    float rectAWidth = this.getWidth();
    float rectAHeight = this.getHeight();
    // Rectangle B
    PVector[] verticesB = new PVector[4];
    PVector rectBPosition = other.getPosition();
    float rectBWidth = other.getWidth();
    float rectBHeight = other.getHeight();
    
    for(int i=0; i<4; i++) {
      verticesA[i] = this.getVertex(i);
      verticesB[i] = other.getVertex(i);
    }
    
    PVector normalVector;
    float rectAMin, rectAMax, rectBMin, rectBMax;
    
    // Check the sides of rectangle A 
    // For the vertical axis of rectangle A (Vertex 1 and vertices 2)
    normalVector = PVector.sub(verticesA[2],verticesA[1]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAHeight/2;
    rectAMax = rectAMin + rectAHeight;
    rectBMin = Float.MAX_VALUE;
    rectBMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesB.length; i++){
      rectBMin = min(rectBMin, PVector.dot(normalVector,verticesB[i]));
      rectBMax = max(rectBMax, PVector.dot(normalVector,verticesB[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    float overlap = min(rectBMax - rectAMin, rectAMax - rectBMin);
    PVector forceDirection = normalVector.copy();

    // For the horizontal axis of rectangle A (Vertex 0 and vertices 1)
    normalVector = PVector.sub(verticesA[1],verticesA[0]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAWidth/2;
    rectAMax = rectAMin + rectAWidth;
    rectBMin = Float.MAX_VALUE;
    rectBMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesB.length; i++){
      rectBMin = min(rectBMin, PVector.dot(normalVector,verticesB[i]));
      rectBMax = max(rectBMax, PVector.dot(normalVector,verticesB[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    float overlapTemp = min(rectBMax - rectAMin, rectAMax - rectBMin);    
    if( overlapTemp < overlap){
      overlap = overlapTemp;
      forceDirection = normalVector.copy();
    }
    
    // Check the sides of rectangle B
    // For the vertical axis of rectangle B
    normalVector = PVector.sub(verticesB[1],verticesB[2]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBHeight/2;
    rectBMax = rectBMin + rectBHeight;
    rectAMin = Float.MAX_VALUE;
    rectAMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesA.length; i++){
      rectAMin = min(rectAMin, PVector.dot(normalVector,verticesA[i]));
      rectAMax = max(rectAMax, PVector.dot(normalVector,verticesA[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    overlapTemp = min(rectBMax - rectAMin, rectAMax - rectBMin);
    if( overlapTemp < overlap){
      overlap = overlapTemp;
      forceDirection = normalVector.copy();
    }
    
    // For the horizontal axis of rectangle B
    normalVector = PVector.sub(verticesB[1],verticesB[0]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBWidth/2;
    rectBMax = rectBMin + rectBWidth;
    rectAMin = Float.MAX_VALUE;
    rectAMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesA.length; i++){
      rectAMin = min(rectAMin, PVector.dot(normalVector,verticesA[i]));
      rectAMax = max(rectAMax, PVector.dot(normalVector,verticesA[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    overlapTemp = min(rectBMax - rectAMin, rectAMax - rectBMin);    
    if( overlapTemp < overlap){
      overlap = overlapTemp;
      forceDirection = normalVector.copy();
    }
    
    // Making sure the force vector is pointing in the good direction
    PVector desiredDirection = PVector.sub(rectBPosition, rectAPosition);
    if(PVector.dot(desiredDirection, forceDirection) < 0){
      forceDirection.mult(-1);
    }
    
    // Reaction to overlap
    rectAPosition.sub(PVector.mult(forceDirection,overlap/2));
    rectBPosition.add(PVector.mult(forceDirection,overlap/2));

    return true;
  }
}
  

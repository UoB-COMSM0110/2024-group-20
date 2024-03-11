public static class Collisions {
  
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public static boolean intersect(RigidBody body1, RigidBody body2){
    if(body1 instanceof Circle && body2 instanceof Circle){
      return intersectCircles((Circle)body1, (Circle)body2);
    }
    else if(body1 instanceof Circle && body2 instanceof Rectangle){
      return intersectCircleRectangle((Circle)body1, (Rectangle)body2);
    }
    else if(body1 instanceof Rectangle && body2 instanceof Circle){
      return intersectCircleRectangle((Circle)body2, (Rectangle)body1);
    }
    else if(body1 instanceof Rectangle && body2 instanceof Rectangle){
      return intersectRectangles((Rectangle)body1, (Rectangle)body2);
    }
    return false;
  }
  
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public static boolean intersect(Circle circle, Rectangle rectangle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  public static boolean intersect(Rectangle rectangle, Circle circle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  private static boolean intersectCircleRectangle(Circle circle, Rectangle rectangle) {
    // Circle
    PVector circlePosition = circle.getPosition();
    float circleRadius = circle.getRadius();
    // Rectangle
    PVector rectPosition = rectangle.getPosition();
    float rectWidth = rectangle.getWidth();
    float rectHeight = rectangle.getHeight();
    // Others
    boolean isSideContact = false;
    
    // Getting 4 verticeses from the rectangle
    PVector[] vertices = new PVector[4];
    for(int i=0; i<4; i++) {
      vertices[i] = rectangle.getVertex(i);
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
  
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public static boolean intersect(Rectangle rectangle1, Rectangle rectangle2) {
    return intersectRectangles(rectangle1, rectangle2);
  }
  
  private static boolean intersectRectangles(Rectangle rectangleA, Rectangle rectangleB) {
    // Rectangle A
    PVector[] verticesA = new PVector[4];
    PVector rectAPosition = rectangleA.getPosition();
    float rectAWidth = rectangleA.getWidth();
    float rectAHeight = rectangleA.getHeight();
    // Rectangle B
    PVector[] verticesB = new PVector[4];
    PVector rectBPosition = rectangleB.getPosition();
    float rectBWidth = rectangleB.getWidth();
    float rectBHeight = rectangleB.getHeight();
    
    for(int i=0; i<4; i++) {
      verticesA[i] = rectangleA.getVertex(i);
      verticesB[i] = rectangleB.getVertex(i);
    }
    
    PVector normalVector;
    float rectAMin, rectAMax, rectBMin, rectBMax;
    
    // Check the sides of rectangle A 
    // For the vertical axis of rectangle A (Vertex 1 and vertices 2)
    normalVector = PVector.sub(verticesA[2],verticesA[1]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAHeight/2;
    rectAMax = rectAMin + rectAHeight;
    rectBMin = Float.MAX_VALUE;
    rectBMax = Float.MIN_VALUE;
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
    rectBMax = Float.MIN_VALUE;
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
    normalVector = PVector.sub(verticesB[2],verticesB[1]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBHeight/2;
    rectBMax = rectBMin + rectBHeight;
    rectAMin = Float.MAX_VALUE;
    rectAMax = Float.MIN_VALUE;
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
    rectAMax = Float.MIN_VALUE;
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

  
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  public static boolean intersect(Circle circle1, Circle circle2){
     return intersectCircles(circle1, circle2);
  }
  
  private static boolean intersectCircles(Circle circle1, Circle circle2){
    PVector circle1Position =  circle1.getPosition();
    PVector circle2Position = circle2.getPosition();
    
    float distance = PVector.dist(circle1Position, circle2Position);
    float radiusSum = circle1.getRadius() + circle2.getRadius();
    
    if(distance >= radiusSum){
      return false;
    }
    
    PVector forceDirection = PVector.sub(circle2Position, circle1Position).normalize();
    float overlap = radiusSum - distance;
    
    circle1Position.sub(PVector.mult(forceDirection,overlap/2));
    circle2Position.add(PVector.mult(forceDirection,overlap/2));
    
    return true;
  }
  
}

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
    // Other
    float minDist;
    PVector closestVertice;
    
    // Getting 4 vertexes from the rectangle
    PVector[] vertex = new PVector[4];
    for(int i=0; i<4; i++) {
      vertex[i] = rectangle.getVertex(i);
    }
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleMax;
    
    // For the vertical axis of rectangle (Vertex 1 and vertex 2)
    normalVector = PVector.sub(vertex[2],vertex[1]).normalize();
    
    // PROJECTION ON Axis
    rectMin = PVector.dot(normalVector, rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    //In case circleMin and circleMax are the other way round
    if(circleMin > circleMax){
      float temp = circleMin;
      circleMin = circleMax;
      circleMax = temp;
    }
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    // For the vertical axis of rectangle (Vertex 0 and vertex 1)
    normalVector = PVector.sub(vertex[1],vertex[0]).normalize();
    
    rectMin = PVector.dot(normalVector,rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    //In case circleMin and circleMax are the other way round
    if(circleMin > circleMax){
      float temp = circleMin;
      circleMin = circleMax;
      circleMax = temp;
    }
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    // Finding the point of contact
    minDist = PVector.dist(circlePosition, rectangle.getVertex(0));
    closestVertice = rectangle.getVertex(0).copy();
    for(int i = 1; i < 4; i++){
     float temp =  PVector.dist(circlePosition, rectangle.getVertex(i));
     if(temp < minDist){
      minDist = temp; 
      closestVertice = rectangle.getVertex(i).copy();
     }
    }   
        

    
    return true;
  }
  
//////////////////////////////////////////////////////////////////////////////////////////////////////
  public static boolean intersect(Rectangle rectangle1, Rectangle rectangle2) {
    return intersectRectangles(rectangle1, rectangle2);
  }
  
  private static boolean intersectRectangles(Rectangle rectangleA, Rectangle rectangleB) {
    // Rectangle A
    PVector[] vertexA = new PVector[4];
    PVector rectAPosition = rectangleA.getPosition();
    float rectAWidth = rectangleA.getWidth();
    float rectAHeight = rectangleA.getHeight();
    // Rectangle B
    PVector[] vertexB = new PVector[4];
    PVector rectBPosition = rectangleB.getPosition();
    float rectBWidth = rectangleB.getWidth();
    float rectBHeight = rectangleB.getHeight();
    // Other variables
    PVector normalVector;
    
    for(int i=0; i<4; i++) {
      vertexA[i] = rectangleA.getVertex(i);
      vertexB[i] = rectangleB.getVertex(i);
    }
    
    float rectAMin, rectAMax, rectBMin, rectBMax;
    
    // Check the sides of rectangle A 
    // For the vertical axis of rectangle A (Vertex 1 and vertex 2)
    normalVector = PVector.sub(vertexA[2],vertexA[1]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAHeight/2;
    rectAMax = rectAMin + rectAHeight;
    rectBMin = Float.MAX_VALUE;
    rectBMax = Float.MIN_VALUE;
    for(int i=0; i<vertexB.length; i++){
      rectBMin = min(rectBMin, PVector.dot(normalVector,vertexB[i]));
      rectBMax = max(rectBMax, PVector.dot(normalVector,vertexB[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {

      return false;
    }
    
    // Getting values for collision resolution
    float overlap = min(rectBMax - rectAMin, rectAMax - rectBMin);
    PVector forceDirection = normalVector.copy();

    // For the horizontal axis of rectangle A (Vertex 0 and vertex 1)
    normalVector = PVector.sub(vertexA[1],vertexA[0]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAWidth/2;
    rectAMax = rectAMin + rectAWidth;
    rectBMin = Float.MAX_VALUE;
    rectBMax = Float.MIN_VALUE;
    for(int i=0; i<vertexB.length; i++){
      rectBMin = min(rectBMin, PVector.dot(normalVector,vertexB[i]));
      rectBMax = max(rectBMax, PVector.dot(normalVector,vertexB[i]));
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
    normalVector = PVector.sub(vertexB[2],vertexB[1]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBHeight/2;
    rectBMax = rectBMin + rectBHeight;
    rectAMin = Float.MAX_VALUE;
    rectAMax = Float.MIN_VALUE;
    for(int i=0; i<vertexA.length; i++){
      rectAMin = min(rectAMin, PVector.dot(normalVector,vertexA[i]));
      rectAMax = max(rectAMax, PVector.dot(normalVector,vertexA[i]));
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
    normalVector = PVector.sub(vertexB[1],vertexB[0]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBWidth/2;
    rectBMax = rectBMin + rectBWidth;
    rectAMin = Float.MAX_VALUE;
    rectAMax = Float.MIN_VALUE;
    for(int i=0; i<vertexA.length; i++){
      rectAMin = min(rectAMin, PVector.dot(normalVector,vertexA[i]));
      rectAMax = max(rectAMax, PVector.dot(normalVector,vertexA[i]));
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
    
    PVector desiredDirection = PVector.sub(rectBPosition, rectAPosition).copy();
    if(PVector.dot(desiredDirection, forceDirection) < 0){
      forceDirection = PVector.mult(forceDirection, -1);
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

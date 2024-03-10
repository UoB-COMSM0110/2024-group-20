public static class Collisions {
  public static boolean intersect(RigidBody body1, RigidBody body2){
    if(body1 instanceof Circle && body2 instanceof Circle){
      return intersectCircleCircle((Circle)body1, (Circle)body2);
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
  
  public static boolean intersect(Circle circle, Rectangle rectangle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  public static boolean intersect(Rectangle rectangle, Circle circle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  private static boolean intersectCircleRectangle(Circle circle, Rectangle rectangle) {
    PVector circlePosition = circle.getPosition();
    float circleRadius = circle.getRadius();
    PVector rectPosition = rectangle.getPosition();
    float rectWidth = rectangle.getWidth();
    float rectHeight = rectangle.getHeight();
    float minDist;
    
    PVector[] vertex = new PVector[4];
    for(int i=0; i<4; i++) {
      vertex[i] = rectangle.getVertex(i);
    }
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleMax;
    
    normalVector = PVector.sub(vertex[2],vertex[1]).normalize();
    
    // PROJECTION ON Axis
    rectMin = PVector.dot(normalVector, rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    minDist = min(rectMax-circleMin, circleMax-rectMin);
    
    normalVector = PVector.sub(vertex[1],vertex[0]).normalize();
    
    rectMin = PVector.dot(normalVector,rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    minDist = min(minDist, rectMax-circleMin, circleMax-rectMin);
    
    float minVertexCircleDist = Float.MAX_VALUE;
    for(int i=0; i<4; i++){
      minVertexCircleDist = min(minVertexCircleDist, PVector.dist(vertex[i], circlePosition));
    }
    if(minVertexCircleDist > circleRadius){
      return false;
    }
    
    return true;
  }
  
  public static boolean intersect(Rectangle rectangle1, Rectangle rectangle2) {
    return intersectRectangles(rectangle1, rectangle2);
  }
  
  private static boolean intersectRectangles(Rectangle rectangleA, Rectangle rectangleB) {
    PVector[] vertexA = new PVector[4];
    PVector[] vertexB = new PVector[4];
    PVector rectAPosition = rectangleA.getPosition();
    float rectAWidth = rectangleA.getWidth();
    float rectAHeight = rectangleA.getHeight();
    PVector rectBPosition = rectangleB.getPosition();
    float rectBWidth = rectangleB.getWidth();
    float rectBHeight = rectangleB.getHeight();
    PVector normalVector;
    
    for(int i=0; i<4; i++) {
      vertexA[i] = rectangleA.getVertex(i);
      vertexB[i] = rectangleB.getVertex(i);
    }
    
    float rectAMin, rectAMax, rectBMin, rectBMax;
    
    // Check the sides of rectangle A
    // For the vertical axis of rectangle A
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
    
    // For the horizontal axis of rectangle A
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

public static class Collisions {
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
    
    PVector vertex0, vertex1, vertex2;
    vertex0 = rectangle.getVertex(0);
    vertex1 = rectangle.getVertex(1);
    vertex2 = rectangle.getVertex(2);
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleMax;
    
    normalVector = PVector.sub(vertex2,vertex1).normalize();
    
    // PROJECTION ON Axis
    rectMin = PVector.dot(normalVector, rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    minDist = min(rectMax-circleMin, circleMax-rectMin);
    
    normalVector = PVector.sub(vertex1,vertex0).normalize();
    
    rectMin = PVector.dot(normalVector,rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleMin = PVector.dot(normalVector,circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    minDist = min(minDist, rectMax-circleMin, circleMax-rectMin);
    
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
     return intersectCircleCircle(circle1, circle2);
  }
  
  private static boolean intersectCircleCircle(Circle circle1, Circle circle2){
    PVector circleOnePosition =  circle1.getPosition().copy();
    PVector circleTwoPosition = circle2.getPosition().copy();
    
    float distanceX = circleOnePosition.x - circleTwoPosition.x;
    float distanceY = circleOnePosition.y - circleTwoPosition.y;
    
    float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
    float radiusSum = circle1.getRadius() + circle2.getRadius();
    
    if(distance >= radiusSum){
      return false;
    }
    
    PVector forceDirection = circle2.getPosition().copy();
    forceDirection = forceDirection.sub(circle1.getPosition()).normalize();
    float overlap = radiusSum - distance;
    circle1.setPosition(circleOnePosition.sub(forceDirection.mult(overlap/2)));
    circle2.setPosition(circleTwoPosition.add(forceDirection.mult(overlap/2)));
    
    return true;
  }
  
}

public static class Collisions {
  public static boolean intersect(Circle circle, Rectangle rectangle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  public static boolean intersect(Rectangle rectangle, Circle circle) {
    return intersectCircleRectangle(circle, rectangle);
  }
  
  private static boolean intersectCircleRectangle(Circle circle, Rectangle rectangle) {
    PVector circlePosition = circle.getPosition().copy();
    float circleRadius = circle.getRadius();
    PVector rectPosition = rectangle.getPosition().copy();
    float rectWidth = rectangle.getWidth();
    float rectHeight = rectangle.getHeight();
    float minDist = Float.MAX_VALUE;
    
    PVector vertex0, vertex1, vertex2;
    vertex0 = rectangle.getVertex(0);
    vertex1 = rectangle.getVertex(1);
    vertex2 = rectangle.getVertex(2);
    
    PVector normalVector;
    float rectMin, rectMax, circleMin, circleMax;
    
    normalVector = vertex2.copy().sub(vertex1);
    normalVector = normalVector.normalize();
    
    // PROJECTION ON Axis
    rectMin = normalVector.copy().dot(rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleMin = normalVector.copy().dot(circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    normalVector = vertex1.copy().sub(vertex0);
    normalVector = normalVector.normalize();
    
    rectMin = normalVector.copy().dot(rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleMin = normalVector.copy().dot(circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    
    
    return true;
  }
  
  public static boolean intersect(Rectangle rectangle1, Rectangle rectangle2) {
    return intersectRectangles(rectangle1, rectangle2);
  }
  
  private static boolean intersectRectangles(Rectangle rectangleA, Rectangle rectangleB) {
    PVector[] vertexA = new PVector[3];
    PVector[] vertexB = new PVector[3];
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
    normalVector = vertexA[2].sub(vertexA[1]);
    normalVector = normalVector.normalize();
    rectAMin = normalVector.dot(rectAPosition)-rectAHeight/2;
    rectAMax = rectAMin + rectAHeight;
    rectBMin = Float.MAX_VALUE;
    rectBMax = Float.MIN_VALUE;
    for(int i=0; i<vertexB.length; i++){
      rectBMin = min(rectBMin, normalVector.dot(vertexB[i]));
      rectBMax = max(rectBMax, normalVector.dot(vertexB[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // For the horizontal axis of rectangle A
    normalVector = vertexA[1].sub(vertexA[0]);
    normalVector = normalVector.normalize();
    rectAMin = normalVector.dot(rectAPosition)-rectAWidth/2;
    rectAMax = rectAMin + rectAWidth;
    rectBMin = Float.MAX_VALUE;
    rectBMax = Float.MIN_VALUE;
    for(int i=0; i<vertexB.length; i++){
      rectBMin = min(rectBMin, normalVector.dot(vertexB[i]));
      rectBMax = max(rectBMax, normalVector.dot(vertexB[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    
    // Check the sides of rectangle B
    // For the vertical axis of rectangle B
    normalVector = vertexB[2].sub(vertexB[1]);
    normalVector = normalVector.normalize();
    rectBMin = normalVector.dot(rectBPosition)-rectBHeight/2;
    rectBMax = rectBMin + rectBHeight;
    rectAMin = Float.MAX_VALUE;
    rectAMax = Float.MIN_VALUE;
    for(int i=0; i<vertexA.length; i++){
      rectAMin = min(rectAMin, normalVector.dot(vertexA[i]));
      rectAMax = max(rectAMax, normalVector.dot(vertexA[i]));
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // For the horizontal axis of rectangle B
    normalVector = vertexB[1].sub(vertexB[0]);
    normalVector = normalVector.normalize();
    rectBMin = normalVector.dot(rectBPosition)-rectBWidth/2;
    rectBMax = rectBMin + rectBWidth;
    rectAMin = Float.MAX_VALUE;
    rectAMax = Float.MIN_VALUE;
    for(int i=0; i<vertexA.length; i++){
      rectAMin = min(rectAMin, normalVector.dot(vertexA[i]));
      rectAMax = max(rectAMax, normalVector.dot(vertexA[i]));
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

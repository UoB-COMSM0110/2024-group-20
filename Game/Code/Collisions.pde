public static class Colllisions {
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
    
    PVector vertex0, vertex1, vertex2;
    vertex0 = rectangle.getVertex(0);
    vertex1 = rectangle.getVertex(1);
    vertex2 = rectangle.getVertex(2);
    
    PVector normalVector;
    normalVector = vertex2.sub(vertex1);
    normalVector = normalVector.normalize();
    
    float rectMin, rectMax, circleMin, circleMax;
    rectMin = normalVector.dot(rectPosition)-rectHeight/2;
    rectMax = rectMin+rectHeight;
    circleMin = normalVector.dot(circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    normalVector = vertex1.sub(vertex0);
    normalVector = normalVector.normalize();
    
    rectMin = normalVector.dot(rectPosition)-rectWidth/2;
    rectMax = rectMin+rectWidth;
    circleMin = normalVector.dot(circlePosition)-circleRadius;
    circleMax = circleMin+circleRadius*2;
    
    if(rectMin>circleMax || circleMin>rectMax) {
      return false;
    }
    
    return true;
  }
}

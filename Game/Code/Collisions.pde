
/*public static class Colllisions {
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
  
  private static boolean intersectRectangle(Rectangle rectangle) {
    PVector[] vertexA;
    PVector[] vertexB;
    PVector normal;
    PVector minAxis;
    float depth;
    
    normal.set(0, 0);
    depth = Float.MaxValue;
    boolean intersecting = true;
    
    //Check the sides of polygon A
    for (int i = 0; i < vertexA.length; i++){
      PVector edge = PVector.sub(vertexA[(i + 1) % vertexA.length], vertexA[i]);
      PVector axis = new PVector(-edge.y, edge.x);
      axis.normalize();
      
      float[] projA = new float[2];
      float[] projB = new float[2];
      projectOnAxis(vertexA, axis, projA);
      projectOnAxis(vertexB, axis, projB);
      
      if (projA[0] > projB[1] || projB[0] > projA[1]){
        intersecting = false;
        break;
      }
      
      float axisDepth = Math.min(projA[1], projB[1]) - Math.max(projA[0], projB[0]);
      
      if (axisDepth < depth) {
        depth = axisDepth;
        minAxis.set(axis);
      }

    }
    
    //Check the sides of polygon B
    for (int i = 0; i < vertexB.length; i++){
      PVector edge = PVector.sub(vertexB[(i + 1) % vertexB.length], vertexB[i]);
      PVector axis = new PVector(-edge.y, edge.x);
      axis.normalize();
      
      float[] projA = new float[2];
      float[] projB = new float[2];
      projectOnAxis(vertexA, axis, projA);
      projectOnAxis(vertexB, axis, projB);
      
      if (projA[0] > projB[1] || projB[0] > projA[1]){
        intersecting = false;
        break;
      }
      
      float axisDepth = Math.min(projA[1], projB[1]) - Math.max(projA[0], projB[0]);
      
      if (axisDepth < depth) {
        depth = axisDepth;
        minAxis.set(axis);
      }

    }
    
    if (intersecting) {
      PVector centerA =  findArithmeticMean(vertexA);
      PVector centerB =  findArithmeticMean(vertexB);
      PVector direction = PVector.sub(centerB, centerA); 
    
      if (PVector.dot(direction, normal) < 0) {
        normal.mult(-1);
      }
    }

    return true;
}

  private static void projectOnAxis(PVector[] vertex, PVector axis, float[] result) {
    float min = Float.MaxValue;
    float max = -Float.MinValee;
    
    for (int i = 0; i < vertex.length; i++) {
      PVector v = vertex[i];
      float proj = PVector.dot(v, axis);
      
      if (proj < min) {
        min = proj;
      }
      if (proj > max){
        max = proj;
      }
    }
    
    result[0] = min;
    result[1] = max;
  }
    
  private static PVector findArithmeticMean(PVector[] vertex){
    float sumX = 0f;
    float sumY = 0f;

    for(int i = 0; i < vertex.length; i++){
      PVector v = vertex[i];
      sumX += v.x;
      sumY += v.y;
    }

    return new PVector(sumX / vertex.length, sumY / vertex.length);
  }
  
}*/

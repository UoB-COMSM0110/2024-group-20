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
  

//  Intersects circle  ///////////////////////////////////////////////////////////////////////////////////////////////
  public boolean intersect(Circle other) {
    return other.intersect(this);
  }


//  Intersects rectangle  ///////////////////////////////////////////////////////////////////////////////////////////////
  public boolean intersect(Rectangle other) {
    // Rectangle A
    PVector[] verticesA = new PVector[4];
    float rectAWidth = this.getWidth();
    float rectAHeight = this.getHeight();
    PVector rectAPosition = this.getPosition();
    // Rectangle B
    PVector[] verticesB = new PVector[4];
    float rectBWidth = other.getWidth();
    float rectBHeight = other.getHeight();
    PVector rectBPosition = other.getPosition();
    // others
    boolean rectANormalVectorCollision = true;
    
    for(int i=0; i<4; i++) {
      verticesA[i] = this.getVertex(i);
      verticesB[i] = other.getVertex(i);
    }
    
    PVector normalVector, contactPosition, rectAContactPosition, rectBContactPosition;
    PVector minPosition = new PVector(0,0), maxPosition = new PVector(0,0);
    float rectAMin, rectAMax, rectBMin, rectBMax, vectorizedPosition;
    
    // Check the sides of rectangle A 
    // For the vertical axis of rectangle A (Vertex 1 and vertices 2)
    normalVector = PVector.sub(verticesA[1],verticesA[2]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAHeight/2;
    rectAMax = rectAMin + rectAHeight;
    rectBMin = Float.MAX_VALUE;
    rectBMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesB.length; i++){
      vectorizedPosition = PVector.dot(normalVector,verticesB[i]);
      if(vectorizedPosition < rectBMin) {
        rectBMin = vectorizedPosition;
        minPosition = verticesB[i];
      }
      if(vectorizedPosition > rectBMax) {
        rectBMax = vectorizedPosition;
        maxPosition = verticesB[i];
      }
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    float positiveOverlap, negativeOverlap, overlap;
    PVector forceDirection;
    positiveOverlap = rectAMax - rectBMin;
    negativeOverlap = rectBMax - rectAMin;
    if(positiveOverlap < negativeOverlap) {
      overlap = positiveOverlap;
      forceDirection = normalVector.copy();
      contactPosition = minPosition.copy();
    }
    else {
      overlap = negativeOverlap;
      forceDirection = normalVector.copy().mult(-1);
      contactPosition = maxPosition.copy();
    }

    // For the horizontal axis of rectangle A (Vertex 0 and vertices 1)
    normalVector = PVector.sub(verticesA[1],verticesA[0]).normalize();
    rectAMin = PVector.dot(normalVector,rectAPosition)-rectAWidth/2;
    rectAMax = rectAMin + rectAWidth;
    rectBMin = Float.MAX_VALUE;
    rectBMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesB.length; i++){
      vectorizedPosition = PVector.dot(normalVector,verticesB[i]);
      if(vectorizedPosition < rectBMin) {
        rectBMin = vectorizedPosition;
        minPosition = verticesB[i];
      }
      if(vectorizedPosition > rectBMax) {
        rectBMax = vectorizedPosition;
        maxPosition = verticesB[i];
      }
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    positiveOverlap = rectAMax - rectBMin;
    negativeOverlap = rectBMax - rectAMin;
    if(positiveOverlap < negativeOverlap && positiveOverlap < overlap) {
      overlap = positiveOverlap;
      forceDirection = normalVector.copy();
      contactPosition = minPosition.copy();
    }
    else if(negativeOverlap < overlap) {
      overlap = negativeOverlap;
      forceDirection = normalVector.copy().mult(-1);
      contactPosition = maxPosition.copy();
    }
    
    // Check the sides of rectangle B
    // For the vertical axis of rectangle B
    normalVector = PVector.sub(verticesB[1],verticesB[2]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBHeight/2;
    rectBMax = rectBMin + rectBHeight;
    rectAMin = Float.MAX_VALUE;
    rectAMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesA.length; i++){
      vectorizedPosition = PVector.dot(normalVector,verticesA[i]);
      if(vectorizedPosition < rectAMin) {
        rectAMin = vectorizedPosition;
        minPosition = verticesA[i];
      }
      if(vectorizedPosition > rectAMax) {
        rectAMax = vectorizedPosition;
        maxPosition = verticesA[i];
      }
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    positiveOverlap = rectBMax - rectAMin;
    negativeOverlap = rectAMax - rectBMin;
    if(positiveOverlap < negativeOverlap && positiveOverlap < overlap) {
      rectANormalVectorCollision = false;
      overlap = positiveOverlap;
      forceDirection = normalVector.copy().mult(-1);
      contactPosition = minPosition.copy();
    }
    else if(negativeOverlap < overlap) {
      rectANormalVectorCollision = false;
      overlap = negativeOverlap;
      forceDirection = normalVector.copy();
      contactPosition = maxPosition.copy();
    }
    
    // For the horizontal axis of rectangle B
    normalVector = PVector.sub(verticesB[1],verticesB[0]).normalize();
    rectBMin = PVector.dot(normalVector,rectBPosition)-rectBWidth/2;
    rectBMax = rectBMin + rectBWidth;
    rectAMin = Float.MAX_VALUE;
    rectAMax = -Float.MAX_VALUE;
    for(int i=0; i<verticesA.length; i++){
      vectorizedPosition = PVector.dot(normalVector,verticesA[i]);
      if(vectorizedPosition < rectAMin) {
        rectAMin = vectorizedPosition;
        minPosition = verticesA[i];
      }
      if(vectorizedPosition > rectAMax) {
        rectAMax = vectorizedPosition;
        maxPosition = verticesA[i];
      }
    }
    if(rectAMin>rectBMax || rectBMin>rectAMax) {
      return false;
    }
    
    // Getting values for collision resolution
    positiveOverlap = rectBMax - rectAMin;
    negativeOverlap = rectAMax - rectBMin;
    if(positiveOverlap < negativeOverlap && positiveOverlap < overlap) {
      rectANormalVectorCollision = false;
      overlap = positiveOverlap;
      forceDirection = normalVector.copy().mult(-1);
      contactPosition = minPosition.copy();
    }
    else if(negativeOverlap < overlap) {
      rectANormalVectorCollision = false;
      overlap = negativeOverlap;
      forceDirection = normalVector.copy();
      contactPosition = maxPosition.copy();
    }
    
    if(rectANormalVectorCollision) {
      rectAContactPosition = PVector.add(contactPosition, PVector.mult(forceDirection, overlap)).sub(rectAPosition);
      rectBContactPosition = PVector.sub(contactPosition, rectBPosition);
    }
    else {
      rectAContactPosition = PVector.sub(contactPosition, rectAPosition);
      rectBContactPosition = PVector.add(contactPosition, PVector.mult(forceDirection, overlap)).sub(rectBPosition);
    }
    resolveCollision(this, other, rectAContactPosition, rectBContactPosition, forceDirection, overlap);
    return true;
  }
}
  

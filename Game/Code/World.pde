public class World {
  private ArrayList<RigidBody> bodyList;
  private PVector gravity;
  private float linearVelocityFactor;
  
  public World() {
    this.bodyList = new ArrayList<RigidBody>();
    this.gravity = new PVector(0, 1000);
    this.linearVelocityFactor = 0.9999;
  }
  
  public int size(){
    return bodyList.size();
  }
  
  public void addBody(RigidBody body) {
    this.bodyList.add(body);
  }
  
  public void removeBodyIndx(int indx) {
    this.bodyList.remove(indx);
  }
  
  public void removeBody(RigidBody body) {
    this.bodyList.remove(body);
  }
   
  public RigidBody getBody(int index) {
    if(index>=0 && index<this.bodyList.size()) {
      return this.bodyList.get(index);
    } else {
      return null;
    }
  }
  
  public int getBodyListSize() {
    return bodyList.size();
  }
  
  public void step(float frameTime) {
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).step(frameTime, gravity, linearVelocityFactor);
    }
    
  }
  
  public boolean collideBodies(){
    boolean occurs = false;
    for(int i=0; i<this.bodyList.size()-1; i++){
      for(int j=i+1; j<this.bodyList.size(); j++){
        if(!bodyList.get(i).isStatic() || !bodyList.get(j).isStatic()) {
          if(bodyList.get(i).intersect(bodyList.get(j))){
            occurs = true;
            isPigCollision(bodyList.get(i), bodyList.get(j));
          }
        }
      }
    }
    return occurs;
  }
  
  private void isPigCollision(RigidBody bodyA, RigidBody bodyB){
    // Excluding Rigid Bodies
    if(!bodyA.isStatic() && !bodyB.isStatic()){
      //Is one of the coliding bodies is a pig?
      if(bodyA.getShapeType() == ShapeType.CIRCLE){
        Circle possiblePig = (Circle) bodyA;
        if( possiblePig.getAnimalType() == AnimalType.PIG){
          isPigDead((Pig) possiblePig);
        }  
      }
      if(bodyB.getShapeType() == ShapeType.CIRCLE){
        Circle possiblePig = (Circle) bodyB;
        if(possiblePig.getAnimalType() == AnimalType.PIG){
          isPigDead((Pig) possiblePig); 
        }
      }
    }
  }
  
  //The Impulse doesn't work as expected!!!player
  private void isPigDead(Pig pig){
    if(pig.getImpulse() > 0){
      pig.killPig();
    }
  }
  
  public void display(){
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).display();
    }
  }
  
}

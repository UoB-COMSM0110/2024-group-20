public class World {
  private ArrayList<RigidBody> bodyList;
  private PVector gravity;
  private float linearVelocityFactor;
  
  public World() {
    this.bodyList = new ArrayList<RigidBody>();
    this.gravity = new PVector(0, 1000);
    this.linearVelocityFactor = 0.9999;
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
  
  public ArrayList<RigidBody> getBodyList() {
    return this.bodyList;
  }
  
  public int getBodyListSize() {
    return bodyList.size();
  }
  
  public PVector getGravity() {
    return gravity;
  }
  
  public void step(float frameTime) {
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).step(frameTime, gravity, linearVelocityFactor);
    }
    
  }
  
  public boolean collideBodies(){
    boolean occurs = false;
    for(int i=0; i<this.bodyList.size()-1; i++){
      RigidBody body1 = bodyList.get(i);
      for(int j=i+1; j<this.bodyList.size(); j++){
        RigidBody body2 = bodyList.get(j);
        if(!body1.isStatic() || !body2.isStatic()) {
          if(body1.intersect(body2)) {
            occurs = true;
            body1.setLastContactBody(body2);
            body2.setLastContactBody(body1);
          }
        }
      }
    }
    return occurs;
  }
  
  public void display(){
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).display();
    }
  }
  
}

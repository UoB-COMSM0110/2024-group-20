
public class World {
  private PVector gravity = new PVector(0, 1000);
  private ArrayList<RigidBody> bodyList;
  float linearVelocityFactor = 0.9999;
  
  public World() {
    this.bodyList = new ArrayList<RigidBody>();
  }
  
  public void addBody(RigidBody body) {
    this.bodyList.add(body);
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
          if(bodyList.get(i).intersect(bodyList.get(j))) occurs = true;
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

void wSteps() {
  for(int i=0; i<20; i++) {
    w.step(1/frameRate/20);
    w.collideBodies();
  }
  //if(w.getBody(0).largestImpulse > 2.3E7) {
  //  w.removeBody(w.getBody(0));
  //}
}

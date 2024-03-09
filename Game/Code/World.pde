public class World {
  private PVector gravity;
  private ArrayList<RigidBody> bodyList;
  
  public World() {
    this.gravity = new PVector(0, -9.81);
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
  
  public void step(float frameTime) {
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).step(frameTime);
    }
  }
}

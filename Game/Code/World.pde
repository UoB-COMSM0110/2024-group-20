public class World {
  private ArrayList<RigidBody> bodyList;
  float dragCoefficient = 0.99;
  private PVector gravity;
  
  public World() {
    this.bodyList = new ArrayList<RigidBody>();
    this.gravity = new PVector(0, 120);
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
  
  public int getListSize() {
    return bodyList.size();
  }
  
  public void step(float frameTime) {
    for(int i=0; i<this.bodyList.size(); i++) {
      this.bodyList.get(i).step(frameTime, gravity, dragCoefficient);
    }
    
  }
  
  public boolean collideBodies(){
    boolean occurs = false;
    for(int i=0; i<this.bodyList.size()-1; i++){
      for(int j=i+1; j<this.bodyList.size(); j++){
        if(bodyList.get(i).intersect(bodyList.get(j))) 
          occurs = true;
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

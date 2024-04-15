public class Ground extends Rectangle{
  
  //PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation
  public Ground(PVector position,float rectWidth, float rectHeight, float rotation){
    super(position, 1, 0.8, true, rectWidth, rectHeight, rotation);
    this.frictionRestitution = 0.8;
  }
  
  public void display(){
    stroke(255, 0);
    fill(88, 57, 39, 0);
    super.display();
    noStroke();
  }
}

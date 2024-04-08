public class Ground extends Rectangle{
  
  //PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation
  public Ground(PVector position,float density, float restitution, float rectWidth, float rectHeight, float radius){
    super(position, density, restitution, true, rectWidth, rectHeight, radius);
  }
  
  public void display(){
    fill(88, 57, 39);
    rect(position.x, position.y, rectWidth, rectHeight);
  }
}

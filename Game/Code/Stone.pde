public class Stone extends Material {
  public Stone(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
  }

  @Override
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    fill(128, 128, 128); 
    rotate(rotation);
    rect(0, 0, rectWidth, rectHeight);
    popMatrix();
  }
}

public class Glass extends Material {
  public Glass(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
    this.frictionRestitution = 0.2;
  }

  @Override
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    fill(100, 255, 127, 128); 
    rotate(rotation);
    rect(0, 0, rectWidth, rectHeight);
    popMatrix();
  }
}

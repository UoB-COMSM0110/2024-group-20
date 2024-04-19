public class Stone extends Material {
  public Stone(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
    this.frictionRestitution = 0.8;
    impulseToughness = 10e6;
  }

  @Override
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    image(gameImages.get("stone"), 0, 0); 
    popMatrix();
  }
}

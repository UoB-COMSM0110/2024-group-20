public class Stone extends Material {
  public Stone(PVector position, float rotation) {
    super(position, 1.0, 0.3, false, 48, 195, rotation);
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

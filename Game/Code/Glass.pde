public class Glass extends Material {
  public Glass(PVector position, float rotation) {
    super(position, 0.5, 0.8, false, 48, 195, rotation);
    this.frictionRestitution = 0.2;
    impulseToughness = 1e6;
  }

  @Override
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    tint(255, 150);
    image(gameImages.get("glass"), 0, 0); 
    noTint();
    popMatrix();
  }
}

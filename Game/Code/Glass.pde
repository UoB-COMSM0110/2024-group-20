public class Glass extends Material {
  public Glass(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
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

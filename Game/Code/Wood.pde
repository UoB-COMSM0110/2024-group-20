public class Wood extends Material {
  public Wood(PVector position,float rotation) {
    super(position, 0.7, 0.5, false, 48, 195, rotation);
    this.frictionRestitution = 0.6;
    impulseToughness = 6e6;
  }

  @Override
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    image(gameImages.get("wood"), 0, 0); 
    popMatrix();
  }
}

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
    if(isSelected == false){
      tint(255, 150);
      image(gameImages.get("glass"), 0, 0); 
      noTint();
    }
    else{
      tint(255, 150);
      image(gameImages.get("glass"), 0, 0); 
      noTint();     
      fill(255, 255, 0, 100); 
      rect(0, 0, rectWidth, rectHeight);
    }
    popMatrix();
  }
}

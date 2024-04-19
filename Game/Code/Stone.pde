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
    if(isSelected == false){
      image(gameImages.get("stone"), 0, 0); 
    }
    else{
      image(gameImages.get("stone"), 0, 0); 
      fill(255, 255, 0, 100); 
      rect(0, 0, rectWidth, rectHeight);    
    }  
    popMatrix();
  }
}

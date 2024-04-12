abstract class Material extends Rectangle {
  protected float impulseToughness;
  
  public Material(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
  }

  abstract void display(); // Abstract draw method to be implemented by subclasses
 
  public boolean isMouseOver(int mouseX, int mouseY) {
    return mouseX >= position.x - rectWidth / 2 && mouseX <= position.x + rectWidth / 2 &&
         mouseY >= position.y - rectHeight / 2 && mouseY <= position.y + rectHeight / 2;
  }
  
  public float getImpulseToughness(){
    return impulseToughness;
  }

}

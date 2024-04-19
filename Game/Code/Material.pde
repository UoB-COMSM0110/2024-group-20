abstract class Material extends Rectangle {
  protected float impulseToughness;
  protected boolean isSelected;

  public Material(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
    isSelected = false;
  }

  abstract void display(); // Abstract draw method to be implemented by subclasses
 
  public boolean isMouseOver(int mouseX, int mouseY) {
    PVector mousePosition = new PVector(mouseX - position.x, mouseY - position.y).rotate(-rotation);
    return mousePosition.x >= - rectWidth / 2 && mousePosition.x <= rectWidth / 2 &&
         mousePosition.y >= - rectHeight / 2 && mousePosition.y <= rectHeight / 2;
  }
  
  public float getImpulseToughness(){
    return impulseToughness;
  }
  
  public void select(){
    isSelected = true; 
  }
  
  public void unselect(){
    isSelected = false; 
  }

}

abstract class Material extends Rectangle {
  protected float impulseToughness;

  public Material(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight, float rotation) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, rotation);
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
  
  public void highlight() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    fill(255, 255, 0, 100); 
    rect(0, 0, rectWidth, rectHeight);
    popMatrix();
  }

}

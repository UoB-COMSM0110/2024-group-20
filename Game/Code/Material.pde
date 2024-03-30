abstract class Material extends Rectangle {
  float rotationAngle = 0;
  public Material(PVector position, float density, float restitution, boolean isStatic, float rectWidth, float rectHeight) {
    super(position, density, restitution, isStatic, rectWidth, rectHeight, 0);
  }

  abstract void draw(PGraphics pg); // Abstract draw method to be implemented by subclasses
 
  public void rotate(float angle) {
    rotationAngle += angle; // Adjust the rotation angle
  }

  protected void drawBase(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(position.x, position.y);
    pg.rotate(rotationAngle);
    pg.rectMode(CENTER);
    pg.rect(0, 0, rectWidth, rectHeight);
    pg.popMatrix();
  }
  
  boolean isMouseOver(int mouseX, int mouseY) {
  return mouseX >= position.x - rectWidth / 2 && mouseX <= position.x + rectWidth / 2 &&
         mouseY >= position.y - rectHeight / 2 && mouseY <= position.y + rectHeight / 2;
  }

}

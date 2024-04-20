public class ImageButton {
  private float buttonX, buttonY;
  private float buttonWidth, buttonHeight;
  private PImage buttonImage;
  private boolean isMouseOver = false;

  // Constructor
  public ImageButton(PImage buttonImage,float buttonX, float buttonY, float buttonWidth, float buttonHeight) {
    this.buttonImage = buttonImage;
    this.buttonX = buttonX;
    this.buttonY = buttonY;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }
  
  public void display() {
    image(buttonImage, buttonX, buttonY, buttonWidth, buttonHeight);
    
    update();

    if (isMouseOver) { 
      noStroke();
      fill(255, 255, 255, 100);
      rect(buttonX, buttonY, buttonWidth, buttonHeight);
    }
  }

  private void update() {
    if (mouseX >= buttonX - buttonWidth/2 && mouseX <= buttonX + buttonWidth/2 && 
        mouseY >= buttonY - buttonHeight/2 && mouseY <= buttonY + buttonHeight/2) {
        isMouseOver = true;
    } else {
        isMouseOver = false;
    }
  }

  public boolean clicked() {
    if(isMouseOver && mousePressed){
      gameAudios.get("buttonSound").play();
      return true;
    }
    return false;
  }

}
public class ImageButton {
  float x, y; // Position of the button
  float width, height; // Size of the button
  PImage image; // Image used for the button
  boolean isOver = false; 

  // Constructor
  public ImageButton(PImage image,float x, float y, float width, float height) {
    this.image = image;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.image = image;
  }

  public void display() {
    image(image, x, y, width, height);
    
    if (isOver) { 
      fill(255, 255, 255, 100);
      rect(x, y, width, height);
    }
  }

  public void update() {
    if (mouseX >= x-width/2 && mouseX <= x +width/2&& mouseY >= y - height/2 && mouseY <= y + height/2) {
        isOver = true;
    } else {
        isOver = false;
    }
  }

  public boolean clicked() {
    return isOver && mousePressed;
  }
}

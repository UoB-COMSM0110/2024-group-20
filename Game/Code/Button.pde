/*class Button implements Clickable {
  float x, y; // Button top-left corner
  PImage buttonImage; // Button image
  boolean isHovered; // State to track if the mouse is over the button

  // Constructor with hover image
  Button(float x, float y, PImage buttonImage, PImage hoverImage) {
    this.x = x;
    this.y = y;
    this.buttonImage = buttonImage;
    this.hoverImage = hoverImage; // This can be null if not used
  }

  // Constructor without hover image
  Button(float x, float y, PImage buttonImage) {
    this(x, y, buttonImage, null);
  }

  void update() {
    // Update hover state based on mouse position
    isHovered = mouseX >= x && mouseX <= x + buttonImage.width && mouseY >= y && mouseY <= y + buttonImage.height;
  }

  boolean isMouseOver(int mouseX, int mouseY) {
    return isHovered; // Use the hover state to determine if the mouse is over the button
  }

  @Override
  public void createInstanceAt(int x, int y) {
   //
  }
}*/

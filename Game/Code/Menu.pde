interface ButtonCallback {
  void onButtonPressed();
}

PImage nextImage;
PImage skipImage;
PImage woodBoardImage;

public class Menu {
  float x, y; // Position of the menu
  float width, height; // Dimensions of the menu
  String menuText; // Predefined text for the menu
  int stepNumber, totalSteps; // For page footer (e.g., "1/4")
  ButtonCallback callbackNext; // Callback for Next button
  ButtonCallback callbackSkip; // Callback for Skip button

  // Constructor
  Menu(float x, float y, float width, float height,String menuText,int stepNumber, int totalSteps, ButtonCallback callbackNext, ButtonCallback callbackSkip) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.menuText = menuText;
    this.stepNumber = stepNumber;
    this.totalSteps = totalSteps;
    this.callbackNext = callbackNext;
    this.callbackSkip = callbackSkip;
    woodBoardImage = loadImage("../Images/woodBoard.png");
    nextImage = loadImage("../Images/nextButton.png");
    skipImage = loadImage("../Images/skipButton.png");
  }

   // Display the menu
  void display() {
    // Draw the menu background
    image(woodBoardImage, x, y, width, height);
    
    // Draw buttons 
    image(skipImage,x + width * 0.25, y + height/2 - height * 0.2, width * 0.2, height * 0.15); // skip Button 
    image(nextImage,x - width * 0.25, y + height/2 - height * 0.2, width * 0.2, height * 0.15); // next Button 
    fill(0);
    textSize(20);
    String footerText = stepNumber + "/" + totalSteps;
    text(footerText, x, y + height/2 - height * 0.02); // Centered at the bottom
    
    displayWrappedText(menuText, x, y - height * 0.4, width * 0.9);
  }

 
  // Handle whether button is clicked, maybe can be seprated to a button class, 
  //so the menu can be use more widely.
  void mousePressed() {
    // Check if a button is pressed
    // Next
      if (mouseX >= x + width * 0.05 && mouseX <= x + width * 0.05 + width * 0.2 &&
        mouseY >= y + height - height * 0.2 && mouseY <= y + height - height * 0.2 + height * 0.15) {
          if (callbackSkip != null) {
            callbackSkip.onButtonPressed();
          }
        }
      // Skip
      else if (mouseX >= x + width - width * 0.25 && mouseX <= x + width - width * 0.25 + width * 0.2 &&
        mouseY >= y + height - height * 0.2 && mouseY <= y + height - height * 0.2 + height * 0.15) {
        if (callbackNext != null) {
                callbackNext.onButtonPressed();
        }
      }
  }
  //self-adjusted text display.
  void displayWrappedText(String text, float x, float y, float maxWidth) {
      //textSize(20); // Set a standard text size,maybe should restrict to one certain size.
      String[] words = text.split(" ");
      String line = "";
      float lineHeight = 20; // Height of each line of text

      for (String word : words) {
          String testLine = line + word + " ";
          if (textWidth(testLine) > maxWidth) {
            text(line, x, y);
            line = word + " ";
             y += lineHeight;
           } 
           else {
             line = testLine;
           }
      }
      text(line, x, y); 
  }
  
}

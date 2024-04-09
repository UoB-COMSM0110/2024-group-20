interface ButtonCallback {
  void onButtonPressed();
}

public class Menu {
  PImage nextImage;
  PImage skipImage;
  PImage woodBoardImage;
  
  float x, y; // Position of the menu
  float width, height; // Dimensions of the menu
  String menuText; // Predefined text for the menu
  int stepNumber, totalSteps; // For page footer (e.g., "1/4")
  ButtonCallback callbackNext; // Callback for Next button
  ButtonCallback callbackSkip; // Callback for Skip button
  ImageButton nextButton,skipButton;
  boolean nextPressed;//check whether next is pressed
  String levelText = "Survived! Click NEXT to next attack wave!";

  // Constructor for tutorial
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
    woodBoardImage = gameImages.get("woodBoard");
    nextImage = gameImages.get("nextButton");
    skipImage = gameImages.get("skipButton");
    skipButton = new ImageButton(skipImage,x - width * 0.25, y + height/2 - height * 0.2, width * 0.2, height * 0.15); // skip Button
    nextButton = new ImageButton(nextImage,x + width * 0.25, y + height/2 - height * 0.2, width * 0.2, height * 0.15); // next Button
  }
  //Constructor for level
  Menu(float x, float y, float width, float height){
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    nextPressed = true;
    woodBoardImage = gameImages.get("woodBoard");
    nextImage = gameImages.get("nextButton");
    nextButton = new ImageButton(nextImage,x, y + height/2 - height * 0.2, width * 0.2, height * 0.15); // next Button
  }
   // Display the menu for tutorial.
  void display() {
    // Draw the menu background
    image(woodBoardImage, x, y, width, height);
       
    // Draw buttons
    skipButton.update();
    skipButton.display();
    nextButton.update();
    nextButton.display();
    fill(0);
    textSize(20);
    String footerText = stepNumber + "/" + totalSteps;
    text(footerText, x, y + height/2 - height * 0.02); // Centered at the bottom
   
    displayWrappedText(menuText, x, y - height * 0.4, width * 0.9);
  }
  //Display menu for level
  void displayMenu() {
    if(!nextPressed){
      return;
    }
      image(woodBoardImage, x, y, width, height);
      nextButton.update();
      nextButton.display();
      fill(0);
      textSize(40);
      text(levelText, x, y  + height * 0.02);
  }

  void clicked(){
     if(!nextPressed){
      return;
    }

    if(nextButton.clicked()){
      nextPressed = false;
    }
  }

  void resetMenu(){
    nextPressed = true;
  }

  void mousePressed() {
    // Check if a button is pressed
    // Next
      if (skipButton.clicked()) {
          if (callbackSkip != null) {
            callbackSkip.onButtonPressed();
          }
        }
      // Skip
      else if (nextButton.clicked()) {
        nextPressed = false;
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

public interface ButtonCallback {
  public void onButtonPressed();
}

public class Menu {
  private PImage nextImage;
  private PImage skipImage;
  private PImage woodBoardImage;
  
  private float menuX, menuY;
  private float menuWidth, menuHeight; 
  private String menuText; // Predefined text for the tutorial
  private int stepNumber, totalSteps; // For page footer (e.g., "1/4")
  private ButtonCallback callbackNext; // Callback for Next button
  private ButtonCallback callbackSkip; // Callback for Skip button
  private ImageButton nextButton,skipButton;
  private boolean nextPressed;//check whether next is pressed for level
  private String[] levelTexts;

  // Constructor for tutorial
  public Menu(float menuX, float menuY, float menuWidth, float menuHeight,String menuText,int stepNumber, int totalSteps, ButtonCallback callbackNext, ButtonCallback callbackSkip) {
    this.menuX = menuX;
    this.menuY = menuY;
    this.menuWidth = menuWidth;
    this.menuHeight = menuHeight;
    this.menuText = menuText;
    this.stepNumber = stepNumber;
    this.totalSteps = totalSteps;
    this.callbackNext = callbackNext;
    this.callbackSkip = callbackSkip;
    woodBoardImage = gameImages.get("woodBoard");
    nextImage = gameImages.get("nextButton");
    skipImage = gameImages.get("skipButton");
    skipButton = new ImageButton(skipImage,menuX - menuWidth * 0.25, menuY + menuHeight/2 - menuHeight * 0.2, menuWidth * 0.2, menuHeight * 0.15); // skip Button
    nextButton = new ImageButton(nextImage,menuX + menuWidth * 0.25, menuY + menuHeight/2 - menuHeight * 0.2, menuWidth * 0.2, menuHeight * 0.15); // next Button
  }
  //Constructor for level
  public Menu(float menuX, float menuY, float menuWidth, float menuHeight){
    this.menuX = menuX;
    this.menuY = menuY;
    this.menuWidth = menuWidth;
    this.menuHeight = menuHeight;
    nextPressed = true;
    woodBoardImage = gameImages.get("woodBoard");
    nextImage = gameImages.get("nextButton");
    nextButton = new ImageButton(nextImage,menuX, menuY + menuHeight/2 - menuHeight * 0.2, menuWidth * 0.2, menuHeight * 0.15); // next Button
    this.levelTexts = new String[]{
        "Survived!\n Click NEXT to prepare for the next attack wave!\nBe carefull,\nthe purple bird can reverse gravity!",
        "Survived!\n Click NEXT to prepare for the next attack wave!\nBe carefull,\nthe black bird explodes!"

    };
  }
   // Display the menu for tutorial.
  public void display() {
    // Draw the menu background
    image(woodBoardImage, menuX, menuY, menuWidth, menuHeight);
       
    // Draw buttons
    skipButton.display();
    nextButton.display();
    fill(0);
    textSize(20);
    String footerText = stepNumber + "/" + totalSteps;
    text(footerText, menuX, menuY + menuHeight/2 - menuHeight * 0.02); // Centered at the bottom
   
    textSize(40);
    displayWrappedText(menuText, menuX, menuY - menuHeight * 0.3, menuWidth * 0.9);
  }
  //Display menu for level
  public void displayMenu(int i) {
    if(!nextPressed){
      return;
    }
      image(woodBoardImage, menuX, menuY, menuWidth, menuHeight);
      nextButton.display();
      fill(0);
      textSize(40);
      text(levelTexts[i], menuX, menuY-menuHeight/3);
  }

  public void clicked(){
     if(!nextPressed){
      return;
    }

    if(nextButton.clicked()){
      nextPressed = false;
    }
  }

  public void resetMenu(){
    nextPressed = true;
  }

  public void mousePressed() {
    // Check if a button is pressed
    // skip
      if (skipButton.clicked()) {
          if (callbackSkip != null) {
            callbackSkip.onButtonPressed();
          }
        }
      // next
      else if (nextButton.clicked()) {
        nextPressed = false;
        if (callbackNext != null) {
            callbackNext.onButtonPressed();
        }
      }
  }
  //self-adjusted text display.
  public void displayWrappedText(String text, float x, float y, float maxWidth) {
    String[] words = text.split(" ");
    String testLine = "";
    String newLine = "";
    String line = "";

    for (String word : words) {
      testLine = newLine + word + " ";
      if (textWidth(testLine) > maxWidth) {
        line = line + newLine + "\n";
        newLine = word + " ";
      }
      else {
        newLine = newLine + word + " ";
      }
    }
    line = line + newLine;
    text(line, x, y);
  }
 
}




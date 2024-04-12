public class Tutorial {
  private Menu[] menus;

  private int currentStep;
  private int totalSteps;
  
  public Tutorial() {
    currentStep = 0;
    totalSteps = 5;
    menus = new Menu[totalSteps]; // Assuming 5 steps in the tutorial
    // Initialize each menu with position, size,text, can add more tutorials after.
    menus[0] = new Menu(width/2, height/2, width/2, height/2,"Welcome to Anxious Pigs! Here is a tutorial ,click NEXT to go next, click SKIP to skip.",1, totalSteps, this::nextStep, this::skipTutorial);
    menus[1] = new Menu(width/10, height/3, width/5, height/3, "Buy materails to add structures.", 2, totalSteps, this::nextStep, this::skipTutorial);
    menus[2] = new Menu(width/2, height/2, width/3, height/3, "Use materials to shield pigs.", 3, totalSteps, this::nextStep, this::skipTutorial);
    menus[3] = new Menu(width/2, height/3, width/3, height/6, "Once ready click start.", 4, totalSteps, this::nextStep, this::skipTutorial);
    menus[4] = new Menu(width-width/10,height/20+height/7, width/10, height/7, "Use less material and survive more to gain higher score.", 5, totalSteps, this::nextStep, this::skipTutorial);
  }

  public void display() {
    if (currentStep < menus.length) {
      fill(0,0,0,150);
      rect(width/2,height/2,width,height);
      menus[currentStep].display();
    }
  }

  public void nextStep() {
    currentStep++;
  }
  public void skipTutorial() {
    currentStep = totalSteps;
  }
    
  public void mousePressed() {
    if (currentStep < menus.length) {
      menus[currentStep].mousePressed();
    }
  }
  
}

public class Tutorial {
  private Menu[] menus;

  private int currentStep;
  private int totalSteps;
  
  public Tutorial() {
    currentStep = 0;
    totalSteps = 7;
    menus = new Menu[totalSteps]; // Assuming 5 steps in the tutorial
    // Initialize each menu with position, size,text, can add more tutorials after.
    menus[0] = new Menu(width/2, height/2, width/3, height/3,"Welcome to Anxious Pigs!\n Here is a tutorial ,click NEXT to go next, click SKIP to skip.",1, totalSteps, this::nextStep, this::skipTutorial);
    menus[1] = new Menu(width/2, height/2, width/3, height/3, "Use materials to shield pigs from falling birds. Birds will be falling from the highlighted areas", 2, totalSteps, this::nextStep, this::skipTutorial);
    menus[2] = new Menu(width/3, 3 * height/5, width/3, height/3, "Click buttons on the left to buy materials or delete them, in order to build structures protecting pigs.", 3, totalSteps, this::nextStep, this::skipTutorial);
    menus[3] = new Menu(width/3, 3 * height/5, width/3, height/3, "There are three types of materials, the more resilient ones cost more!", 4, totalSteps, this::nextStep, this::skipTutorial);
    menus[4] = new Menu(width/3, 3 * height/5, width/3, height/3, "You can use A and D buttons to rotate the materials!", 5, totalSteps, this::nextStep, this::skipTutorial);
    menus[5] = new Menu(width-width/8-width/10,height/5+height/8, width/3, height/3, "Use less materials and protect more pigs to gain higher score.", 6, totalSteps, this::nextStep, this::skipTutorial);
    menus[6] = new Menu(width/2, height/3, width/3, height/3, "\n\nOnce finish, click READY! for the gravity to turn on and for birds to start attacking!", 7, totalSteps, this::nextStep, this::skipTutorial);
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
  
  public void resetTutorial(){
    currentStep = 0;
  }
    
  public void mousePressed() {
    if (currentStep < menus.length) {
      menus[currentStep].mousePressed();
    }
  }
  
}

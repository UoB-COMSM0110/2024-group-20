public class Tutorial {
  private Menu[] menus;

  private int currentStep;
  private int totalSteps;
  
  public Tutorial() {
    currentStep = 0;
    totalSteps = 7;
    menus = new Menu[totalSteps]; // Assuming 5 steps in the tutorial
    // Initialize each menu with position, size,text, can add more tutorials after.
    menus[0] = new Menu(width/2, height/2, width/3, height/3,"Welcome to Anxious Pigs!\n Here is a tutorial,\nclick NEXT to go next,\nclick SKIP to skip.",1, totalSteps, this::nextStep, this::skipTutorial);
    menus[1] = new Menu(width/2, height/2, width/3, height/3, "Build structure to shield pigs from birds. They come from the highlighted area above!", 2, totalSteps, this::nextStep, this::skipTutorial);
    menus[2] = new Menu(width/3, 3 * height/5, width/3, height/3, "Click buttons on the left to buy or sell back a material block, place them to build structures protecting pigs.", 3, totalSteps, this::nextStep, this::skipTutorial);
    menus[3] = new Menu(width/3, 3 * height/5, width/3, height/3, "Type and cost of materials:\nGlass - 50\nWood - 100\nStone - 150", 4, totalSteps, this::nextStep, this::skipTutorial);
    menus[4] = new Menu(width/3, 3 * height/5, width/3, height/3, "To rotate the material block,\nuse A and D keys \nor the mousewheel!", 5, totalSteps, this::nextStep, this::skipTutorial);
    menus[5] = new Menu(width-width/8-width/10,height/5+height/8, width/3, height/3, "Try spend less budget and protect more pigs to achieve higher score.", 6, totalSteps, this::nextStep, this::skipTutorial);
    menus[6] = new Menu(width/2, height/3, width/3, height/3, "Once finish, click READY! \nTime will unfreeze\nand birds will start attacking!", 7, totalSteps, this::nextStep, this::skipTutorial);
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

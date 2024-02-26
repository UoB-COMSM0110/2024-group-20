public class Tutorial {
  Menu[] menus;
  int currentStep;
  int totalSteps;
  Tutorial() {
    currentStep = 0;
    totalSteps = 4;
    menus = new Menu[4]; // Assuming 4 steps in the tutorial
    // Initialize each menu with position, size,text, can add more tutorials after.
    menus[0] = new Menu(width/10, height/3, width/5, height/3, "Buy materails to add structures.", 1, totalSteps, this::nextStep, this::skipTutorial);
    menus[1] = new Menu(width/2-width/6, height/2-height/6, width/3, height/3, "Use materials to shield pigs.", 2, totalSteps, this::nextStep, this::skipTutorial);
    menus[2] = new Menu(width/2-width/6, height/3, width/3, height/6, "Once ready click start.", 3, totalSteps, this::nextStep, this::skipTutorial);
    menus[3] = new Menu(width-width/10,height/20+height/7, width/10, height/7, "Use less material and survive more to gain higher score.", 4, totalSteps, this::nextStep, this::skipTutorial);
  }

  void display() {
    if (currentStep < menus.length) {
      menus[currentStep].display();
    }
  }

  void nextStep() {
    currentStep++;
  }
  void skipTutorial() {
    currentStep = totalSteps;
  }
    
  void mousePressed() {
    if (currentStep < menus.length) {
      menus[currentStep].mousePressed();
    }
  }
  
}
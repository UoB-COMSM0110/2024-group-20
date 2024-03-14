public class Tutorial {
  Menu[] menus;
  HighlightArea[] highlights;

  int currentStep;
  int totalSteps;
  Tutorial() {
    currentStep = 0;
    totalSteps = 5;
    menus = new Menu[totalSteps]; // Assuming 4 steps in the tutorial
    highlights = new HighlightArea[totalSteps];
    // Initialize each menu with position, size,text, can add more tutorials after.
    menus[0] = new Menu(width/2-width/4, height/2-height/4, width/2, height/2,"Welcome to Anxious Pig! Here is a tutorial ,click NEXT to go next, click SKIP to skip.",1, totalSteps, this::nextStep, this::skipTutorial);
    highlights[0] = new HighlightArea(width/2-width/4, height/2-height/4, width/2, height/2);
    menus[1] = new Menu(width/10, height/3, width/5, height/3, "Buy materails to add structures.", 2, totalSteps, this::nextStep, this::skipTutorial);
    highlights[1] = new HighlightArea(width/10, height/3, width/5, height/3);
    menus[2] = new Menu(width/2-width/6, height/2-height/6, width/3, height/3, "Use materials to shield pigs.", 3, totalSteps, this::nextStep, this::skipTutorial);
    highlights[2] = new HighlightArea(width/2-width/6, height/2-height/6, width/3, height/3);
    menus[3] = new Menu(width/2-width/6, height/3, width/3, height/6, "Once ready click start.", 4, totalSteps, this::nextStep, this::skipTutorial);
    highlights[3] = new HighlightArea(width/2-width/6, height/3, width/3, height/6);
    menus[4] = new Menu(width-width/10,height/20+height/7, width/10, height/7, "Use less material and survive more to gain higher score.", 5, totalSteps, this::nextStep, this::skipTutorial);
    highlights[4] = new HighlightArea(width-width/10,height/20+height/7, width/10, height/7);
  }

  void display() {
    if (currentStep < menus.length) {
      menus[currentStep].display();
      highlights[currentStep].draw();
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

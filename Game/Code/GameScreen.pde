class GameScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  Level allLevels[];
  Tutorial tutorial;
  World w = new World();
  Material draggedMaterial = null;

  ArrayList<Circle> animals = new ArrayList<Circle>(); // A list to keep track of all materials
  ArrayList<Material> materials = new ArrayList<Material>(); // A list to keep track of all materials

  int firstLevel = 0;
  int currentLevel = 0;
  
  int clock = 0;
  int birdCount = 0;

  PImage bgImage,menuImage,emptyButtonImage,readyImage;
  ImageButton menuButton, woodButton, glassButton,stoneButton,readyButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  public GameScreen(ScreenManager screenManager,UserScore playerScore, Level allLevels[]){
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    this.allLevels = allLevels;
    
    //Adding boundaries to game screen
    
    //Needs to add an image so the ground is drawn
    w.addBody(new Ground(new PVector(width/2 ,height - 100), 1, 1, width, 200, 0)); // Ground  
    w.addBody(new Ground(new PVector(0 /*- 10*/, height/2 - 200), 1, 1, 20, height - 10, 0)); // Left
    w.addBody(new Ground(new PVector(width /*+ 10*/ , height/2 - 200), 1, 1, 20, height - 10, 0)); // Right
    
    bgImage = loadImage("../Images/map.png");
    emptyButtonImage = loadImage("../Images/emptyButton.png");
  
    buttons = new ArrayList<ImageButton>();
    //menu
    menuImage = loadImage("../Images/menuButton.png");
    menuButton = new ImageButton(menuImage, width - width/5,height - height/10,width/5,height/10);
    buttons.add(menuButton);
    //wood
    woodButton = new ImageButton(emptyButtonImage, 0,height/3,width/10,height/20);
    buttons.add(woodButton);
    //glass
    glassButton = new ImageButton(emptyButtonImage, 0,4*height/9,width/10,height/20);
    buttons.add(glassButton);
    //stone
    stoneButton = new ImageButton(emptyButtonImage, 0,5*height/9,width/10,height/20);
    buttons.add(stoneButton);
    //ready
    readyImage = loadImage("../Images/readyButton.png");
    readyButton = new ImageButton(readyImage, width/2-width/10,height/9,width/5,height/10);
    buttons.add(readyButton);
    tutorial = new Tutorial();  
  }

  //load all the image
  void display(){
    // setting background
    image(bgImage, 0, 0, width, height);
    
    // Player being able to enter his name
    if(playerScore.isNameUpdated() == false){
       playerScore.enterPlayerName();
     }else{
      // Physics engine start
      w.step(1/frameRate);
      w.collideBodies();
      w.display();
      
      if(allLevels[currentLevel].getStage() == 0){
        allLevels[currentLevel].stagePigsOnLevel(w, animals);
        //Add birds to new Array(not to w);
      }
      
      if(allLevels[currentLevel].getStage() == 1){
        // Can Modify the structure 
        //draw all the materials 
      }
      
      if(allLevels[currentLevel].getStage() == 2){
        //If not all the birds were realised
        if(birdCount < allLevels[currentLevel].getNoBirds()){
          if (clock == 0){ 
            //-> realise a bird
            birdCount++;
          }
          else if(clock == 20000){
            clock = 0;
          }
          else{
            clock++; 
          }
        }
        if (birdCount == allLevels[currentLevel].getNoBirds()){
          if(currentLevel < 2){
            //Calculating points function!!!
            currentLevel++;
            cleanLevel();
          }else{
            cleanLevel();
            currentLevel = 0;
            screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
          }
        }
      }
      
      for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }      
      for (Material material : materials) {
        material.draw(g); 
      }
            
      textDisplay();

    }

  }

  void textDisplay(){
    //score Display
    playerScore.printCurrentPlayerScore();
    //budget
    allLevels[currentLevel].printLevelBudget();
    textAlign(LEFT);
    tutorial.display(); 
  }
  void mousePressed(){
    //check tutorial
    tutorial.mousePressed();

    //drag materials
    for (Material material : materials) {
      if (material.isMouseOver(mouseX, mouseY)) {
        ///////////////////////////////////////
        //material.noForces();
        draggedMaterial = material;
        break;
      }
      
      ////////////////////////////////////////
      //material.allowForces();
      //print(material.getIsSelected() + " test\n");
    }

    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      playerScore.deletePlayer();
      cleanLevel();
      currentLevel = 0;
    }
    //if ready
    if(readyButton.clicked()){
      allLevels[currentLevel].stageStructuresReady();
    }
    //add wood
     PVector newPosition = new PVector(random(0,width/3), random(2*height/3,height));
    if(woodButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.WOOD)){
        Wood newWood = new Wood(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newWood);
        w.addBody(newWood);
      }
    }
    //glass
    if(glassButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.GLASS)){
        Glass newGlass = new Glass(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newGlass);
        w.addBody(newGlass);
      }
    }
    //stone
    if(stoneButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.STONE)){
        Stone newStone = new Stone(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newStone);
        w.addBody(newStone);
      }
    }
  }

  void keyPressed(){
    // Key Detection for entering the name of the player
    if(playerScore.isNameUpdated() == false){
      playerScore.pressedKey(key);
    }
    
////////////////////////////////JUST FOR DEMONSTRATION PURPOSES////////////
    if(key == '['){
     if(currentLevel < 2){
        //Calculating points
        currentLevel++;
        cleanLevel();
     }else{
       cleanLevel();
       currentLevel = 0;
       screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
     }
   }
   if(key == ']'){
       cleanLevel();
       currentLevel = 0;
       screenManager.setCurrentScreen(ScreenType.LOOSESCREEN);
    }
//////////////////////////////////////////////////////////////////////////
      if ((key == 'd' ||key=='D') && draggedMaterial != null) {  
        draggedMaterial.rotate(PI / 36); // Rotate by 10 degrees
      }
      if ((key == 'a'||key == 'A' ) && draggedMaterial != null) {
        draggedMaterial.rotate(-PI / 18); 
      }
  }

  void mouseDragged() {
    if (draggedMaterial != null) {
      draggedMaterial.position.set(mouseX, mouseY);
    }
  }

  void mouseReleased() {
    draggedMaterial = null;
  }

//method to clean the level
 public void cleanLevel() {
    for (Material material : materials){
      w.removeBody(material);
    }
    materials.clear();
    for (Circle animal : animals){
      w.removeBody(animal);
    }
    animals.clear();
 }
 
}

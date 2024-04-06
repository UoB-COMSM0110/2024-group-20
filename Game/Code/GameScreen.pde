class GameScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  Level allLevels[];
  Tutorial tutorial;
  World w = new World();
  Material draggedMaterial = null;
    
  ArrayList<Circle> animals =  new ArrayList<>(); // A list to keep track of all materials
  ArrayList<Material> materials =  new ArrayList<>(); // A list to keep track of all materials
  ArrayList<PVector> BirdAttackVectors = new ArrayList<>();
  
  int birdsIndx;

  int firstLevel = 0;
  int currentLevel = 0;
  
  Timer timer;
  boolean clockRestart = true;
  int birdCount = 0;
  boolean pflag = false;//If is true,enable physics to materials and turn off drags
  
  PImage bgImage,menuImage,emptyButtonImage,readyImage;
  ImageButton menuButton, woodButton, glassButton,stoneButton,readyButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  public GameScreen(ScreenManager screenManager,UserScore playerScore, Level allLevels[]){
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    this.allLevels = allLevels;
    timer = new Timer(5000);
        
    bgImage = loadImage("../Images/map.png");
    emptyButtonImage = loadImage("../Images/emptyButton.png");
  
    setBoundariesAndForces();
    setButtons();
    tutorial = new Tutorial();  
  }

  void display(){
    // setting background
    image(bgImage, 0, 0, width, height);
    
    // Player being able to enter his name
    if(playerScore.isNameUpdated() == false){
       playerScore.enterPlayerName();
     }else{
      // Physics engine start
      if (pflag){
      w.step(1/frameRate);
      }
      w.collideBodies();
      w.display();
      
      if(allLevels[currentLevel].getStage() == 0){
        allLevels[currentLevel].stagePigsOnLevel(w, animals);
        birdsIndx = animals.size();
        allLevels[currentLevel].stageBirdsOnLevel(animals);
      }
      if(allLevels[currentLevel].getStage() == 1){
        // Can Modify the structure 
        pflag = false;
        //draw all the materials 
      }     
      if(allLevels[currentLevel].getStage() == 2){
        //If not all the birds were realised
        pflag = true;
        if(birdsIndx < animals.size()){
          if (clockRestart){ 
            timer.startTimer();
            releaseBird();
            clockRestart = false;
            birdsIndx ++;
          }
          else if(timer.intervalFinished()){
            clockRestart = true;
          }
        }
        // If we released all the birds
        else if (timer.intervalFinished()){
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
    
  private void releaseBird(){
    //Choosing a force direction and initial position from list of possibilities
    int indx = (int) random(BirdAttackVectors.size()); 
    PVector chosenDirection = BirdAttackVectors.get(indx);
    float forceMag = 250000/*random(250000, 290000)*/;
    PVector force = PVector.mult(new PVector(chosenDirection.x, chosenDirection.y), forceMag);
    RigidBody bird = animals.get(birdsIndx);
    bird.setPosition(new PVector(chosenDirection.z, 0)); 
    w.addBody(bird);
    print(force);
    w.getBody(w.getListSize() - 1).applyForce(force);
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
    if(!pflag){
    //drag materials
    for (Material material : materials) {
      if (material.isMouseOver(mouseX, mouseY)) {
        draggedMaterial = material;
        break;
      }
    }

    //add wood
     PVector newPosition = new PVector(random(0,width/3), random(height/3,2*height/3));
    if(woodButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.WOOD)){
        Wood newWood = new Wood(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newWood);
        w.addBody(newWood);
      }
    }
    //add glass
    if(glassButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.GLASS)){
        Glass newGlass = new Glass(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newGlass);
        w.addBody(newGlass);
      }
    }
    //add stone
    if(stoneButton.clicked()){
      if(allLevels[currentLevel].buyResource(Resource.STONE)){
        Stone newStone = new Stone(newPosition, 0.5, 0.3, false, 50, 200,0);
        materials.add(newStone);
        w.addBody(newStone);
      }
    }
    }
    if(readyButton.clicked()){
      allLevels[currentLevel].stageStructuresReady();
      pflag=true;
    }
    
    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      playerScore.deletePlayer();
      cleanLevel();
      currentLevel = 0;
      pflag=false;
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
    pflag = false;
  }
  
    public void setBoundariesAndForces(){
    //Adding boundaries to game screen
    w.addBody(new Ground(new PVector(width/2 ,height - 100), 1, 1, width, 200, 0)); // Ground  
    w.addBody(new Ground(new PVector(0 /*- 10*/, height/2 - 200), 1, 1, 20, height - 10, 0)); // Left
    w.addBody(new Ground(new PVector(width /*+ 10*/ , height/2 - 200), 1, 1, 20, height - 10, 0)); // Right
    
    //Bird Attack Vectors (xCoorForce, yCoorForce, xPositionOfBird)
    BirdAttackVectors.add(new PVector(90, 90, width/6));
    BirdAttackVectors.add(new PVector(0, 180, width/2));
    BirdAttackVectors.add(new PVector(-90, 270, 5 * width/6));
  }
  
  public void setButtons(){
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
  }
}

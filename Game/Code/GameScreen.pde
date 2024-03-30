class GameScreen extends Screen {
  ScreenManager screenManager;
  UserScore playerScore;
  Level allLevels[];
  Tutorial tutorial;
  World w = new World();
  Material draggedMaterial = null;

  ArrayList<Material> materials = new ArrayList<Material>(); // A list to keep track of all materials

  int firstLevel = 0;
  int currentLevel = 0;

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
    w.addBody(new Ground(new PVector(0 - 10, height/2 - 200), 1, 1, 20, height - 10, 0)); // Left
    w.addBody(new Ground(new PVector(width + 10 , height/2 - 200), 1, 1, 20, height - 10, 0)); // Right
    
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
// In display we will need to somehow initialise levels.
    // setting background
    image(bgImage, 0, 0, width, height);
    
    w.collideBodies();
    w.display();

    // Player being able to enter his name
    if(playerScore.isNameUpdated() == false){
       playerScore.enterPlayerName();
     }else{

      for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }
      allLevels[currentLevel].printAllPigs();
      allLevels[currentLevel].printAllBirds();
      //score Display
      playerScore.printCurrentPlayerScore();
      //budget
      allLevels[currentLevel].printLevelBudget();
      textAlign(LEFT);
      tutorial.display();
    }
    //draw all the materials 
    for (Material material : materials) {
      material.draw(g); 
    }

  }

  void mousePressed(){
    //check tutorial
    tutorial.mousePressed();

    //drag materials
    for (Material material : materials) {
      if (material.isMouseOver(mouseX, mouseY)) {
        draggedMaterial = material;
        break;
      }
    }

    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      playerScore.deletePlayer();
      cleanMaterials();
    }
    //if ready
    if(readyButton.clicked()){allLevels[currentLevel].readyWithStructure();}
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
     }else{
       screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
     }
   }
   if(key == ']'){
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

//method to clean materials
 public void cleanMaterials() {
    for (Material material : materials){
      w.removeBody(material);
    }
    materials.clear();
 
 }
}

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
  ImageButton menuButton, woodButton,  glassButton,stoneButton,readyButton;
  ArrayList<ImageButton> buttons;
  
  //constuctor
  GameScreen(ScreenManager screenManager,UserScore playerScore){
    this.screenManager = screenManager;
    this.playerScore = playerScore;
    bgImage = loadImage("../Images/map.png");
    menuImage = loadImage("../Images/menuButton.png");
    emptyButtonImage = loadImage("../Images/emptyButton.png");
    readyImage = loadImage("../Images/readyButton.png");
  
    buttons = new ArrayList<ImageButton>();
    //menu
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
    readyButton = new ImageButton(readyImage, width/2-width/10,height/9,width/5,height/10);
    buttons.add(readyButton);
    
    tutorial = new Tutorial();  

    allLevels = new Level[3];
    allLevels[0] = new Level(200, 1, 3, 0, 0);
    allLevels[1] = new Level(150, 2, 3, 3, 0);
    allLevels[2] = new Level(100, 3, 3, 3, 3);
  }

  //load all the image
  void display(){

    w.collideBodies();
    // setting background
    image(bgImage, 0, 0, width, height);
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
      cleanMaterials();
    }
    //if ready
    if(readyButton.clicked()){allLevels[currentLevel].readyWithStructure();}
    //add wood
     PVector newPosition = new PVector(random(0,width/3), random(2*height/3,height));
    if(woodButton.clicked()){
      Wood newWood = new Wood(newPosition, 0.5, 0.3, false, 50, 200);
      materials.add(newWood);
      w.addBody(newWood);
    }
    //glass
    if(glassButton.clicked()){
      Glass newGlass = new Glass(newPosition, 0.5, 0.3, false, 50, 200);
      materials.add(newGlass);
      w.addBody(newGlass);
    }
    //stone
    if(stoneButton.clicked()){
      Stone newStone = new Stone(newPosition, 0.5, 0.3, false, 50, 200);
      materials.add(newStone);
      w.addBody(newStone);
    }
  }

  void keyPressed(){
    // Key Detection for entering the name of the player
    if(playerScore.isNameUpdated() == false){
      playerScore.pressedKey(key);
    }
    
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

public class GameScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private Level allLevels[];
  private Menu levelMenu;
  private Tutorial tutorial;
  private World w = new World();
  private Material draggedMaterial = null;
    
  private ArrayList<Circle> animals =  new ArrayList<>(); // A list to keep track of all animals
  private ArrayList<Material> materials =  new ArrayList<>(); // A list to keep track of all materials
  private ArrayList<PVector> BirdAttackVectors = new ArrayList<>();
  
  private int birdsIndx;

  private int currentLevel = 0;
  
  private Timer timer;
  private int clockRestart = 0; // 0->True, 1-> False, 2-> Level Ended and we need to start final clock
  private boolean pflag = false;//If is true,enable physics to materials and turn off drags
  
  private PImage bgImage,menuImage,emptyButtonImage,readyImage;
  private ImageButton menuButton, woodButton, glassButton,stoneButton,readyButton;
  private ArrayList<ImageButton> buttons;
  
  //constuctor
  public GameScreen(ScreenManager screenManager){
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.allLevels = screenManager.allLevels;
    timer = new Timer(3000); // 3s
        
    bgImage = gameImages.get("map");
    emptyButtonImage = gameImages.get("emptyButton");
  
    setBoundariesAndForces();
    setButtons();
    tutorial = new Tutorial();  
    levelMenu = new Menu(width/2, height/2, width/2, height/2);
  }

  public void display(){
    // setting background
    image(bgImage, width/2, height/2, width, height);
    
    // Physics engine start
    if (pflag){
      for(int i=0; i<10; i++) {
        w.step(1/frameRate/10);
        w.collideBodies();
      }
      checkAnimalActions();
    }
    w.collideBodies();
    w.display();
    
    if(allLevels[currentLevel].getStage() == 0){
      allLevels[currentLevel].stagePigsOnLevel(w, animals);
      birdsIndx = animals.size();
      allLevels[currentLevel].stageBirdsOnLevel(animals);
    }
    if(allLevels[currentLevel].getStage() == 1){
      if(currentLevel<3 && currentLevel>0){
        levelMenu.displayMenu();
        levelMenu.clicked();
      }
      // Can Modify the structure 
      pflag = false;
      
      for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }      
    }     
    if(allLevels[currentLevel].getStage() == 2){
      buttons.get(0).update();
      buttons.get(0).display();
      
      if(!continueBirdAttack()){
        endLevel(); 
      }
    }       
    textDisplay();
  }
  
  private void checkAnimalActions() {
    for(int i=0; i<animals.size(); i++) {
      Circle animal = animals.get(i);
      if(animal instanceof Pig) {
        //print(animal.getLargestImpulse()+"\n");
        Pig pig = (Pig) animal;
        if(pig.getLargestImpulse() > pig.getImpulseToughness()) {
          pig.killPig();
        }
      }
      if(animal instanceof BirdRed) {
        BirdRed birdRed = (BirdRed) animal;
        if(birdRed.getLargestImpulse() > birdRed.getImpulseToughness()) {
          w.removeBody(animal);
          animals.remove(animal);
          i--;
        }
      }
      if(animal instanceof BirdBlue) {
        BirdBlue birdBlue = (BirdBlue) animal;
        if(birdBlue.hasAbility() && birdBlue.getLastContactBody()!=null) {
          birdBlue.reverseGravity(w.getGravity());
        }
        if(birdBlue.getLargestImpulse() > birdBlue.getImpulseToughness()) {
          w.removeBody(animal);
          animals.remove(animal);
          i--;
        }
      }
      if(animal instanceof BirdBlack) {
        if(animal.getLastContactBody() != null) {
          BirdBlack birdBlack = (BirdBlack) animal;
          birdBlack.explode(w);
          w.removeBody(animal);
          animals.remove(animal);
          i--;
        }
      }
    }
  }
  
  private void endLevel(){
    if(clockRestart == 2){
      clockRestart = 0;
      timer.startTimer();
    }
    if(timer.intervalFinished()){
      player.updateScore(allLevels[currentLevel], currentLevel);
      if(allLevels[currentLevel].numberPigsAlive() == 0){
        cleanLevel();
        currentLevel = 0;
        screenManager.setCurrentScreen(ScreenType.LOSESCREEN); 
      }
      else if(currentLevel < 2){
        currentLevel++;
        cleanLevel();
        levelMenu.resetMenu();
        pflag = true;
      }else{
        cleanLevel();
        currentLevel = 0;
        screenManager.setCurrentScreen(ScreenType.WINSCREEN); 
      }
    }
  }
  
  private boolean continueBirdAttack(){
    if(birdsIndx >= animals.size() || allLevels[currentLevel].numberPigsAlive() == 0){
      if(clockRestart == 1){
        clockRestart = 2;
      }
      return false; 
    }
    if(clockRestart == 0){ 
      timer.startTimer();
      releaseBird();
      clockRestart = 1;
      birdsIndx ++;
    }
    else if(timer.intervalFinished()){
      clockRestart = 0;
    }
    return true;
  }
    
  private void releaseBird(){
    //Choosing a force direction and initial position from list of possibilities
    int indx = (int) random(BirdAttackVectors.size()); 
    PVector chosenDirection = BirdAttackVectors.get(indx);
    float speed = 1000;
    PVector linearVelocity = PVector.mult(new PVector(chosenDirection.x, chosenDirection.y).normalize(), speed);
    RigidBody bird = animals.get(birdsIndx);
    bird.setPosition(new PVector(chosenDirection.z, 0)); 
    bird.setLinearVelocity(linearVelocity);
    w.addBody(bird);
  }

  private void textDisplay(){
    //score Display
    player.printCurrentPlayerScore();
    //budget
    allLevels[currentLevel].printLevelBudget();
    tutorial.display(); 
  }
  
  public void mousePressed(){
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
     PVector newPosition = new PVector(random(width/10,width/3), random(height/3,5*height/9));
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
        Glass newGlass = new Glass(newPosition, 0.5, 0.8, false, 50, 200,0);
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
      zeroImpulses();
      allLevels[currentLevel].stageStructuresReady();
      pflag=true;
    }
    
    if(menuButton.clicked()){
      screenManager.setCurrentScreen(ScreenType.STARTSCREEN);
      player.deletePlayer();
      cleanLevel();
      currentLevel = 0;
      pflag=false;
    }
  }
  
  private void zeroImpulses(){
    for(Material material : materials){
      RigidBody body = material;
      body.setLargestImpulse(0);
    }
    for (Circle animal : animals){
      RigidBody body = animal;
      body.setLargestImpulse(0);
    }
  }

  public void keyPressed(){
    
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
       screenManager.setCurrentScreen(ScreenType.LOSESCREEN);
    }
//////////////////////////////////////////////////////////////////////////
    if ((key == 'd' ||key=='D') && draggedMaterial != null) {  
       draggedMaterial.setRotation(draggedMaterial.getRotation() + PI / 18); // Rotate by 20 degrees
    }
    if ((key == 'a'||key == 'A' ) && draggedMaterial != null) {
      draggedMaterial.setRotation(draggedMaterial.getRotation() - PI / 18); 
    }
  }

  public void mouseDragged() {
    if (draggedMaterial != null) {
      draggedMaterial.position.set(mouseX, mouseY);
    }
  }

  public void mouseReleased() {
    draggedMaterial = null;
  }

//method to clean the level
  private void cleanLevel() {
    for (Material material : materials){
      w.removeBody(material);
    }
    materials.clear();
    for (Circle animal : animals){
      w.removeBody(animal);
    }
    animals.clear();
  }
  
  private void setBoundariesAndForces(){
    //Adding boundaries to game screen
    w.addBody(new Ground(new PVector(width/2 ,height - 100), 1, 1, width, 200, 0)); // Ground  
    w.addBody(new Ground(new PVector(0 /*- 10*/, height/2 - 200), 1, 1, 20, height - 10, 0)); // Left
    w.addBody(new Ground(new PVector(width /*+ 10*/ , height/2 - 200), 1, 1, 20, height - 10, 0)); // Right
    
    //Bird Attack Vectors (xCoorForce, yCoorForce, xPositionOfBird)
    //BirdAttackVectors.add(new PVector(90, 90, width/6));
    BirdAttackVectors.add(new PVector(0, 180, width/2));
    //BirdAttackVectors.add(new PVector(-90, 270, 5 * width/6));
  }
  
  private void setButtons(){
    buttons = new ArrayList<ImageButton>();
    //menu
    menuImage = gameImages.get("menuButton");
    menuButton = new ImageButton(menuImage, width - width/10 - 10,height - height/20 - 10,width/5,height/10);
    buttons.add(menuButton);
    //wood
    woodButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f+1/10f),width/10,height/20);
    buttons.add(woodButton);
    //glass
    glassButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f),width/10,height/20);
    buttons.add(glassButton);
    //stone
    stoneButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f-1/10f),width/10,height/20);
    buttons.add(stoneButton);
    //ready
    readyImage = gameImages.get("readyButton");
    readyButton = new ImageButton(readyImage, width/2, height/10,width/5,height/10);
    buttons.add(readyButton);
  }
}

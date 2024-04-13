public enum Resource {
  WOOD, GLASS, STONE
}

public class Level extends Screen {
  private GameScreen gameScreen;
  private Difficulty difficulty;
  private int budget;
  private ArrayList<Ground> groundList;
  private ArrayList<Pig> pigList;
  private ArrayList<Bird> birdBackStageList;
  private ArrayList<Bird> birdFrontStageList;
  private ArrayList<Material> materialList;
  private Material draggedMaterial;
  private World w;
  private boolean ready;
  private Timer timer;
  
  private PImage bgImage,emptyButtonImage,readyImage;
  private ImageButton woodButton, glassButton,stoneButton,readyButton,undoButton;
  private ArrayList<ImageButton> buttons;
  
  
  public Level(GameScreen gameScreen, JSONArray levelContents){
    this.gameScreen = gameScreen;
    this.difficulty = gameScreen.getPlayer().getDifficulty();
    budget = 0;
    groundList = new ArrayList<>();
    pigList = new ArrayList<>();
    birdBackStageList = new ArrayList<>();
    birdFrontStageList = new ArrayList<>();
    materialList = new ArrayList<>();
    
    bgImage = gameImages.get("map");
    emptyButtonImage = gameImages.get("emptyButton");
    readyImage = gameImages.get("readyButton");
    
    for (int i = 0; i < levelContents.size(); i++) {
      JSONObject levelContent = levelContents.getJSONObject(i); 
      String type = levelContent.getString("type");
      if(type.equals("Budget"))       setBudget(levelContent);
      else if(type.equals("Ground"))  addGround(levelContent);
      else if(type.contains("Pig"))   addPig(levelContent);
      else if(type.contains("Bird"))  addBirdBackStage(levelContent);
    }
    setupWorld();
    setButtons();
  }
  
  
  public void display() {
    image(bgImage, width/2, height/2, width, height);
    
    if(!ready){
      for (ImageButton button : buttons) {
        button.update(); 
        button.display(); 
      }
      for(int i=0; i<10; i++) {
        w.collideBodies();
      }
    }
    else {
      for(int i=0; i<10; i++) {
        w.step(1/frameRate/10);
        w.collideBodies();
      }
      checkWorldItemActions();
      timerActions();
    }
    w.display();
    textDisplay();
  }
  
  public void mousePressed(){
    if(!ready){
      //drag materials
      for (Material material : materialList) {
        if (material.isMouseOver(mouseX, mouseY)) {
          draggedMaterial = material;
          return;
        }
      }
      //add wood
      PVector newPosition = new PVector(random(width/10,width/3), random(height/3,5*height/9));
      if(woodButton.clicked()){
        if(buyResource(Resource.WOOD)){
          Wood newWood = new Wood(newPosition, 0.5, 0.3, false, 50, 200,0);
          materialList.add(newWood);
          w.addBody(newWood);
        }
      }
      //add glass
      if(glassButton.clicked()){
        if(buyResource(Resource.GLASS)){
          Glass newGlass = new Glass(newPosition, 0.5, 0.8, false, 50, 200,0);
          materialList.add(newGlass);
          w.addBody(newGlass);
        }
      }
      //add stone
      if(stoneButton.clicked()){
        if(buyResource(Resource.STONE)){
          Stone newStone = new Stone(newPosition, 0.5, 0.3, false, 50, 200,0);
          materialList.add(newStone);
          w.addBody(newStone);
        }
      }
      //undo buy material
      if(undoButton.clicked()){
        if(!materialList.isEmpty()){
          Material lastMaterial = materialList.get(materialList.size() - 1);
          if(sellResource(lastMaterial)){
            w.removeBody(lastMaterial);
            materialList.remove(materialList.size()-1);
          }
        }
      }
      if(readyButton.clicked()){
        zeroImpulses();
        for(Pig pig:pigList) {
          pig.setStatic(false);
        }
        ready=true;
      }
    }
  }
  
  public void keyPressed(){
    if (draggedMaterial != null && key=='D') {  
       draggedMaterial.setRotation(draggedMaterial.getRotation() + PI / 18);
    }
    if (draggedMaterial != null && key=='A') {  
      draggedMaterial.setRotation(draggedMaterial.getRotation() - PI / 18); 
    }
  }
  
  public void mouseDragged(){
    if (draggedMaterial != null) {
      draggedMaterial.position.set(mouseX, mouseY);
    }
  }
  
  public void mouseReleased(){
    draggedMaterial = null;
  }
  
  private void setBudget(JSONObject levelContent){
    this.budget = levelContent.getInt("amount");
  }
  
  public int getBudget() {
    return budget;
  }
  
  private void addGround(JSONObject levelContent) {
    float positionX = levelContent.getFloat("positionX") * width;
    float positionY = levelContent.getFloat("positionY") * height;
    PVector position = new PVector(positionX, positionY);
    float groundWidth = levelContent.getFloat("width") * width;
    float groundHeight = levelContent.getFloat("height") * height;
    float groundRotation = levelContent.getFloat("rotation");
    Ground ground = new Ground(position, groundWidth, groundHeight, groundRotation);
    groundList.add(ground);
  }
  
  private void addPig(JSONObject levelContent) {
    float positionX = levelContent.getFloat("positionX") * width;
    float positionY = levelContent.getFloat("positionY") * height;
    PVector position = new PVector(positionX, positionY);
    Pig pig = new Pig(position);
    pig.setStatic(true);
    pigList.add(pig);
  }
  
  private void addBirdBackStage(JSONObject levelContent) {
    float positionX, positionY, velocityX, velocityY;
    PVector position = new PVector(), linearVelocity = new PVector();
    if(difficulty == Difficulty.EASY) {
      positionX = levelContent.getFloat("positionX") * width;
      positionY = levelContent.getFloat("positionY") * height;
      position.set(positionX, positionY);
      velocityX = levelContent.getFloat("velocityX");
      velocityY = levelContent.getFloat("velocityY");
      linearVelocity.set(velocityX, velocityY);
    }
    else {
      float randNum = random(0.1, 0.9);
      positionX = randNum * width;
      positionY = 0.1 * height;
      position.set(positionX, positionY);
      velocityX = (0.5 - randNum) * 2500;
      velocityY = 1000;
      linearVelocity.set(velocityX, velocityY);
    }
    
    String type = levelContent.getString("type");
    Bird bird = new BirdRed(position);
    switch(type) {
      case "BirdBlue" : bird = new BirdBlue(position); break;
      case "BirdBlack" : bird = new BirdBlack(position); break;
    }
    bird.setLinearVelocity(linearVelocity);
    birdBackStageList.add(bird);
  }
  
  private void setupWorld() {
    w = new World();
    for(Ground ground:groundList) {
      w.addBody(ground);
    }
    for(Pig pig:pigList) {
      w.addBody(pig);
    }
    for(Bird bird:birdFrontStageList) {
      w.addBody(bird);
    }
    for(Material material:materialList) {
      w.addBody(material);
    }
  }
  
  private void checkWorldItemActions() {
    for(RigidBody body:w.getBodyList()) {
      if(body instanceof Pig) {
        //print(animal.getLargestImpulse()+"\n");
        Pig pig = (Pig) body;
        if(pig.getLargestImpulse() > pig.getImpulseToughness()) {
          pig.killPig();
        }
      }
      if(body instanceof BirdRed) {
        BirdRed birdRed = (BirdRed) body;
        if(birdRed.getLargestImpulse() > birdRed.getImpulseToughness()) {
          birdFrontStageList.remove(birdRed);
          setupWorld();
        }
      }
      if(body instanceof BirdBlue) {
        BirdBlue birdBlue = (BirdBlue) body;
        RigidBody contactBody = birdBlue.getLastContactBody();
        if(birdBlue.hasAbility() && contactBody!=null && !contactBody.isStatic()) {
          birdBlue.reverseGravity(w.getGravity());
          if(contactBody instanceof Pig) {
            Pig pig = (Pig) contactBody;
            pig.killPig();
          }
        }
        if(birdBlue.getLargestImpulse() > birdBlue.getImpulseToughness()) {
          birdFrontStageList.remove(birdBlue);
          setupWorld();
        }
      }
      if(body instanceof BirdBlack) {
        if(body.getLastContactBody() != null) {
          BirdBlack birdBlack = (BirdBlack) body;
          birdBlack.explode(w);
          birdFrontStageList.remove(birdBlack);
          setupWorld();
        }
      }
      if(body instanceof Material) {
        Material material = (Material) body;
        if(material.getLargestImpulse() > material.getImpulseToughness()) {
          materialList.remove(material);
          setupWorld();
        }
      }
    }
  }
  
  private void timerActions(){
    if(timer == null || timer.intervalFinished()) {
      if(birdBackStageList.isEmpty() || numberPigsAlive() == 0) {
        gameScreen.endLevel();
      }
      else {
        stageBird();
        setTimer();
      }
    }
  }
  
  private void setTimer(){
    if(birdBackStageList.isEmpty()) {
      timer = new Timer(5000);
    }
    else {
      timer = new Timer(1000);
    }
  }
  
  private void stageBird() {
    Bird bird = birdBackStageList.get(0);
    birdBackStageList.remove(0);
    birdFrontStageList.add(bird);
    w.addBody(bird);
  }
  
  private void zeroImpulses() {
    for(RigidBody body:w.getBodyList()) {
      body.setLargestImpulse(0);
    }
  }
  
  private boolean buyResource(Resource material){
    if(material == Resource.GLASS){
      if(budget >= 50){
        budget = budget - 50;
        return true;
      }
    }
    if(material == Resource.WOOD){
      if(budget >= 100){
        budget = budget - 100;
        return true;
      }
    }
    if(material == Resource.STONE){
      if(budget >= 150){
        budget = budget - 150;
        return true;
      }
    }
    return false;
  }

  public boolean sellResource(Material material){
    if (material instanceof Glass){
      budget += 50;
    }
    else if (material instanceof Wood){
      budget += 100;
    }
    else if (material instanceof Stone){
      budget += 150;
    }
    else {
      return false;
    }
    return true;
  }
  
  private void textDisplay(){
     fill(0, 0, 0);
     textSize(40);
     text("Budget: " + str(budget), width-width/5,height/10);
  }  
  
  public int numberPigsAlive(){
    int alivePigs = 0;
    for(Pig pig:pigList){
       if(pig.isAlive()){
         alivePigs ++; 
       }
    }
    return alivePigs;
  }
  
  public int numberPigsTotal() {
    return pigList.size();
  }
  
  private void setButtons(){
    buttons = new ArrayList<ImageButton>();
    //glass
    glassButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f-1/10f),width/10,height/20);
    buttons.add(glassButton);
    //wood
    woodButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f),width/10,height/20);
    buttons.add(woodButton);
    //stone
    stoneButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f+1/10f),width/10,height/20);
    buttons.add(stoneButton);
    //undo
    undoButton = new ImageButton(emptyButtonImage, width/20 + 10,height*(1/2f+3/10f),width/10,height/20);
    buttons.add(undoButton);
    //ready
    readyImage = gameImages.get("readyButton");
    readyButton = new ImageButton(readyImage, width/2, height/10,width/5,height/10);
    buttons.add(readyButton);
  }
}

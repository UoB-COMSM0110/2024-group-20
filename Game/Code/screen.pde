// This line is to test if deletion of a merged branch will or will not delete its history in github. Turns out its history will be added to the merged branch.
// This line is to extend the above test but with two branches working in parallel instead of one. This is the first line added by one of the branches.
// This line is added by test branch one.
PImage gameLogo;
PImage startImage;
PImage scoreImage;
PImage exitImage;
PImage menuImage;
PImage readyImage;
PImage emptyButtonImage;
PImage bgImage;

Material draggedMaterial = null;
PImage woodBoardImage;

PFont font;

UserScore playerScore;
Tutorial tutorial;
ArrayList<Material> materials = new ArrayList<Material>(); // A list to keep track of all materials
Level allLevels[];

int screen = 0;
int firstLevel = 0;
int currentLevel = 0;

void setup (){
  playerScore = new UserScore();
  tutorial = new Tutorial();
  font = createFont("angrybirds-regular.ttf", 128);
  
  allLevels = new Level[3];
  allLevels[0] = new Level(200, 1, 3, 0, 0);
  allLevels[1] = new Level(150, 2, 3, 3, 0);
  allLevels[2] = new Level(100, 3, 3, 3, 3);
  fullScreen();  
}

void draw (){
  //start screen
  if(screen == 0){
    playerScore.deletePlayer();
    // HAVE TO RESET LEVEL VALUES
    currentLevel = 0;
    startScreen();
  }
  //scoreScreen
  if (screen == 1){
    scoreScreen();
  }
  //gameScreen
  if (screen == 2){
    preGameScreen();
    // Player being able to enter his name
    if(playerScore.getNoLetters() < 10){
      playerScore.enterPlayerName();
    }else{
      gameScreen();
      //score Display
      playerScore.printCurrentPlayerScore();
      //budget
      allLevels[currentLevel].printLevelBudget();
      //tutorial.update();
      textAlign(LEFT);
      tutorial.display();
    }
    //draw all the materials 
    for (Material material : materials) {
      material.draw(g); 
    }
  }
  if(screen == 3){
    winScreen(); 
  }
  if(screen == 4){
    looseScreen(); 
  }
}

void startScreen(){
  imagesStartScreen();
}

void scoreScreen(){
  imagesScoreScreen();
}

void gameScreen() {
  imagesGameScreen();
  allLevels[currentLevel].printAllPigs();
  allLevels[currentLevel].printAllBirds();
}

void winScreen(){
  imagesWinScreen(); 
}

void looseScreen(){
  imagesLooseScreen(); 
}

void preGameScreen() {
  imagesPreGameScreen();
}
//////////////////////////////////////////////////////////////////////////
void mousePressed(){
   //handle start screen
  if(screen == 0){
    // check whether click start
    if (mouseX <= width/2 + width/10 && mouseX >= width/2 - width/10){
      if (mouseY <= height/2 +height/20 && mouseY >= height/2 - height/20){
        screen = 2;
      }
    }
    //check score button
    if (mouseX <= width/2 + width/10 && mouseX >= width/2 - width/10){
      if (mouseY <= height/2 +height/20 + height/7 && mouseY >= height/2 - height/20 + height/7 ){
        screen = 1;
      }
    }
    // check exit
     if (mouseX <= width/2 + width/10 && mouseX >= width/2 - width/10){
      if (mouseY <= height/2 +height/20 + 2*height/7 && mouseY >= height/2 - height/20 + 2* height/7){
        exit();
      }
    }
  }
  //handle scoreScreen
  if (screen == 1){
    if (mouseX >= width - width/5 && mouseX <= width){
      if (mouseY <= height && mouseY >= height - height/10){
        screen = 0;
      }
    }
  }
  // handle gameScreen
  if (screen == 2){
    if (mouseX >= width - width/5 && mouseX <= width){
      if (mouseY <= height && mouseY >= height - height/10){
        screen = 0;
      }
    }
    tutorial.mousePressed();
    //add glass
  for (Material material : materials) {
    if (material.isMouseOver(mouseX, mouseY)) {
      draggedMaterial = material;
      break;
    }
  }

    if (mouseX >= 0 && mouseX <= width/10){
      PVector newPosition = new PVector(random(0,width/3), random(2*height/3,height));
      if (mouseY <= height/3+height/20 && mouseY >= height/3 ){
        materials.add(new Glass(newPosition, 0.5, 0.3, false, 50, 200));
      }
    //add wood
      if (mouseY <= 4*height/9+height/20 && mouseY >= 4*height/9){
        materials.add(new Wood(newPosition, 0.5, 0.3, false, 50, 200));
      }
    //add stone
      if (mouseY <= 5*height/9+height/20 && mouseY >= 5*height/9){
        materials.add(new Stone(newPosition, 0.5, 0.3, false, 50, 200));
      }
    }
    //Are you ready?
    if (mouseX >= width/2 - width/10 && mouseX <= width/2+width/10){
      if (mouseY <= height/9+height/10 && mouseY >= height/9){
        allLevels[currentLevel].readyWithStructure();
      }
    }
  }
  // Win Screen
  if(screen == 3){
    //Go back to Main Menu
    if (mouseX <= width/2 + width/10 && mouseX >= width/2 - width/10){
      if (mouseY <= height/2 +height/20 + height/7 && mouseY >= height/2 - height/20 + height/7 ){
        screen = 0;
      }
    } 
  }
  // Loose Screen
  if(screen == 4){
    //Go back to Main Menu
    if (mouseX <= width/2 + width/10 && mouseX >= width/2 - width/10){
      if (mouseY <= height/2 +height/20 + height/7 && mouseY >= height/2 - height/20 + height/7 ){
        screen = 0;
      }
    } 
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

void keyPressed(){
  // Key Detection for entering the name of the player
  if(playerScore.getNoLetters() < 10 && screen == 2){
    playerScore.pressedKey(key);
  }
  if(screen == 2){
    print("1");
   if(key == '['){
     if(currentLevel < 2){
        //Calculating points
        currentLevel++;
     }else{
       screen = 3; 
     }
   }
   if(key == ']'){
       screen = 4;
    }
    if ((key == 'd' ||key=='D') && draggedMaterial != null) {
      
    draggedMaterial.rotate(PI / 36); // Rotate by 10 degrees
  }
  if ((key == 'a'||key == 'A' ) && draggedMaterial != null) {
    draggedMaterial.rotate(-PI / 18); 
  }
   }
}
//////////////////////////////////////////////////////////////////////////
void imagesScoreScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  // Board to display scores on 
  woodBoardImage = loadImage("../Images/woodBoard.png");
  image(woodBoardImage, width/5, height/10, width - 2 * width/5, height - height/5);
  
  // return button
  menuImage = loadImage("../Images/menuButton.png");
  image(menuImage, width - width/5,height - height/10,width/5,height/10);
  
  // printing scores from a text file
  playerScore.printScoresFile();
}

void imagesPreGameScreen(){
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
}

void imagesGameScreen(){
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  //return button
  menuImage = loadImage("../Images/menuButton.png");
  image(menuImage, width - width/5,height - height/10,width/5,height/10);
  
  //add wood 
  emptyButtonImage = loadImage("../Images/emptyButton.png");
  image(emptyButtonImage, 0,height/3,width/10,height/20);
  
  //add glass
  emptyButtonImage = loadImage("../Images/emptyButton.png");
  image(emptyButtonImage, 0,4*height/9,width/10,height/20);
  
  //add stone
  emptyButtonImage = loadImage("../Images/emptyButton.png");
  image(emptyButtonImage, 0,5*height/9,width/10,height/20);
  
  //Ready?
  readyImage = loadImage("../Images/readyButton.png");
  image(readyImage, width/2-width/10,height/9,width/5,height/10);
}

void imagesStartScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  // logo on screen
  startImage = loadImage("../Images/AnxiousPigsLogo.png");
  image(startImage, width/2 - width/6,height/2 - height/6 - height/4,width/3,height/3);

  //start button
  startImage = loadImage("../Images/startButton.png");
  image(startImage, width/2 - width/10,height/2 - height/20,width/5,height/10);

  //score button
  scoreImage = loadImage("../Images/scoreButton.png");
  image(scoreImage, width/2 - width/10,height/2 - height/20 + height/7,width/5,height/10);

  //exit
  exitImage = loadImage("../Images/exitButton.png");
  image(exitImage, width/2 - width/10,height/2 - height/20 + 2*height/7,width/5,height/10);
}

void imagesWinScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  // win text
  fill(0,0,0);
  textFont(font);
  text("You WON!!!", width/2, height/3);
  playerScore.printFinalScore();

  //score button
  startImage = loadImage("../Images/menuButton.png");
  image(startImage, width/2 - width/10,height/2 - height/20 + height/7,width/5,height/10);
}

void imagesLooseScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  // win text
  fill(0,0,0);
  textFont(font);
  text("You LOST!!!", width/2, height/3);
  playerScore.printFinalScore();
  
  //score button
  startImage = loadImage("../Images/menuButton.png");
  image(startImage, width/2 - width/10,height/2 - height/20 + height/7,width/5,height/10);
}

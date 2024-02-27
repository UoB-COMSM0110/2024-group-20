PImage gameLogo;
PImage startImage;
PImage scoreImage;
PImage exitImage;
PImage menuImage;
PImage emptyButtonImage;
PImage bgImage;

UserScore playerScore;
Tutorial tutorial;


int screen = 0;
int firstLevel = 0;
int NOLETTERSNAME = 10;

void setup (){
  playerScore = new UserScore();
  tutorial = new Tutorial();
  fullScreen();  
}

void draw (){
  //start screen
  if(screen == 0){
    startScreen();
  }
  //scoreScreen
  if (screen == 1){
    scoreScreen();
  }
  //gameScreen
  if (screen == 2){
    gameScreen();
    //tutorial.update();
    tutorial.display();
  }
}

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
    //Are you ready?
    if (mouseX >= width/2 - width/10 && mouseX <= width/2+width/10){
      if (mouseY <= height/9+height/10 && mouseY >= height/9){
        screen = 0;
      }
    }
  }
}

void startScreen(){
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

void scoreScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  fill(139,69,19);
  rect(width/5, height/10, width - 2 * width/5, height - height/5);
  //return button
  menuImage = loadImage("../Images/menuButton.png");
  image(menuImage, width - width/5,height - height/10,width/5,height/10);
  // printing scores from a text file
  playerScore.printScoresFile();
}

void gameScreen() {
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
  emptyButtonImage = loadImage("../Images/emptyButton.png");
  image(emptyButtonImage, width/2-width/10,height/9,width/5,height/10);

  //budget
  emptyButtonImage = loadImage("../Images/emptyButton.png");
  image(emptyButtonImage, width-width/10,height/20+height/15,width/10,height/15);
  
  // Player being able to enter his name
  if(firstLevel == 0){
    playerName();
  }else{
    playerScore.setToFinalName();
    //score
    playerScore.printCurrentPlayerScore();
  }
}

// Displaying the text when the player is entering their name
void playerName(){
  fill(0 ,0, 0);
  textSize(50);
  text("Enter your name:", width/2, height/3);
  textAlign(CENTER);
  
  playerScore.printTempName();    
  
  // Switching flag when name is entered
  if(playerScore.getNoLetters() >= NOLETTERSNAME){
   firstLevel = 1; 
  }
}

void keyPressed(){
  // Key Detection for entering the name of the player
  if(firstLevel == 0 && screen == 2){
    if(key == 'a' || key == 'A'){
     playerScore.addLetter('A'); 
    }else if(key == 'b' || key == 'B'){
     playerScore.addLetter('B');
    }else if(key == 'c' || key == 'C'){
     playerScore.addLetter('C');
    }else if(key == 'd' || key == 'D'){
     playerScore.addLetter('D');
    }else if(key == 'e' || key == 'E'){
     playerScore.addLetter('E');
    }else if(key == 'f' || key == 'F'){
     playerScore.addLetter('F');
    }else if(key == 'g' || key == 'G'){
     playerScore.addLetter('G');
    }else if(key == 'h' || key == 'H'){
     playerScore.addLetter('H');
    }else if(key == 'i' || key == 'I'){
     playerScore.addLetter('I');
    }else if(key == 'j' || key == 'J'){
     playerScore.addLetter('J');
    }else if(key == 'k' || key == 'K'){
     playerScore.addLetter('K');
    }else if(key == 'l' || key == 'L'){
     playerScore.addLetter('L');
    }else if(key == 'm' || key == 'M'){
     playerScore.addLetter('M');
    }else if(key == 'n' || key == 'N'){
     playerScore.addLetter('N');
    }else if(key == 'o' || key == 'O'){
     playerScore.addLetter('O');
    }else if(key == 'p' || key == 'P'){
     playerScore.addLetter('P');
    }else if(key == 'q' || key == 'Q'){
     playerScore.addLetter('Q');
    }else if(key == 'r' || key == 'R'){
     playerScore.addLetter('R');
    }else if(key == 's' || key == 'S'){
     playerScore.addLetter('S');
    }else if(key == 't' || key == 'T'){
     playerScore.addLetter('T');
    }else if(key == 'u' || key == 'U'){
     playerScore.addLetter('U');
    }else if(key == 'v' || key == 'V'){
     playerScore.addLetter('V');
    }else if(key == 'w' || key == 'W'){
     playerScore.addLetter('W');
    }else if(key == 'y' || key == 'Y'){
     playerScore.addLetter('Y');
    }else if(key == 'z' || key == 'Z'){
     playerScore.addLetter('Z');
    }else if(key == BACKSPACE){
     playerScore.deleteLetter();
    }else if(key == ENTER){
     playerScore.noMoreLettes();
    }
    
  }
}


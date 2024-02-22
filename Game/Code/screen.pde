PImage gameLogo;
PImage startImage;
PImage scoreImage;
PImage exitImage;
PImage menuImage;
PImage bgImage;

Score playerScore;

int screen = 0;

void setup (){
  playerScore = new Score();
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
  startImage = loadImage("../Images/startButton.png");
  image(startImage, 0,height/3,width/10,height/20);
  //add glass
  startImage = loadImage("../Images/startButton.png");
  image(startImage, 0,4*height/9,width/10,height/20);
  //add stone
  startImage = loadImage("../Images/startButton.png");
  image(startImage, 0,5*height/9,width/10,height/20);
  //Ready?
  startImage = loadImage("../Images/startButton.png");
  image(startImage, width/2-width/10,height/9,width/5,height/10);
  //score
  playerScore.printCurrentPlayerScore();
  //budget
  startImage = loadImage("../Images/startButton.png");
  image(startImage, width-width/10,height/20+height/15,width/10,height/15);
}

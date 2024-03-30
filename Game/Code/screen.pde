abstract class Screen {
    abstract void display();
    abstract void mousePressed();
    abstract void keyPressed();
    abstract void mouseDragged();
}

/*
void draw (){
  //start screen
  if(screen == 0){
    playerScore.deletePlayer();
    currentLevel = 0;
    startScreen();
  }
  //gameScreen
  if (screen == 2){
    w.collideBodies();
    preGameScreen();
    // Player being able to enter his name
    if(playerScore.isNameUpdated() == false){
      playerScore.enterPlayerName();
    }else if(playerScore.getDifficulty() == Difficulty.NOTSET){
      difficultyScreen();
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
  }
}
//////////////////////////////////////////////////////////////////////////
void mousePressed(){
  if (screen == 2){
    // Return button
    ///// SHOULD IT WORK WHEN ENTERING THE NAME AND CHOOSING THE DIFFICULTY OF THE LEVEL?????
    if (mouseX >= width - width/5 && mouseX <= width){
      if (mouseY <= height && mouseY >= height - height/10){
        screen = 0;
      }
    }
    ///////////////////////////////////////////////////////////////////////////////////
    if(playerScore.getDifficulty() == Difficulty.NOTSET){
      //Easy
      if (mouseX >= width/4 && mouseX <= width/4 + width/5){
        if (mouseY <= height/2 && mouseY >= height/2  - height/10){
          playerScore.setDifficulty(Difficulty.EASY);
          setEasyLevels();
        }
      }  
      // Hard
      if (mouseX >= 3 * width/4 - width/5 && mouseX <= 3 * width/4){
        if (mouseY <= height/2 && mouseY >= height/2 - height/10){
          playerScore.setDifficulty(Difficulty.HARD);
          setHardLevels();
        }
      }   
    }
    
  }

}

void imagesDifficultyScreen(){
  // setting background
  bgImage = loadImage("../Images/map.png");
  image(bgImage, 0, 0, width, height);
  
  //Easy
  emptyButtonImage = loadImage("../Images/easyButton.png");
  image(emptyButtonImage, width/4,height/2  - height/10, width/5, height/10);
  
  // Hard
  emptyButtonImage = loadImage("../Images/hardButton.png");
  image(emptyButtonImage, 3 * width/4 - width/5, height/2 -height/10 , width/5, height/10);
  
}

private void setEasyLevels(){
    allLevels[0] = new Level(200, 1, 3, 0, 0, Difficulty.EASY);
    allLevels[1] = new Level(150, 2, 3, 3, 0, Difficulty.EASY);
    allLevels[2] = new Level(100, 3, 3, 3, 3, Difficulty.EASY);
}

private void setHardLevels(){
    allLevels[0] = new Level(200, 1, 3, 3, 0, Difficulty.HARD);
    allLevels[1] = new Level(150, 2, 3, 3, 3, Difficulty.HARD);
    allLevels[2] = new Level(100, 3, 0, 6, 6, Difficulty.HARD);
}
  }*/

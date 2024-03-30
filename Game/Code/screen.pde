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


  }*/

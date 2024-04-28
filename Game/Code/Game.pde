import processing.sound.*;
import java.io.*;

HashMap<String, PImage> gameImages;
HashMap<Difficulty, JSONArray[]> gameLevelData;
HashMap<String, SoundFile> gameAudios;
Table easyScoreTable,hardScoreTable;
ScreenManager screenManager;

void setup (){
  fullScreen(P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  textFont(createFont("angrybirds-regular.ttf", 128));

  loadImages();
  loadGameAudios();
  loadTableFile();
  loadLevelJSONArrays();
  screenManager = new ScreenManager();
}

void draw(){
  screenManager.display();
}

void mousePressed(){
  screenManager.mousePressed();
}

void keyPressed(KeyEvent event){
  screenManager.keyPressed();
}

void mouseDragged() {
  screenManager.mouseDragged();

}

void mouseReleased() {
  screenManager.mouseReleased();
}

void mouseWheel(MouseEvent event) {
  screenManager.mouseWheel(event);
}

void loadImages() {
  gameImages = new HashMap();
  File directoryPath = new File(sketchPath("../Images"));
  File fileList[] = directoryPath.listFiles();
  for(File file:fileList) {
    String fileName = file.getName();
    String imageName = fileName.replaceFirst("[.][^.]+$", "");
    String imagePath = "../Images/" + fileName;
    PImage image = loadImage(imagePath);
    gameImages.put(imageName, image);
  }
}

void loadGameAudios() {
  gameAudios = new HashMap();
  File directoryPath = new File(sketchPath("../Audios"));
  File fileList[] = directoryPath.listFiles();
  for(File file:fileList) {
    String fileName = file.getName();
    String audioName = fileName.replaceFirst("[.][^.]+$", "");
    String audioPath = "../Audios/" + fileName;
    SoundFile audioFile = new SoundFile(this, audioPath);
    gameAudios.put(audioName, audioFile);
  }
}

void loadLevelJSONArrays() {
  gameLevelData = new HashMap<>();
  // load easy levels
  File directoryPath = new File(sketchPath("../Levels/Easy"));
  File fileList[] = directoryPath.listFiles();
  JSONArray[] gameEasyLevelData = new JSONArray[fileList.length];
  for(File file:fileList) {
    String fileName = file.getName();
    String levelName = fileName.replaceFirst("[.][^.]+$", "");
    int levelNumber = Integer.valueOf(levelName);
    gameEasyLevelData[levelNumber] = loadJSONArray(file);
  }
  gameLevelData.put(Difficulty.EASY, gameEasyLevelData);
  // load hard levels
  directoryPath = new File(sketchPath("../Levels/Hard"));
  fileList = directoryPath.listFiles();
  JSONArray[]gameHardLevelData = new JSONArray[fileList.length];
  for(File file:fileList) {
    String fileName = file.getName();
    String levelName = fileName.replaceFirst("[.][^.]+$", "");
    int levelNumber = Integer.valueOf(levelName);
    gameHardLevelData[levelNumber] = loadJSONArray(file);
  }
  gameLevelData.put(Difficulty.HARD, gameHardLevelData);
}
  
 void loadTableFile(){
    (easyScoreTable = loadTable("easyScores.csv", "header")).setColumnType("Score", Table.INT);
    (hardScoreTable = loadTable("hardScores.csv", "header")).setColumnType("Score", Table.INT);
  }

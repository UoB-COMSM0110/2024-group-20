public class PlayerNameScreen extends Screen {
  ScreenManager screenManager;
  Player player;
  String displayName;
  PImage bgImage;
  
  public PlayerNameScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.bgImage = gameImages.get("map");
    updateDisplayName();
  }
  
  public void display(){
    image(bgImage, width/2, height/2, width, height);
    
    fill(0 ,0, 0);
    textSize(50);
    text("Enter your name:", width/2, height/3);
    text(displayName, width/2, height/2); 
  }
  
  public void keyPressed(){
    if(Character.isLetterOrDigit(key)) {
      addLetter(key);
    }
    if(key == BACKSPACE){
      deleteLetter();
    } 
    if(key == ENTER){
      screenManager.setCurrentScreen(ScreenType.DIFFICULTYSCREEN);
    } 
  }
  
  public void mousePressed(){}
  public void mouseReleased(){}
  public void mouseDragged(){}
  
  public void addLetter(char letter){
    String playerName = player.getPlayerName();
    if(playerName.length() < 10){
      String newName = playerName.concat(String.valueOf(letter));
      player.setPlayerName(newName);
      updateDisplayName();
    }
  }
  
  public void deleteLetter(){
    String playerName = player.getPlayerName();
    if(playerName.length() > 0){
      String newName = playerName.substring(0,playerName.length());
      player.setPlayerName(newName);
      updateDisplayName();
    }
  }
  
  private void updateDisplayName() {
    displayName = player.playerName.concat("_".repeat(10 - player.playerName.length()));
  }
}

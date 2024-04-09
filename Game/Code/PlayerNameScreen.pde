public class PlayerNameScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private String playerName;
  private String displayName;
  private PImage bgImage;
  
  public PlayerNameScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.playerName = player.getPlayerName();
    this.bgImage = gameImages.get("map");
    updateDisplayName();
  }
  
  public void display(){
    image(bgImage, width/2, height/2, width, height);
    
    fill(0 ,0, 0);
    textSize(50);
    text("Enter your name:", width/2, height/3);
    //updateDisplayName();
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
      player.setPlayerName(playerName);
      screenManager.setCurrentScreen(ScreenType.DIFFICULTYSCREEN);
    } 
  }
  
  public void mousePressed(){}
  public void mouseReleased(){}
  public void mouseDragged(){}
  
  public void addLetter(char letter){
    if(playerName.length() < 10){
      playerName = playerName.concat(String.valueOf(letter));
      updateDisplayName();
    }
  }
  
  public void deleteLetter(){
    if(playerName.length() > 0){
      playerName = playerName.substring(0,playerName.length()-1);
      updateDisplayName();
    }
  }
  
  private void updateDisplayName() {
    displayName = playerName.concat("_".repeat(10 - playerName.length()));
  }
}

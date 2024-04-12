public class PlayerNameScreen extends Screen {
  private ScreenManager screenManager;
  private Player player;
  private String displayName;
  private PImage bgImage;
  
  public PlayerNameScreen(ScreenManager screenManager) {
    this.screenManager = screenManager;
    this.player = screenManager.player;
    this.bgImage = gameImages.get("map");
  }
  
  public void display(){
    image(bgImage, width/2, height/2, width, height);
    
    fill(0 ,0, 0);
    textSize(50);
    text("Enter your name:", width/2, height/3);
    updateDisplayName();
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
      playerName = playerName.concat(String.valueOf(letter));
    }
    player.setPlayerName(playerName);
  }
  
  public void deleteLetter(){
    String playerName = player.getPlayerName();
    if(playerName.length() > 0){
      playerName = playerName.substring(0,playerName.length()-1);
    }
    player.setPlayerName(playerName);
  }
  
  private void updateDisplayName() {
    String playerName = player.getPlayerName();
    displayName = playerName.concat("_".repeat(10 - playerName.length()));
  }
}

public class Timer{
  private int startTime;
  private int interval;
 
  public Timer(int interval){
    this.interval = interval; 
    this.startTime = millis();
  }
  
  public boolean intervalFinished(){
    int elapsedTime = millis() - startTime;
    if(elapsedTime > interval){
      return true;
    }
    return false;
  }
  
  
}

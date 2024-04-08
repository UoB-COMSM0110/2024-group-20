class Timer{
  int startTime;
  int interval;
 
  Timer(int interval){
    this.interval = interval;  
  }
  
  public void startTimer(){
    startTime = millis();
  }
  
  public boolean intervalFinished(){
    int elapsedTime = millis() - startTime;
    if(elapsedTime > interval){
      return true;
    }
    return false;
  }
  
  
}

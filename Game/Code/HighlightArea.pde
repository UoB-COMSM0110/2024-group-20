public class HighlightArea{
    float x, y;//top-left coner
    float hWidth,hHeight;
    float screenWidth, screenHeight;
    public HighlightArea(float x, float y, float hWidth, float hHeight){
        this.x = x;
        this.y = y;
        this.hWidth = hWidth;
        this.hHeight = hHeight;
    }

    public void draw() {
        fill(0,0,0,150);
        rect(0,0,x+hWidth,y);
        rect(width,0,-width + (x+hWidth),hHeight + y);
        rect(width, height, -width+x, -height+(hHeight+y));
        rect(0,height,x,-height+y);
    }   
}
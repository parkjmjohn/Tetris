public class Point{
  private int Color;
  private int xpos;
  private int ypos;
  public int getColor(){
      return Color; 
  }
  public int getX(){
    return xpos; 
  }
  public int getY(){
    return ypos; 
  }
  public void setX(int val){
    xpos = val;
  }
  public void setY(int val){
    ypos = val;
  }
  public Point(int X,int Y){
    xpos = X;
    ypos = Y;
    Color = 0;
  }
  public Point(int X,int Y,int Col){
    xpos = X;
    ypos = Y;
    int count = 0;
    Color = Col;
  }
}
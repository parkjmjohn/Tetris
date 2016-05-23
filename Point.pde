public class Point{
  private int[] Color;
  private int xpos;
  private int ypos;
  public int[] getColor(){
      int[] col = new int[3];
      for (int i = 0;i<3;i++){
        col[i] = Color[i];
      }
      return col;
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
    Color = new int[0];
  }
  public Point(int X,int Y,int[] Colors){
    xpos = X;
    ypos = Y;
    int count = 2;
    Color = new int[3];
    while(count >= 0){
      Color[count] = Colors[count];
      count--;
    }
    print(Color[0]+" "+Color[1]+" "+Color[2]);
  }
}
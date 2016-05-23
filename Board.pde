public class Board implements Displayable{
  private int[] origin;
  private int Width;
  private int Height;
  ArrayList<Point> blocks;
  private int[] heights;
  public int[] getOrigin(){
     return origin; 
   }
  public void display(){
     fill(250);
     rect(origin[0],origin[1],15*Width,-15*Height);
     for(Point point : blocks){
       if(point != null){
          int[] col = new int[3];
          for (int i = 0;i<3;i++){
            col[i] = point.getColor()[i];
          }
          fill(col[0],col[1],col[2]);
          int bottom = origin[1] + point.getY()*-15;
          int left = origin[0] + point.getX()*15;
          //print("" + bottom + " " + left + " ");
          rect(left,bottom,15,-15); 
       }
     }
  }
  private Board(int x,int y,int wid,int hgt){
    origin = new int[2];
    origin[0] = x;
    origin[1] = y;
    Width = wid;
    Height = hgt;
    blocks = new ArrayList<Point>();
    heights = new int[10];
    
  }
  public void add(Piece L){
    int xpos = L.getOrigin()[0];
    int ypos = L.getOrigin()[1];
    for(Point point : L.blocks){
      int x = point.getX()*15 + xpos;
      int y = ypos - point.getY()*15;
      blocks.add(new Point(Math.abs(x-origin[0])/15,Math.abs(y-origin[1])/15,point.getColor()));
    }
  }
}

public void setup(){
  size(878,493);
  screen = 10;
  //bground = loadImage("bground.jpg");
  //image(bground,0,0);
  bground = loadImage("bground.jpg");
  minimbgroundmusic = new Minim(this);
  bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
  image(bground, 0, 0);  
  bgroundmusic.play();
  bgroundmusic.loop();
  L = randPiece();
  B1 = new Board(150,360,10,30);
}

public class Board implements Displayable{
  private int[] origin;
  private int Width;
  private int Height;
  Point[][] blocks;
  public int[] getOrigin(){
     return origin; 
   }
  public void display(){
     fill(250);
     rect(origin[0],origin[1],15*Width,-15*Height);
     for(int i =0; i<blocks.length;i++){
       for(int j = 0;j<blocks[0].length;j++){
         if(blocks[i][j] != null){
           //if(blocks[i][j].getColor()!=0){
           //   int[] col = new int[3];
            
           //   for (int b = 0;i<3;i++){
                //print(b + " " + i + " " + j + " ");
           //     print(blocks[i][j].getColor(b));
           //     col[b] = blocks[i][j].getColor(b);
           //    }
           //   fill(col[0],col[1],col[2]);
           //}else{
              fill(128);
            //  }
            //print(blocks[i][j].getX() + " " + blocks[i][j].getY() + " (" + i + ", " + j + ") ");
            int bottom = origin[1] + blocks[i][j].getY()*-15;
            int left = origin[0] + blocks[i][j].getX()*15;
            //print("" + bottom + " " + left + " ");
            rect(left,bottom,15,-15); 
         }
       }
     }
  }
  private Board(int x,int y,int wid,int hgt){
    origin = new int[2];
    origin[0] = x;
    origin[1] = y;
    Width = wid;
    Height = hgt;
    blocks = new Point[24][10];
    
  }
  public void add(Piece L){
    int xpos = L.getOrigin()[0];
    int ypos = L.getOrigin()[1];
    for(Point point : L.blocks){
      int x = point.getX()*15 + xpos;
      int y = ypos - point.getY()*15;
      int[] Colors = new int[3];
      for(int count = 0; count<3;count++){
        Colors[count] = point.getColor(count);
      }
      x = Math.abs(x-origin[0])/15;
      y = Math.abs(y-origin[1])/15;
      blocks[y][x] = new Point(x,y,Colors);
    }
  }
}
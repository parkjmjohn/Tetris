public void setup(){
  size(878, 493);
  screen = 0;
  scorecounter = 0;
  lineclear = 0;
  howmany = 0;
  level = 0;
  minimclearline = new Minim(this);
  minimgameover = new Minim(this);
  minimrotate = new Minim(this);
  minimscore = new Minim(this);
  minimselect = new Minim(this);
  minimhowtoplay = new Minim(this);
  minimcreds = new Minim(this);
  minimdrop = new Minim(this);
  drop = minimdrop.loadFile("drop.mp3");
  clearline = minimclearline.loadFile("clearline.mp3");
  gameover = minimgameover.loadFile("gameover.mp3");
  rotate = minimrotate.loadFile("rotate.mp3");
  score = minimscore.loadFile("score.mp3");
  select = minimselect.loadFile("select.mp3");
  howtoplay = minimhowtoplay.loadFile("howtoplay.mp3");
  creds = minimcreds.loadFile("creds.mp3");
  font = loadFont("GillSansMT-Italic-48.vlw");
  textFont(font,48);
  L = randPiece();
  B1 = new Board(300,360,10,30);
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
           Point point = blocks[i][j];
           //int[] colBlock = point.getColor();
           //if(!colBlock.equals(new int[0]) && colBlock.length != 0){
              //int[] blah = new int[3];
           
              //for (int b = 0;i<3;i++){
              //  if(b < colBlock.length){
              //    blah[b] = colBlock[b];
              //  }else{
              //    blah[b] = 128;
              //  }
              //}
           //}
 //             /*
              //fill(col[0],col[1],col[2]);
            //}else{*/
              fill(point.getColor());
            //}
            //print(blocks[i][j].getX() + " " + blocks[i][j].getY() + " (" + i + ", " + j + ") ");
            int bottom = origin[1] + point.getY()*-15;
            int left = origin[0] + point.getX()*15;
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
      int Color = point.getColor();
      x = Math.abs(x-origin[0])/15;
      y = Math.abs(y-origin[1])/15;
      blocks[y][x] = new Point(x,y,Color);
    }
  }
}
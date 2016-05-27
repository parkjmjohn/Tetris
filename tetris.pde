import ddf.minim.*;

//MUSIC
Minim minimbgroundmusic;
AudioPlayer bgroundmusic;

//PIMAGES
PImage bground;

Point[] N;
Point b,c,d,e;
Piece L, W;
Board B1;
int screen;



void draw(){
  if(screen == 0){
    menu();
  }else if(screen == 1){
    play();
  }
}
void menu(){
 bground = loadImage("bground.jpg");
 minimbgroundmusic = new Minim(this);
 bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
}
void play(){
  
  background(0);
  B1.display();
  L.display();
  L.gravitize();
  if(L.bottomReach+10>=B1.getOrigin()[1]){
    B1.add(L);
    checkRows();
    L = randPiece();
  }
  if(collision()){
    B1.add(L);
    checkRows();
    L = randPiece();
  }
}
void checkRows(){
  for(int r = 0;r<B1.blocks.length;r++){
    //print(r);
    while(fullRow(r)){
      //print(r);
      removeRow(r);
    } 
  }
}
void removeRow(int r){
  for(int row = r;row<B1.blocks.length-1;row++){
    for(int col = 0;col<B1.blocks[r].length;col++){
      if(B1.blocks[row+1][col]!=null){
        int x = B1.blocks[row+1][col].getX();
        int y = B1.blocks[row+1][col].getY();
        int[] a = new int[3];
        B1.blocks[row][col] = new Point(x,y-1,a);
      }else{
        B1.blocks[row][col] = null; 
      }
    }
  }
}
boolean fullRow(int r){
  print(B1.blocks.length + " " + B1.blocks[0].length);
  for(int c = 0;c<B1.blocks[0].length;c++){
    //print(r + " " + c + " ");
     if(B1.blocks[r][c]==null){
       
       return false; 
     }
  }
  return true;
}
void keyPressed(){
  screen = 1;
  if(key == 'w'){
    L.rotateLeft();
  //}else if(key == 'f'){
  //  L.rotateRight();
  }else if(key == 'a'){
    L.moveLeft(); 
  }else if(key == 'd'){
    L.moveRight(); 
  }else if(key == 's'){
    L.drop(); 
  }
  keepInBounds(L);
}

boolean collision(){
  for(int r = 0;r<B1.blocks.length;r++){
    for(int c = 0;c<B1.blocks[0].length;c++){
     if(B1.blocks[r][c]!= null){
       int top = (B1.blocks[r][c].getY()+1)*-15 + B1.getOrigin()[1];
       int left = B1.blocks[r][c].getX()*15 + B1.getOrigin()[0];
       for(int i =0; i<4;i++){
         int blockLeft = L.getOrigin()[0] + L.blocks[i].getX()*15;
         int blockBottom = L.getOrigin()[1] + L.blocks[i].getY()*-15;
         if(left == blockLeft && blockBottom+15 == top/*&& (blockBottom>top&&blockBottom-15<top)*/){
           L.moveUp(blockBottom - top);
           return true;
         }
       }
     }
    }
  }
  return false;
  
}
void keepInBounds(Piece piece){
  int leftBound = B1.getOrigin()[0];
  int rightBound = leftBound + 150;
  if(leftBound>=piece.leftReach){
    piece.moveRight(leftBound - piece.leftReach);
  }
  if(rightBound<=piece.rightReach){
    piece.moveLeft(piece.rightReach - rightBound); 
  }
}

void drop(){
  while(!(collision()||hitBottom())){
    //Move down until hits another piece or bottom of board
    L.gravitize();
  }
  B1.add(L);
  
  //Remove full rows
  checkRows();
  
  //Initialize new piece
  L = randPiece();
}
boolean hitBottom(){
  //Check if piece hits bottom of board
  return L.bottomReach+14>=B1.getOrigin()[1];
}

//Randomly creates a piece
Piece randPiece(){
  int rand = (int)(Math.random()*7);
  Piece next;
  if(rand == 0){
    next = createSquare();
  }else if(rand == 1){
    next = createL();
  }else if(rand == 2){
    next = createT();
  }else if(rand == 3){
    next = createZ();
  }else if(rand == 4){
    next = createbackwardsL();
  }else if(rand == 5){
    next = createbackwardZ();
  }else{
    next = createline();
  }
  return next;
}

//Creates a square piece
Piece createSquare(){
  //initiate color
  int[] Color = new int[3];
  Color[0] = 250;
  Color[1] = 250;
  Color[2] = 1;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,0,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks,225,50);
  return N;
}
Piece createL(){
  int[] Color = new int[3];
  Color[0] = 51;
  Color[1] = 112;
  Color[2] = 240;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(1,0,Color);
  Point P3 = new Point(2,0,Color);
  Point P4 = new Point(2,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

Piece createbackwardsL(){
  int[] Color = new int[3];
  Color[0] = 1;
  Color[1] = 250;
  Color[2] = 1;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(1,0,Color);
  Point P3 = new Point(2,0,Color);
  Point P4 = new Point(0,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

Piece createZ(){
  int[] Color = new int[3];
  Color[0] = 250;
  Color[1] = 1;
  Color[2] = 200;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,2,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,1,Color);
  Point P4 = new Point(1,0,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

Piece createbackwardZ(){
  int[] Color = new int[3];
  Color[0] = 100;
  Color[1] = 250;
  Color[2] = 213;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,1,Color);
  Point P4 = new Point(1,2,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

Piece createline(){
  int[] Color = new int[3];
  Color[0] = 184;
  Color[1] = 62;
  Color[2] = 203;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(0,3,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

Piece createT(){
  int[] Color = new int[3];
  Color[0] = 250;
  Color[1] = 1;
  Color[2] = 1;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 225, 50);
  return N;
}

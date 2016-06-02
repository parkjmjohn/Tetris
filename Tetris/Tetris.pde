import ddf.minim.*;

//MUSIC
Minim minimbgroundmusic, minimclearline, minimgameover, minimrotate, minimscore, minimselect, minimhowtoplay, minimcreds, minimdrop;
AudioPlayer bgroundmusic, clearline, gameover, rotate, score, select, howtoplay, creds, drop;

//PIMAGES
PImage bground;
Point[] N;
Point b,c,d,e;
Piece L, W;
Board B1;
int screen, scorecounter, lineclear, howmany, level;

//Font
PFont font;

void draw(){
  if(screen == 0){
    menu();
  }else if(screen == 1){
    play();
    fill(200);
    text(scorecounter, 10, 50);
    text(level+1, 10, 100);  
  }
}

void menu(){
  bground = loadImage("bground.jpg");
  minimbgroundmusic = new Minim(this);
  //bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
  image(bground, 0, 0);  
  //bgroundmusic.play();
  //bgroundmusic.loop();
}

void play(){
  //insert text
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
        int Color = B1.blocks[row+1][col].getColor();
        B1.blocks[row][col] = new Point(x,y-1,Color);
      }else{
        B1.blocks[row][col] = null; 
      }
    }
  }
  clearline.play();
  clearline.rewind();
  lineclear+=1;
  refreshscore();
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
    L.rotateRight();
    rotate.play();
    rotate.rewind();
  //}else if(key == 'f'){
  //  L.rotateRight();
  }else if(key == 'a'){
    L.moveLeft(); 
  }else if(key == 'd'){
    L.moveRight(); 
  }else if(key == 's'){
    drop(); 
    drop.play();
    drop.rewind();
  }
  keepInBounds(L);
}

boolean collision(){
  for(int r = 0;r<B1.blocks.length;r++){
    for(int c = 0;c<B1.blocks[0].length;c++){
     if(B1.blocks[r][c]!= null){
       int top = (int)((B1.blocks[r][c].getY()+1)*-15 + B1.getOrigin()[1]);
       int left = (int)(B1.blocks[r][c].getX()*15 + B1.getOrigin()[0]);
       for(int i =0; i<4;i++){
         int blockLeft = (int)(L.getOrigin()[0] + L.blocks[i].getX()*15);
         int blockBottom = (int)(L.getOrigin()[1] + L.blocks[i].getY()*-15);
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
  int leftBound = (int)(B1.getOrigin()[0]);
  int rightBound = (int)(leftBound + 150);
  if(leftBound>=piece.leftReach){
    piece.moveRight((int)(leftBound - piece.leftReach));
  }
  if(rightBound<=piece.rightReach){
    piece.moveLeft((int)(piece.rightReach - rightBound)); 
  }
}

//score
void refreshscore(){
 scorecounter=100*lineclear;
 level += lineclear/10;
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
  int Color = color(250,250,1);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,0,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks,375,50);
  return N;
}
Piece createL(){
  int Color = color(51,112,240);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(1,0,Color);
  Point P3 = new Point(2,0,Color);
  Point P4 = new Point(2,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

Piece createbackwardsL(){
  int Color = color(1,250,1);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(1,0,Color);
  Point P3 = new Point(2,0,Color);
  Point P4 = new Point(0,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

Piece createZ(){
  int Color = color(250,1,200);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,2,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,1,Color);
  Point P4 = new Point(1,0,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

Piece createbackwardZ(){
  int Color = color(100,250,213);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,1,Color);
  Point P4 = new Point(1,2,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

Piece createline(){
  int Color = color(184,62,203);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(0,3,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

Piece createT(){
  int Color = color(250,1,1);
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 375, 50);
  return N;
}

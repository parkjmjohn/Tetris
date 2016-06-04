import ddf.minim.*;

//MUSIC
Minim minimbgroundmusic, minimclearline, minimgameover, minimrotate, minimscore, minimselect, minimhowtoplay, minimcreds, minimdrop;
AudioPlayer bgroundmusic, clearline, gameover, rotate, score, select, howtoplay, creds, drop;

//PIMAGES
PImage bground, bgroundplay;
Point[] N;
Point b,c,d,e;
Piece L, W;
Board B1;
int screen, scorecounter, lineclear, howmany, level, show, atatime;

boolean squared;
PFont font;

public void setup(){
  size(878, 493);
  screen = 0;
  scorecounter = 0;
  lineclear = 0;
  howmany = 0;
  level = 0;
  boolean squared = false;
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
  //Menu Stuff
  bground = loadImage("bground.jpg");
  bgroundplay = loadImage("bgroundplay.jpg");
  minimbgroundmusic = new Minim(this);
  bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
  bgroundmusic.play();
  bgroundmusic.loop(3);
}

void draw(){
   if(mousePressed && screen==0){
    if(mouseX>387 && mouseX<483 && mouseY>278 && mouseY<338) {
      screen=1;
    }
  }
  if(mousePressed && screen==0){
    if(mouseX>256 && mouseX<361 && mouseY>353 && mouseY<447) {
      screen=2;
      bgroundmusic.pause();
      howtoplay.play();
      howtoplay.loop();
    }
  }
  if(mousePressed && screen==0){
    if(mouseX>517 && mouseX<625 && mouseY>353 && mouseY<447) {
      screen=3;
      bgroundmusic.pause();
      creds.play();
      creds.loop();
    }
  }
  if(screen == 0){
    menu();
  }else if(screen == 1){
    show = level + 1;
    play();
    fill(200);
    text("SCORE", 10, 50);
    text(scorecounter, 10, 100);
    text("LEVEL", 10, 175);
    text(show, 10, 225);  
  }
}

void menu(){
 image(bground, 0, 0);  
}

void play(){
  //insert text
  background(0);
  image(bgroundplay, 0, 0);
  B1.display();
  L.display();
  if(key != 'p'||key == 'P'){
    L.gravitize();
    if(show%3==0){
      howtoplay.pause();
      bgroundmusic.play();
      //bgroundmusic.loop();
    }
    if(show%3==1){
      bgroundmusic.pause();
      creds.play();
      creds.loop();
    }
    if(show%3==2){
      creds.pause();
      howtoplay.play();
      //howtoplay.loop();
    }
  }
  else if (key=='p'){
    textSize(26); 
    fill(#FA1717);
    text("PAUSED", 334, 100);
    bgroundmusic.pause();
    creds.pause();
    howtoplay.pause();
    textSize(48); 
  }
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

void degratify(){
  
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
        atatime+=1;
      }else{
        B1.blocks[row][col] = null; 
      }
    }
    atatime=(atatime+1)/10;
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
  if(key == 'w' && screen == 1){
    if (!squared){
      L.rotateRight();
      rotate.play();
      rotate.rewind();
    }
  //}else if(key == 'f'){
  //  L.rotateRight();
  }else if(key == 'a' && screen == 1){
    L.moveLeft(); 
  }else if(key == 'd' && screen == 1){
    L.moveRight(); 
  }else if(key == 's' && screen == 1){
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
 System.out.println("JOHNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN" + atatime);
 if (atatime>=2){
   if (atatime==2){
      scorecounter+=100;
   }
   else if (atatime==3){
      scorecounter+=150;
   }
   else{
      scorecounter+=200;
   }
   atatime=0;
 }
 if (level>0) {
   scorecounter+=level*100;
 }
 scorecounter=100*lineclear;
 level = lineclear/10;
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
  int rand = 0;//(int)(Math.random()*7);
  Piece next;
  if(rand == 0){
    next = createSquare();
    squared = true;
  }else if(rand == 1){
    next = createL();
    squared = false;
  }else if(rand == 2){
    next = createT();
    squared = false;
  }else if(rand == 3){
    next = createZ();
    squared = false;
  }else if(rand == 4){
    next = createbackwardsL();
    squared = false;
  }else if(rand == 5){
    next = createbackwardZ();
     squared = false;
  }else{
    next = createline();
    squared = false;
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

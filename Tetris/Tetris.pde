import controlP5.*;
import ddf.minim.*;

//MUSIC
Minim minimhigh, minimbgroundmusic, minimclearline, minimgameover, minimrotate, minimscore, minimselect, minimhowtoplay, minimcreds, minimdrop;
AudioPlayer high, bgroundmusic, clearline, gameover, rotate, score, select, howtoplay, creds, drop;

//PIMAGES
PImage bground, bgroundplay;
Point[] N;
Point b,c,d,e;
Piece L, Next, Next2, Next3;
Board B1;
int screen, scorecounter, lineclear, howmany, level, show, atatime;

boolean squared, shower;
PFont font;

ControlP5 cp5;
String textValue = "";


public void setup(){
  size(878, 493);
  String[] textValue = loadStrings("data.txt");
  screen = -1;
  shower = true;
  font = loadFont("GillSansMT-Italic-48.vlw");
  cp5 = new ControlP5(this);
  shower();
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
  minimhigh = new Minim(this);
  high = minimhigh.loadFile("high.mp3");
  drop = minimdrop.loadFile("drop.mp3");
  clearline = minimclearline.loadFile("clearline.mp3");
  gameover = minimgameover.loadFile("gameover.mp3");
  rotate = minimrotate.loadFile("rotate.mp3");
  score = minimscore.loadFile("score.mp3");
  select = minimselect.loadFile("select.mp3");
  howtoplay = minimhowtoplay.loadFile("howtoplay.mp3");
  creds = minimcreds.loadFile("creds.mp3");
  textFont(font,48);
  L = randPiece(375,50);
  Next = randPiece(500,50);
  Next2 = randPiece(500,120);
  Next3 = randPiece(500,190);
  B1 = new Board(300,360,10,30);
  //Menu Stuff
  bground = loadImage("bground.jpg");
  bgroundplay = loadImage("bgroundplay.jpg");
  minimbgroundmusic = new Minim(this);
  bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
  bgroundmusic.play();
  bgroundmusic.loop();
  image(bgroundplay, 0, 0);
  fill(250);
  text("NEXT", 700, 460);
}

void shower(){
    cp5.addTextfield("USERNAME")
   .setPosition(320,170)
   .setSize(200,40)
   .setFont(createFont("GillSansMT-Italic",36))
   .setAutoClear(false)
   .setVisible(shower);
  if(shower){
    cp5.addBang("clear")
     .setPosition(540,170)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     .setVisible(shower);
  }
  if(!shower){
    cp5.addBang("clear")
     .setPosition(40,170)
     .setSize(80,40)
     //.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     .setVisible(shower);
  }
}

public void clear() {
  cp5.get(Textfield.class,"USERNAME").clear();
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
      image(bgroundplay, 0, 0);
      bgroundmusic.pause();
      howtoplay.play();
      howtoplay.loop();
      fill(200);
      textSize(72);
      text("W    =    ROTATE", 10, 80);
      text("S    =    DROP", 10, 160);
      text("A    =    LEFT", 10, 240);
      text("D    =    RIGHT", 10, 320);
      text("P    =    PAUSE", 10, 400);
      text("ANY KEY   =    UNPAUSE", 10, 480);
      textSize(48); 
      text("BACK", 700, 460);
    }
  }
  if(mousePressed && screen==0){
    if(mouseX>517 && mouseX<625 && mouseY>353 && mouseY<447) {
      screen=3;
      image(bgroundplay, 0, 0);
      fill(200);
      textSize(48); 
      text("Project Name: Tetris Friends", 10, 50);
      text("Team Name: Steph & Klay", 10, 130);
      text("GitHub: https://github.com/parkjmjohn/Tetris", 10, 210);
      text("APCS-2 Konstantinovich", 10, 290);
      text("Thankful for the music and pictures online", 10, 370);
      text("John Park & Michael Feinberg", 10, 450);
      text("BACK", 700, 460);
      bgroundmusic.pause(); 
      creds.play();
      creds.loop();
    }
  }
  if(mousePressed && screen==0){
    if(mouseX>381 && mouseX<500 && mouseY>346 && mouseY<453) {
      screen=6;
      image(bgroundplay, 0, 0);
      text("HIGHSCORES", 10, 50);
      fill(200);
      textSize(48); 
      text("BACK", 700, 460);
      bgroundmusic.pause(); 
      high.play();
      high.loop();
    }
  }
  if(mousePressed && (screen==3 || screen == 2 || screen == 6)){
    if(mouseX>700 && mouseX<800 && mouseY>425 && mouseY<460) {
      screen = 0;
      high.pause();
      howtoplay.pause();
      creds.pause();
      menu();
    }
  }
  if(mousePressed && (screen==-1)){
    if(mouseX>700 && mouseX<800 && mouseY>425 && mouseY<460) {
      screen = 0;
      if(cp5.get(Textfield.class,"USERNAME").getText() == ""){
        textValue += "ANONYMOUS";
      }
      textValue += cp5.get(Textfield.class,"USERNAME").getText();
      menu();
      System.out.println(textValue);
    }
  }
  if(mousePressed && screen==4){
   if(mouseX>347 && mouseX<401 && mouseY>129 && mouseY<156) {
     setup();
   }
 }
  if(screen == 0){
    menu();
  }
  if(screen==4){
    textSize(26); 
    fill(#12A063);
    text("PAUSED", 334, 100);
    text("QUIT", 348, 150);
    bgroundmusic.pause();
    creds.pause();
    howtoplay.pause();
    textSize(48); 
  }else if(screen == 1){
    
    //GAME OVER STUFF
    //String[] list = split(textValue, ' ');
    //saveStrings("data.txt", list);
    
    
    show = level + 1;
    play();
    fill(200);
    //text(scorecounter, 10, 50);
    //text(level+1, 10, 100); 
    /*if(level<=10){
      int rate = 50 + level * 5;
      frameRate(rate);
    }else{
      frameRate(110); 
    }*/
    text("SCORE", 10, 50);
    text(scorecounter, 10, 100);
    text("LEVEL", 10, 175);
    text(show, 10, 225);  
  }
}

void menu(){
 shower=false;
 shower();
 bgroundmusic.play();
// bgroundmusic.loop();
 image(bground, 0, 0);  
}

void updatePiece(){
  L = createPiece(375,50,Next.getType());
  Next = createPiece(500,50,Next2.getType());
  Next2 = createPiece(500,120,Next3.getType());
  Next3 = randPiece(500,190);
  if(L.getType().equals("square")){
    squared = true; 
  }else{
    squared = false; 
  }
  
}

void play(){
  //insert text
  if(level <= 10){
    int rate = 50 + level * 5;
    frameRate(rate);
    print(rate);
  }else{
    frameRate(110);
  }
  screen = 1;
  background(0);
  image(bgroundplay, 0, 0);
  B1.display();
  L.display();
  fill(255);
  rect(490,5,65,200);
  Next.display();
  Next2.display();
  Next3.display();
  if(key != 'p'){
    L.gravitize();
    if(show%3==0){
      howtoplay.pause();
      bgroundmusic.play();
      //bgroundmusic.loop();
    }
    if(show%3==1){
      bgroundmusic.pause();
      creds.play();
      //creds.loop();
    }
    if(show%3==2){
      creds.pause();
      howtoplay.play();
      //howtoplay.loop();
    }
  }
  else if (key=='p'){
    screen = 4;
  }
  if(L.bottomReach+10>=B1.getOrigin()[1]){
    B1.add(L);
    checkRows();
    updatePiece();
  }
  if(collision()){
    B1.add(L);
    checkRows();
    updatePiece();
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
  if(screen == 4){
    screen = 1; 
  }else if(key == 'w' && screen == 1){
    if (!squared){
      L.rotateRight();
      rotate.play();
      rotate.rewind();
    }
  //}else if(key == 'f'){
  //  L.rotateRight();
  /*}else if(key == 'a'){
    if(!collisionLeft()){
      L.moveLeft(); 
    }
  }else if(key == 'd'){
    if(!collisionRight()){
      L.moveRight(); 
    }
  }else if(key == 's'){
    
*/
  }else if(key == 'a' && screen == 1){
   if(!collisionLeft()){
      L.moveLeft(); 
    }
  }else if(key == 'd' && screen == 1){
    if(!collisionRight()){
      L.moveRight(); 
    }
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
boolean collisionLeft(){
  int xpos = L.getOrigin()[0];
  int ypos = L.getOrigin()[1];
  for(Point point : L.blocks){
    int x = point.getX()*15 + xpos;
    int y = ypos - point.getY()*15;
    x = Math.abs(x-B1.origin[0])/15;
    y = Math.abs(y-B1.origin[1])/15;
    if(y>=1){
      if (x==0 || B1.blocks[y][x-1] != null||B1.blocks[y-1][x-1]!=null){
        return true; 
      }
    }else{
      if(x==9 || B1.blocks[y][x-1] != null){
        return true; 
      }
    }
  }
  return false;
}
boolean collisionRight(){
  int xpos = L.getOrigin()[0];
  int ypos = L.getOrigin()[1];
  for(Point point : L.blocks){
    int x = point.getX()*15 + xpos;
    int y = ypos - point.getY()*15;
    x = Math.abs(x-B1.origin[0])/15;
    y = Math.abs(y-B1.origin[1])/15;
    if(y>=1){
      if (x==9 || B1.blocks[y][x+1] != null||B1.blocks[y-1][x+1]!=null){
        return true; 
      }
    }else{
      if(x==9 || B1.blocks[y][x+1] != null){
        return true; 
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
  updatePiece();
}


boolean hitBottom(){
  //Check if piece hits bottom of board
  return L.bottomReach+14>=B1.getOrigin()[1];
}

//void refreshselection(){
//    Integer[] arr = new Integer[7];
//    for (int i = 0; i < arr.length; i++) {
//        arr[i] = i;
//    }
//    Collections.shuffle(Arrays.asList(arr));
//    System.out.println(Arrays.toString(arr));
  
//}

//void removeselection(int value){
//  if 
//}
//Creates piece of type T
Piece createPiece(int x, int y, String type){
  Piece next;
  if(type == "square"){
    next = createSquare(x,y);
    //squared = true;
  }else if(type == "L"){
    next = createL(x,y);
    //squared = false;
  }else if(type == "T"){
    next = createT(x,y);
    //squared = false;
  }else if(type == "Z"){
    next = createZ(x,y);
    //squared = false;
  }else if(type == "backwardsL"){
    next = createbackwardsL(x,y);
    //squared = false;
  }else if(type == "backwardsZ"){
    next = createbackwardZ(x,y);
     //squared = false;
  }else{
    next = createline(x,y);
    //squared = false;
  }
  return next;
}
//Randomly creates a piece
Piece randPiece(int x, int y){
  int rand = (int)(Math.random() * 7);//selection[0];
  //removeselection(selection[0]);
  Piece next;
  if(rand == 0){
    next = createSquare(x,y);
    //squared = true;
  }else if(rand == 1){
    next = createL(x,y);
    squared = false;
  }else if(rand == 2){
    next = createT(x,y);
    //squared = false;
  }else if(rand == 3){
    next = createZ(x,y);
    //squared = false;
  }else if(rand == 4){
    next = createbackwardsL(x,y);
    //squared = false;
  }else if(rand == 5){
    next = createbackwardZ(x,y);
     //squared = false;
  }else{
    next = createline(x,y);
    //squared = false;
  }
  return next;
}


//Creates a square piece
Piece createSquare(int x, int y){
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
  Piece N = new Piece(blocks,x,y,"square");
  return N;
}

Piece createL(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"L");
  return N;
}

Piece createbackwardsL(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"backwardsL");
  return N;
}

Piece createZ(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"Z");
  return N;
}

Piece createbackwardZ(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"backwardsZ");
  return N;
}

Piece createline(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"line");
  return N;
}

Piece createT(int x, int y){
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
  Piece N = new Piece(blocks, x, y,"T");
  return N;
}

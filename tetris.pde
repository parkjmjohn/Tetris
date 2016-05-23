Point[] N;
Point b,c,d,e;
Piece L, W;
Board B1;
int screen;
PImage bground;


public void setup(){
  screen = 1;
  //bground = loadImage("bground.jpg");
  //image(bground,0,0);
  L = randPiece();
  B1 = new Board(150,400,10,30);
}

void draw(){
  if(screen == 0){
    menu();
  }else if(screen == 1){
     play();
  }
}
void menu(){
  
}
void play(){
  
  background(0);
  B1.display();
  L.display();
  L.gravitize();
  if(L.bottomReach>=B1.getOrigin()[1]){
    B1.add(L);
    L = randPiece();
  }
  collision();
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
void collision(){
  for(Point point : B1.blocks){
     int top = point.getY()*-15 + B1.getOrigin()[1];
     int left = point.getX()*15 + B1.getOrigin()[0];
     for(int i =0; i<4;i++){
       int blockLeft = L.getOrigin()[0] + L.blocks[i].getX()*15;
       int blockBottom = L.getOrigin()[1] + L.blocks[i].getY()*-15;
       if(left == blockLeft && (blockBottom>top&&blockBottom-15<top)){
         B1.add(L);
         L = randPiece();
       }
     }
  }
  
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
  Color[2] = 0;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(1,0,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks,150,100);
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
  Piece N = new Piece(blocks, 20, 20);
  return N;
}

Piece createbackwardsL(){
  int[] Color = new int[3];
  Color[0] = 0;
  Color[1] = 250;
  Color[2] = 0;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(1,0,Color);
  Point P3 = new Point(2,0,Color);
  Point P4 = new Point(0,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 20, 20);
  return N;
}

Piece createZ(){
  int[] Color = new int[3];
  Color[0] = 250;
  Color[1] = 0;
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
  Piece N = new Piece(blocks, 20, 20);
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
  Piece N = new Piece(blocks, 20, 20);
  return N;
}

Piece createline(){
  int[] Color = new int[3];
  Color[0] = 76;
  Color[1] = 0;
  Color[2] = 139;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(0,3,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 20, 20);
  return N;
}

Piece createT(){
  int[] Color = new int[3];
  Color[0] = 250;
  Color[1] = 0;
  Color[2] = 0;
  Point[] blocks = new Point[4];
  Point P1 = new Point(0,0,Color);
  Point P2 = new Point(0,1,Color);
  Point P3 = new Point(0,2,Color);
  Point P4 = new Point(1,1,Color);
  blocks[0] = P1;
  blocks[1] = P2;
  blocks[2] = P3;
  blocks[3] = P4;
  Piece N = new Piece(blocks, 20, 20);
  return N;
}
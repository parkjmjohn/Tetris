public class Piece implements Displayable{
   public Point[] blocks;
   private int[] origin;
   public int leftReach,rightReach,bottomReach;
   
   public int[] getOrigin(){
     return origin; 
   }
   public void changeReach(){
      int[] xvals = new int[4];
      int[] yvals = new int[4];
      for(int i = 0;i<4;i++){
        xvals[i] = blocks[i].getX(); 
        yvals[i] = blocks[i].getY();
      }
      leftReach = origin[0] + min(xvals)*15;
      rightReach = origin[0] + (max(xvals)+1)*15;
      bottomReach = origin[1] + min(yvals)*-15;
      
   }
   public void setOrigin(int x,int y){
     origin[0] = x;
     origin[1] = y;
   }  
   public Piece(Point[] points,int x, int y){
     origin = new int[2];
     origin[0] = x;
     origin[1] = y;
     blocks = new Point[points.length];
     for(int i = 0;i<points.length;i++){
       blocks[i]=points[i];
     }
     changeReach();
   }
   public void rotateLeft(){
     for(Point block : blocks){
       int currentX = block.getX();
       int currentY = block.getY();
       block.setX(-1 * currentY);
       block.setY(currentX);
     }
     changeReach();
   }
   public void rotateRight(){
      for(Point block : blocks){
       int currentX = block.getX();
       int currentY = block.getY();
       block.setY(-1 * currentX);
       block.setX(currentY);
     }
     changeReach();
   }
   public void moveLeft(){
     origin[0]-=15;
     changeReach();
   }
   public void moveRight(){
     origin[0]+=15; 
     changeReach();
   }
   public void moveRight(int val){
     origin[0]+=val;
     changeReach();
   }
   public void moveLeft(int val){
     origin[0]-=val; 
     changeReach();
   }
   public void gravitize(){
     setOrigin(origin[0],origin[1]+1);
     changeReach();
   }
   public void drop(){
     
   }
   public void display(){
     for(Point point : blocks){
        int[] col = new int[3];
        for (int i = 0;i<3;i++){
          col[i] = point.getColor()[i];
        }
        fill(col[0],col[1],col[2]);
        int bottom = origin[1] + point.getY()*-15;
        int left = origin[0] + point.getX()*15;
        //print("" + bottom + " " + left + " ");
        rect(left,bottom,15,15); 
     }
   }
   
}
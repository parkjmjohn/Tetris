public class Selection{
    int[] sel;
    int size;

    public Selection(){
        sel = new int[7];
        size=7;
        for (int i = 0; i<7; i++){
            sel[i]=i;
        }
    }

    public void refreshselection(){
        if (size==0){
            sel = new int[7];
            for (int i = 0; i<7; i++){
                sel[i]=i;
            }
        }
        else{int x = 0;}
    }


    public void remove(int value){
        int[] temp = new int[size-1];
        for (int i = 0; i < size-1; i++){
            if (sel[i]!=value){
                temp[i]=sel[i];
            }
        }
        sel = temp;
        size--;
    }

    public int returner(){
        refreshselection();
        int x = (int)(Math.random()*7);
        int temp = sel[x];
        remove(sel[x]);
        return temp;
    }

}

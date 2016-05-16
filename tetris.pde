//IMPORTATIONS
import ddf.minim.*;

//MUSIC
Minim minimbgroundmusic;
AudioPlayer bgroundmusic;

//PIMAGES
PImage bground;

//Directory
String loc;

void setup(){
 //initialize
 loc = "home";
 bground = loadImage("bground.jpg");
 minimbgroundmusic = new Minim(this);
 bgroundmusic = minimbgroundmusic.loadFile("bgroundmusic.mp3");
 
 //bground
 size(878,493);
 image(bground, 0, 0);  
 bgroundmusic.play();
 bgroundmusic.loop();
}

void draw(){
  //buttons
}

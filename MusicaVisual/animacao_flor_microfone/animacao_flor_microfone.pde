import ddf.minim.*;
Minim minim;
AudioInput in;
PImage[] quadros;
float frame;

void setup () {
  minim = new Minim (this);  
  in = minim.getLineIn(Minim.STEREO, 512);
  size (400, 400);
  quadros = new PImage[17];
  for (int i=0; i<17; i++) {
    quadros[i] = loadImage ("flor"+i+".jpg");
  }
  frame=0;
  imageMode(CENTER);
}

void draw () {
  println(abs(in.left.get(0)));
  scale (2, 2);
  image (quadros[(int)frame], 0, 100);
  frame = frame + abs(in.left.get(0));
  frame = frame - 0.3;
  if (frame>16) { 
    frame=16;
  } 
  else if (frame < 0) {
    frame = 0;
  }
}

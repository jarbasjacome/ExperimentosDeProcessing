PFont font;
void setup ()
{
  font = loadFont("TimesNewRomanPSMT-48.vlw");
  textFont(font, 30);
  size (400, 400);
  background(0);
  rect (10,10,380,380);
  fill (0);
}
void draw ()
{
}
void keyReleased()
{
  text(char(key), random(400), random(400));
}

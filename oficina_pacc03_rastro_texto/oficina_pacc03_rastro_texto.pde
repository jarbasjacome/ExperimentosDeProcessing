String s = "Um texto qualquer       ";
int i = 0;
int proximo = 0;
int intervalo = 5;

void setup ()
{
  size (600, 600);
  background (0);
  PFont font  = loadFont("Georgia-Bold-48.vlw");
  textFont(font, 20);
}

void draw()
{
  if (mousePressed)
  {
    if (i > proximo * intervalo)
    {
      smooth();
      textAlign(CENTER);
      fill(0);
      textSize(30);
      text(" " + s.charAt(proximo), mouseX, mouseY);
      fill(255);
      textSize(25);
      text(" " + s.charAt(proximo), mouseX, mouseY); 
      proximo++;
      if (proximo >= s.length())
      {
        proximo = 0;
        i = -intervalo;        
      }
    }
    i++;
  }
}

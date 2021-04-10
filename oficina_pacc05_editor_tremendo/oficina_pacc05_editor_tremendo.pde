String texto = ""; 
int posicaoY = 200;
void setup()
{
  size (400,400);
  background (0);
  PFont fonte = loadFont("ArialMT-48.vlw");
  textFont (fonte,48);
  textAlign(CENTER);
  fill(255,0,0);
}
void draw()
{
  String[] achouSobe = match(texto, "sobe");
  String[] achouDesce = match(texto, "desce");
  String[] achouTreme = match(texto, "treme");
  if (achouSobe != null)
  {
    posicaoY = posicaoY - 1;
  }
  if (achouDesce != null)
  {
    posicaoY = posicaoY + 1;
  }
  if (achouTreme != null)
  {
    posicaoY = posicaoY + (int) random(-5, 5);
  }
  background(0);
  text(texto, 200, posicaoY);
}
void keyReleased()
{
  texto = texto + key;
  if (key == BACKSPACE && texto.length()>1)
  {
    texto = texto.substring(0, texto.length()-2 );
  }
}

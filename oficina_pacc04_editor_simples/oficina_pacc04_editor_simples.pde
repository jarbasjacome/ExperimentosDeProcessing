String texto = ""; // declaracao e atribuicao de variavel
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

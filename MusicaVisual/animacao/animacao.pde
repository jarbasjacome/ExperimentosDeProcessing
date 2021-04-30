PImage[] fotos; //declaração de variável
float quadro;   //guarda o quadro atual que está sendo exibido.
void setup () //chamada apenas uma vez
{
  size(400,400);
  fotos = new PImage[17]; //atribuicao da variável fotos com um array
                          //de imagens
  for (int i=0; i<17; i++)
  {
    fotos[i] = loadImage("flor" + i + ".jpg"); //carrega cada quadro
  }
  imageMode(CENTER); //para desenhar a imagem centralizada 
  quadro = 0;        //começa do primeiro quadro.
}
void draw () //chamada a cada quadro
{
  quadro = quadro + 0.1;
  if (quadro > 16)
  {
    quadro = 0;
  }
  scale(2,2); // aumenta o tamanho da imagem para a flor
              // aparecer maior.
  image(fotos[int(quadro)], 0, 100); //exibe o quadro atual. Converte
                                     //quadro para int, pois o índice
                                     //do array tem que ser inteiro.
}

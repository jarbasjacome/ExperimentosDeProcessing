/**
 * Original feito em 2011 para essa apresentação:
 * Jabah Pureza & Os Lanternistas Viajantes - Taiwanese Flower- Juízo Final, Taipei, 2011
 * https://www.youtube.com/watch?v=aL7_bLKgNuE
 *
 * Mais infos:
 * https://www.academia.edu/34682509/M%C3%9ASICA_VISUAL_ALGORITMO_DE_ZARATUSTRA_E_FLOR_DE_ILHA_FORMOSA
 *
 * Versão para a oficina "Musica Visual Gerativa" SBCM 2021 com participantes Julio Guatimosim, Zimaldo Melo e Victor Valentim
 *
 * Oficineiras: Rute Maxsuelly, Jarbas Jácome, Violeta Garcia, Horhanna Almeida, Gustavo Tenório e Mavi Pugliese
 *
 */

import ddf.minim.*;

Minim minim;
AudioInput entradaDeSom;
int tamBuffer = 512;

float[] suavizado;

float[][] flores;

int numFlores = 50;

int florAtual = 0;

int largura = 1280;
int altura = 720;

int grossura = 2;

void setup()
{
  //  size(512, 200);
  fullScreen();
  largura = width;
  altura = height;

  minim = new Minim(this);

  // use the getLineIn method of the Minim object to get an AudioInput
  entradaDeSom = minim.getLineIn(Minim.STEREO, tamBuffer);

  suavizado = new float[entradaDeSom.bufferSize()];

  flores = new float[numFlores][entradaDeSom.bufferSize()];

  entradaDeSom.disableMonitoring();
}

void rastro() {
  colorMode(HSB);
  fill(0, 0, 0, 5);
  rect(0, 0, largura, altura);
}

void zaratustra () {
  int zarathustra=0; //peak of the mountain
  for (int i=0; i<entradaDeSom.left.size()/2; i++)
  {
    if (entradaDeSom.left.get(zarathustra) < entradaDeSom.left.get(i))
    {
      zarathustra = i;
    }
  }

  //[TODO] otimizar substituindofor por arrayCopy()
  for (int i=zarathustra; i<entradaDeSom.left.size()-1; i++)
  {
    suavizado[i-zarathustra] = entradaDeSom.left.get(i);
  }

  //[TODO] otimizar substituindofor por arrayCopy()
  for (int i=0; i<zarathustra-1; i++)
  {
    suavizado[i + entradaDeSom.left.size()-zarathustra-1] = entradaDeSom.left.get(i);
  }
}

void draw()
{
  noCursor();
  background(0);
  //rastro();

  zaratustra();

  //copiar buffer suavizado para flores[florAtual]
  arrayCopy(suavizado, flores[florAtual]);
  florAtual++;
  if (florAtual>=numFlores-1) {
    florAtual=0;
  }

  int florMaisAntiga;
  if (florAtual == numFlores-1) {
    florMaisAntiga=0;
  } else {
    florMaisAntiga=florAtual+1;
  }

  float escala = 1;
  for (int j = florMaisAntiga; j<numFlores-1; j++) {
    desenhaFlor(j,escala);
    escala+=0.1;
  }
  if (florMaisAntiga>0) {
    for (int j=0; j<florMaisAntiga-1; j++) {
      desenhaFlor(j,escala);
      escala+=0.1;
    }
  }

  /*
  desenhaOnda();
  */
}

void desenhaFlor(int j, float escala) {
  colorMode(HSB);
  stroke(255, 0, (escala-1)*100);
  strokeWeight(grossura);
  float angle = 2* TWO_PI / (float) entradaDeSom.left.size();
  for (int i=0; i < entradaDeSom.left.size()/2-1; i++)
  {
    line (
      largura/2 + sin(i*angle)*(mouseY*escala + flores[j][i]*mouseX), //ponto1x
      altura/2 + cos(i*angle)*(mouseY*escala + flores[j][i]*mouseX), //ponto1y

      largura/2 + sin((i+1)*angle)*(mouseY*escala + flores[j][i+1]*mouseX), //ponto2x
      altura/2 + cos((i+1)*angle)*(mouseY*escala + flores[j][i+1]*mouseX)  //ponto2y
      );
  }
}

void desenhaOnda() {
  for (int i = 0; i < entradaDeSom.bufferSize()/2 - 1; i++)
  {
    line(i*2, 100 + suavizado[i]*50, (i+1)*2, 100 + suavizado[i+1]*50);
  }
}

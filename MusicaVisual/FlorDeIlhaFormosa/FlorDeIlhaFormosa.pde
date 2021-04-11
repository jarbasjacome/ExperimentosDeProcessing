/**
 * Original feito em 2011 para essa apresentação:
 * Jabah Pureza & Os Lanternistas Viajantes - Taiwanese Flower- Juízo Final, Taipei, 2011
 * https://www.youtube.com/watch?v=aL7_bLKgNuE
 *
 * Mais infos:
 * https://www.academia.edu/34682509/M%C3%9ASICA_VISUAL_ALGORITMO_DE_ZARATUSTRA_E_FLOR_DE_ILHA_FORMOSA
 */

import ddf.minim.*;

Minim minim;
AudioInput entradaDeSom;

float[] suavizado;

int largura = 512;
int altura = 200;

void setup()
{
  size(512, 200);

  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  entradaDeSom = minim.getLineIn();
    
  suavizado = new float[entradaDeSom.bufferSize()];
  
  entradaDeSom.disableMonitoring();
}

void draw()
{
  background(0);
  stroke(255);
  
  int zarathustra=0; //peak of the mountain
  for (int i=0; i<entradaDeSom.left.size()/2; i++)
  {
    if (entradaDeSom.left.get(zarathustra) < entradaDeSom.left.get(i))
    {
      zarathustra = i;
    }
  }
  
  for (int i=zarathustra; i<entradaDeSom.left.size()-1; i++)
  {
    suavizado[i-zarathustra] = entradaDeSom.left.get(i);
  }
  
  for (int i=0; i<zarathustra-1; i++)
  {
    suavizado[i + entradaDeSom.left.size()-zarathustra-1] = entradaDeSom.left.get(i);
  }
  
  float angle = 2* TWO_PI / (float) entradaDeSom.left.size();
  for (int i=0; i < entradaDeSom.left.size()/2-1; i++)
  {
    line (
            largura/2 + sin(i*angle)*(mouseY + suavizado[i]*mouseX),  //ponto1x
            altura/2 + cos(i*angle)*(mouseY + suavizado[i]*mouseX),  //ponto1y
            
            largura/2 + sin((i+1)*angle)*(mouseY + suavizado[i+1]*mouseX), //ponto2x
            altura/2 + cos((i+1)*angle)*(mouseY + suavizado[i+1]*mouseX)  //ponto2y
         );

  }

  // draw the waveforms
  for(int i = 0; i < entradaDeSom.bufferSize()/2 - 1; i++)
  {
    line(i*2, 100 + suavizado[i]*50, (i+1)*2, 100 + suavizado[i+1]*50);
  }
}

int NUM_ESTRELAS = 1000;

float RASTRO = 200;

float VEL_MAX = 200;

float TAM_MAX = 20;
float TAM_MAX_CONT = 80;

float SATURACAO = 220;
float SATURACAO_CONT = 60;

float OPACIDADE = 200;
float OPACIDADE_CONT = 20;

PVector[] estrelas;
float[] corEstrelas;

PVector vetor = new PVector(0,0);

void setup () {
  fullScreen(P3D);
  //size(1920,1024);
  noCursor();
  estrelas = new PVector[NUM_ESTRELAS];
  corEstrelas = new float[NUM_ESTRELAS];
  
  for (int i=0; i<NUM_ESTRELAS; i++){
    estrelas[i] = new PVector(random(width), random(height), random(1.0)*random(1.0)*random(1.0));
    corEstrelas[i] = random(1.0);
  }
}

void draw () {
  vetor.x = (mouseX - width/(float)2.0)/width;
  vetor.y = (mouseY - height/(float)2.0)/height;
  
  atualizaEstrelas();
  
  if (!keyPressed) {
    background(0);
  } else {
    fill(0,20);
    rect (0,0,width, height);
  }
  //desenhaVetor();
  desenhaEstrelas();
}

void desenhaVetor() {
  stroke(255);
  strokeWeight(1);
  line (width/2.0, height/2.0, width/2.0+width*vetor.x, height/2.0+width*vetor.y);
}

void atualizaEstrelas () {
  for (int i=0; i<NUM_ESTRELAS; i++) {
    estrelas[i].x += vetor.x*VEL_MAX*estrelas[i].z;
    estrelas[i].y += vetor.y*VEL_MAX*estrelas[i].z;
    float limiteDir = width + vetor.x*RASTRO*estrelas[i].z+TAM_MAX_CONT;
    float limiteEsq = - (vetor.x*RASTRO*estrelas[i].z+TAM_MAX_CONT);
    float limiteSup = - (vetor.y*RASTRO*estrelas[i].z+TAM_MAX_CONT);
    float limiteInf = height + vetor.y*RASTRO*estrelas[i].z+TAM_MAX_CONT; 
    if (estrelas[i].x > limiteDir) {
      estrelas[i].x = limiteEsq;
    }
    if (estrelas[i].y > limiteInf) {
      estrelas[i].y = limiteSup;
    }
    if (estrelas[i].x < limiteEsq) {
      estrelas[i].x = limiteDir;
    }
    if (estrelas[i].y < limiteSup) {
      estrelas[i].y = limiteInf;
    }
  }
}

void desenhaEstrelas() {
  colorMode(HSB);
  strokeCap(SQUARE);
  float x2, y2, grossura, grossura_cont;
  for (int i=0; i<NUM_ESTRELAS; i++) {
    x2 = estrelas[i].x + vetor.x*RASTRO*estrelas[i].z;
    y2 = estrelas[i].y + vetor.y*RASTRO*estrelas[i].z;
    grossura_cont = TAM_MAX_CONT*estrelas[i].z*random(0.95,1.0);
    stroke(255*corEstrelas[i],SATURACAO,255,OPACIDADE_CONT);
    strokeWeight(grossura_cont);
    line (estrelas[i].x, estrelas[i].y, x2, y2);

    fill(255*corEstrelas[i],SATURACAO,255,OPACIDADE_CONT);
    noStroke();
    circle(estrelas[i].x, estrelas[i].y, grossura_cont);
    circle(x2, y2, grossura_cont);
    
    grossura = TAM_MAX*estrelas[i].z*random(0.5,1.0);
    stroke(255*corEstrelas[i],SATURACAO,255,OPACIDADE);
    strokeWeight(grossura);
    line (estrelas[i].x, estrelas[i].y, x2, y2);

    fill(255*corEstrelas[i],SATURACAO,255,OPACIDADE);
    noStroke();
    circle(estrelas[i].x, estrelas[i].y, grossura);
    circle(x2, y2, grossura);
  }
}

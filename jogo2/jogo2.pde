import processing.sound.*;

// IMAGENS GLOBAIS
PImage imgAsteroide;
PImage imgNave;
PImage imgHistoria;
PImage imgJogador;
PImage imgVitoria1;
PImage imgVitoria2;
PImage imgGameOver;
PImage imgVitoria3;
PImage imgGameOver2;
PImage imgGameOver3;
PImage imgCapa;
PImage[] imgFios = new PImage[3];

SoundFile musica;

// ENTIDADES FASE 1
Player player;
ArrayList<Alien> aliens = new ArrayList<Alien>();

// ENTIDADES FASE 3
NavePlayer navePlayer;
ArrayList<LaserBullet> bullets = new ArrayList<LaserBullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

int tela = 0;

// MAPA (FASE 1)
int[][] mapa = {
  {1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,0,1,1,0,0,1,1,0,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,0,1,0,1,1,0,1,0,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,0,1,1,0,0,1,1,0,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1}
};

int[][] pontos;
int tamBloco = 60;
int score = 0;

// FASE 2 (FIOS)
boolean[] conexoes = {false, false, false};
int fioSelecionado = -1;
int[] destinoCorreto = {2, 0, 1};

// CONTROLADORES FASE 3
int enemyDir = 1;

boolean movLeft = false;
boolean movRight = false;
boolean movUp = false;
boolean movDown = false;

void setup() {
  size(600, 600);

  imgAsteroide = loadImage("asteroide.png");
  imgNave = loadImage("nave.png");
  imgHistoria = loadImage("historia.png");
  imgCapa = loadImage("capa.png");
  imgJogador = loadImage("personagem.png");
  imgVitoria1 = loadImage("vitoria1.png");
  imgGameOver = loadImage("GameOver.png");
  imgVitoria2 = loadImage("vitoria2.png");
  imgVitoria3 = loadImage("vitoria3.png");
  imgGameOver2 = loadImage("gameover2.png");
  imgGameOver3 = loadImage("gameover3.png");
  
  imgFios[0] = loadImage("fio_item1.png"); 
  imgFios[1] = loadImage("fio_item2.png"); 
  imgFios[2] = loadImage("fio_item3.png");
  
  musica = new SoundFile(this, "musica.mp3");
  musica.loop();
}

void draw() {
  background(10);

if (tela == 0) { telaInicio(); return; }
if (tela == 4) { telaHistoria(); return; }
if (tela == 2) { telaGameOver(); return; }
if (tela == 3) { telaVitoria1(); return; }
if (tela == 6) { telaVitoria2(); return; }
if (tela == 9) { telaGameOver2(); return; }
if (tela == 10) { telaGameOver3(); return; }
if (tela == 11) { telaVitoria3(); return; }
if (tela == 1) { fase1(); return; }
if (tela == 5) { fase2(); return; }
if (tela == 7) { fase3(); return; }
}

//////////////// TELAS DE TRANSIÇÃO e MENUS //////////////////

void telaInicio() {

  image(imgCapa, 0, 0, width, height);

  fill(0);
  textAlign(CENTER);
  textSize(28);
  text("APERTE ENTER PARA COMEÇAR", width/2 + 2, 552);

  fill(255);
  text("APERTE ENTER PARA COMEÇAR", width/2, 550);
}

void telaHistoria() {

  if (imgHistoria != null) {
    image(imgHistoria, 0, 0, width, height);
  } else {
    background(0);
  }

  fill(0);
  textAlign(CENTER);
  textSize(24);
  text("APERTE ENTER PARA INICIAR A MISSÃO", width/2 + 2, 552);

  fill(255);
  text("APERTE ENTER PARA INICIAR A MISSÃO", width/2, 550);
}

void telaGameOver() {
  if (imgGameOver != null) {
    image(imgGameOver, 0, 0, width, height);
  } else {
    background(0);
  }

  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("GAME OVER", width/2, 250);
  
  textSize(20);
  text("Pressione ENTER para voltar ao menu", width/2, 320);
}

void telaVitoria1() {
  if (imgVitoria1 != null) {
    image(imgVitoria1, 0, 0, width, height);
  } else {
    background(0);
  }
  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("VOCÊ VENCEU!", width/2, 250);
  
  textSize(20);
  text("Pontuação: " + score, width/2, 320);
  
  textSize(18);
  text("Pressione ENTER para próxima fase", width/2, 400); 
}

void telaVitoria2() {
  if (imgVitoria2 != null) {
    image(imgVitoria2, 0, 0, width, height);
  } else {
    background(0);
  }

  fill(255);
  textAlign(CENTER);
  textSize(40);
  text("FASE CONCLUÍDA!", width/2, 250);
  
  textSize(20);
  text("Preparado para o próximo desafio?", width/2, 320);
  
  textSize(18);
  text("Pressione ENTER para Fase Final", width/2, 400);
}

void telaVitoria3() {

  if (imgVitoria3 != null) {
    image(imgVitoria3, 0, 0, width, height);
  } else {
    background(0);
  }

  fill(255);
  textAlign(CENTER);
  textSize(24);
  text("Pontuação: " + score, width/2, 500);
}

void telaGameOver2() {
  if (imgGameOver2 != null) {
    image(imgGameOver2, 0, 0, width, height);
  } else {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("CONEXÃO PERDIDA!", width/2, height/2);
  }
}

void telaGameOver3() {
  if (imgGameOver3 != null) {
    image(imgGameOver3, 0, 0, width, height);
  } else {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("NAVE DESTRUÍDA!", width/2, height/2);
  }
}


//////////////// FASE 1: LABIRINTO //////////////////

void iniciarFase1() {
  player = new Player(60, 60);
  aliens.clear();
  aliens.add(new Alien(480, 480));
  iniciarPoints();
  score = 0;
}

void iniciarPoints() {
  pontos = new int[mapa.length][mapa[0].length];
  for (int i = 0; i < mapa.length; i++) {
    for (int j = 0; j < mapa[i].length; j++) {
      if (mapa[i][j] == 0) pontos[i][j] = 1;
    }
  }
}

void fase1() {

  float antigoX = player.x;
  float antigoY = player.y;

  if (movLeft) player.x -= 3;
  if (movRight) player.x += 3;
  if (movUp) player.y -= 3;
  if (movDown) player.y += 3;

  if (colisaoParede(player.x, player.y)) {
    player.x = antigoX;
    player.y = antigoY;
  }

  desenharMapa();
  desenharPontos();

  player.show();
  coletarPonto();

  for (Alien a : aliens) {
    a.update();
    a.show();
    if (dist(player.x, player.y, a.x, a.y) < 30) {
      tela = 2; // Game Over
    }
  }

  mostrarScore();

  if (verificarVitoria()) {
    tela = 3;
  }
}

void desenharMapa() {
  for (int i = 0; i < mapa.length; i++) {
    for (int j = 0; j < mapa[i].length; j++) {
      if (mapa[i][j] == 1) {
        fill(50, 50, 120);
        rect(j * tamBloco, i * tamBloco, tamBloco, tamBloco);
      }
    }
  }
}

void desenharPontos() {
  fill(255, 255, 0);
  for (int i = 0; i < pontos.length; i++) {
    for (int j = 0; j < pontos[i].length; j++) {
      if (pontos[i][j] == 1) {
        ellipse(j * tamBloco + tamBloco/2, i * tamBloco + tamBloco/2, 8, 8);
      }
    }
  }
}

void coletarPonto() {
  int col = int(player.x / tamBloco);
  int lin = int(player.y / tamBloco);

  if (pontos[lin][col] == 1) {
    pontos[lin][col] = 0;
    score += 10;
  }
}

boolean verificarVitoria() {
  for (int i = 0; i < pontos.length; i++) {
    for (int j = 0; j < pontos[i].length; j++) {
      if (pontos[i][j] == 1) return false;
    }
  }
  return true;
}

void mostrarScore() {
  fill(255);
  textSize(18);
  textAlign(LEFT);
  text("Score: " + score, 20, 30);
}

boolean colisaoParede(float x, float y) {
  int col = int(x / tamBloco);
  int lin = int(y / tamBloco);
  
  if (lin < 0 || lin >= mapa.length || col < 0 || col >= mapa[0].length) return true;
  return mapa[lin][col] == 1;
}

//////////////// FASE 2: FIOS //////////////////

void iniciarFase2() {
  conexoes = new boolean[]{false, false, false};
  fioSelecionado = -1;
}

void fase2() {
  background(20);

  fill(255);
  textSize(28);
  textAlign(CENTER);
  text("FASE 2 - CONECTE OS FIOS", width/2, 50);

  imageMode(CENTER); 

  for (int i = 0; i < 3; i++) {
    float y = 150 + i * 120;

    // ESQUERDA
    if (imgFios[i] != null) {
      image(imgFios[i], 100, y, 40, 40); 
    } else {
      fill(0, 0, 255);
      ellipse(100, y, 30, 30); 
    }

    // DIREITA EMBARALHADA
    int indiceImagemDireita = 0;
    for (int j = 0; j < 3; j++) {
      if (destinoCorreto[j] == i) {
        indiceImagemDireita = j;
      }
    }

    if (imgFios[indiceImagemDireita] != null) {
      image(imgFios[indiceImagemDireita], 500, y, 40, 40);
    } else {
      fill(255, 0, 0);
      ellipse(500, y, 30, 30); 
    }

    // Linha verde de conexão concluída
    if (conexoes[i]) {
      stroke(0, 255, 0);
      strokeWeight(4);
      line(100, y, 500, 150 + destinoCorreto[i] * 120);
      noStroke();
    }
  }

  // Traço dinâmico seguindo o mouse
  if (fioSelecionado != -1) {
    stroke(255);
    strokeWeight(3);
    line(100, 150 + fioSelecionado * 120, mouseX, mouseY);
    noStroke();
  }

  imageMode(CORNER); 

  if (conexoes[0] && conexoes[1] && conexoes[2]) {
    tela = 6; 
  }
}

//////////////// FASE 3: ASTEROIDES (Fase Final) //////////////////

void iniciarFase3() {
  navePlayer = new NavePlayer();
  bullets.clear();
  enemies.clear();
  enemyDir = 1;

  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 8; x++) {
      enemies.add(new Enemy(70 + x * 60, 60 + y * 45));
    }
  }
}

void fase3() {
  background(10);

  mostrarScore();

  navePlayer.update();
  navePlayer.show();

  // Gerenciamento de projéteis e colisões
  for (int i = bullets.size() - 1; i >= 0; i--) {
    LaserBullet b = bullets.get(i);
    b.update();
    b.show();

    if (b.y < 0) {
      bullets.remove(i);
      continue;
    }

    for (int j = enemies.size() - 1; j >= 0; j--) {
      Enemy e = enemies.get(j);

      if (b.hits(e)) {
        enemies.remove(j);
        bullets.remove(i);
        score += 10;
        break;
      }
    }
  }

  boolean moveDown = false;

  // Lógica de movimentação dos Asteroides (Invasores)
  for (Enemy e : enemies) {
    e.x += enemyDir * 1.2;

    if (e.x > width - 30 || e.x < 30) {
      moveDown = true;
    }

    if (e.y > height - 80) {
      tela = 10; // Game Over se chegarem muito perto
    }
  }

  if (moveDown) {
    enemyDir *= -1;
    for (Enemy e : enemies) {
      e.y += 25;
    }
  }

  for (Enemy e : enemies) {
    e.show();
  }

  // Condição de Vitória da Fase Final
  if (enemies.size() == 0) {
    tela = 11;
  }
}

//////////////// EVENTOS DE INPUT CONTROLE //////////////////

void keyPressed() {
  // Transições de Telas com ENTER
  if (tela == 0 && keyCode == ENTER) {
  tela = 4;
}
  else if (tela == 4 && keyCode == ENTER) {
    iniciarFase1();
    tela = 1;
}
  else if (tela == 2 && keyCode == ENTER) {
    tela = 0; // Se perder, retorna ao menu
  }
  else if (tela == 3 && keyCode == ENTER) {
    iniciarFase2();
    tela = 5; 
  }
  else if (tela == 6 && keyCode == ENTER) {
    iniciarFase3();
    tela = 7; // Segue para a fase final de Asteroides
  }
  else if (tela == 8 && keyCode == ENTER) {
    tela = 0; // Vitória total volta ao menu inicial
  }
  else if (tela == 9 && keyCode == ENTER) {
    iniciarFase2();
    tela = 5;
}
  else if (tela == 10 && keyCode == ENTER) {
    iniciarFase3();
    tela = 7;
}
  else if (tela == 11 && keyCode == ENTER) {
    tela = 0;
}

// Movimentação FASE 1
if (tela == 1) {
  if (keyCode == LEFT) movLeft = true;
  if (keyCode == RIGHT) movRight = true;
  if (keyCode == UP) movUp = true;
  if (keyCode == DOWN) movDown = true;
}

  // Movimentação e Tiro FASE 3
  if (tela == 7) {
    if (keyCode == LEFT) {
      navePlayer.movingLeft = true;
    }
    if (keyCode == RIGHT) {
      navePlayer.movingRight = true;
    }
    if (key == ' ') {
      bullets.add(new LaserBullet(navePlayer.x, navePlayer.y - 20));
    }
  }
}

void keyReleased() {

  if (tela == 1) {
    if (keyCode == LEFT) movLeft = false;
    if (keyCode == RIGHT) movRight = false;
    if (keyCode == UP) movUp = false;
    if (keyCode == DOWN) movDown = false;
  }

  // Parar movimentação na FASE 3
  if (tela == 7) {
    if (keyCode == LEFT) {
      navePlayer.movingLeft = false;
    }
    if (keyCode == RIGHT) {
      navePlayer.movingRight = false;
    }
  }
}

void mousePressed() {
  if (tela != 5) return;

  for (int i = 0; i < 3; i++) {
    float y = 150 + i * 120;
    if (dist(mouseX, mouseY, 100, y) < 20) {
      fioSelecionado = i;
    }
  }
}

void mouseReleased() {
  if (tela != 5) return;

  if (fioSelecionado != -1) {
    for (int i = 0; i < 3; i++) {
      float y = 150 + i * 120;
      if (dist(mouseX, mouseY, 500, y) < 20) {
        if (destinoCorreto[fioSelecionado] == i) {
          conexoes[fioSelecionado] = true;
        }
      }
    }
    fioSelecionado = -1;
  }
}

//////////////// CLASSES CONFIGURADAS //////////////////

// Personagem do Labirinto (Fase 1)
class Player {
  float x, y;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    imageMode(CENTER);
    if (imgJogador != null) {
      image(imgJogador, x, y, 40, 40);
    } else {
      fill(0, 255, 0);
      ellipse(x, y, 30, 30);
    }
    imageMode(CORNER);
  }
}

// Inimigo do Labirinto (Fase 1)
class Alien {
  float x, y;

  Alien(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    float antiX = x;
    if (x < player.x) x += 1;
    if (x > player.x) x -= 1;
    if (colisaoParede(x, y)) x = antiX;

    float antiY = y;
    if (y < player.y) y += 1;
    if (y > player.y) y -= 1;
    if (colisaoParede(x, y)) y = antiY;
  }

  void show() {
    fill(255, 0, 0);
    ellipse(x, y, 30, 30);
  }
}

// Nave da Fase Final (Fase 3)
class NavePlayer {
  float x;
  float y;

  boolean movingLeft = false;
  boolean movingRight = false;

  NavePlayer() {
    x = width / 2;
    y = height - 50;
  }

  void update() {
    if (movingLeft) {
      x -= 5;
    }
    if (movingRight) {
      x += 5;
    }
    x = constrain(x, 30, width - 30);
  }

  void show() {
    imageMode(CENTER);
    if (imgNave != null) {
      image(imgNave, x, y, 70, 70);
    } else {
      fill(0, 0, 255);
      rect(x, y, 50, 20);
    }
    imageMode(CORNER);
  }
}

// Projéteis da Nave (Fase 3)
class LaserBullet {
  float x;
  float y;

  LaserBullet(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    y -= 7;
  }

  void show() {
    fill(255, 255, 0);
    rectMode(CENTER);
    rect(x, y, 5, 15);
    rectMode(CORNER);
  }

  boolean hits(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    return d < 25;
  }
}

// Asteroides / Invasores (Fase 3)
class Enemy {
  float x;
  float y;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    imageMode(CENTER);
    if (imgAsteroide != null) {
      image(imgAsteroide, x, y, 40, 40);
    } else {
      fill(200, 100, 0);
      ellipse(x, y, 35, 35);
    }
    imageMode(CORNER);
  }
}

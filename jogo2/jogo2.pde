PImage imgAsteroide;
PImage imgNave;

Player player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

int score = 0;
int enemyDir = 1;

int tela = 0;
// 0 = início
// 1 = jogo
// 2 = game over
// 3 = vitória

void setup() {
  size(600, 600);

  imgAsteroide = loadImage("asteroide.png");
  imgNave = loadImage("nave.png");

  iniciarJogo();
}

void draw() {
  background(10);

  if (tela == 0) {
    telaInicio();
    return;
  }

  if (tela == 2) {
    telaFim("GAME OVER");
    return;
  }

  if (tela == 3) {
    telaFim("VOCÊ VENCEU!");
    return;
  }

  fill(255);
  textSize(18);
  textAlign(LEFT);
  text("Score: " + score, 20, 30);

  player.update();
  player.show();

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);

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

  for (Enemy e : enemies) {
    e.x += enemyDir * 1.2;

    if (e.x > width - 30 || e.x < 30) {
      moveDown = true;
    }

    if (e.y > height - 80) {
      tela = 2;
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

  if (enemies.size() == 0) {
    tela = 3;
  }
}

void iniciarJogo() {
  player = new Player();

  bullets.clear();
  enemies.clear();

  score = 0;
  enemyDir = 1;

  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 8; x++) {
      enemies.add(new Enemy(70 + x * 60, 60 + y * 45));
    }
  }
}

void telaInicio() {
  background(5, 5, 20);

  fill(255);
  textAlign(CENTER);

  textSize(42);
  text("SPACE ASTEROIDS", width/2, 180);

  textSize(20);
  text("Use as setas para mover a nave", width/2, 260);
  text("Aperte ESPAÇO para atirar", width/2, 295);

  textSize(24);
  text("Pressione ENTER para começar", width/2, 390);
}

void telaFim(String mensagem) {
  background(5, 5, 20);

  fill(255);
  textAlign(CENTER);

  textSize(42);
  text(mensagem, width/2, 220);

  textSize(22);
  text("Pontuação: " + score, width/2, 280);

  textSize(20);
  text("Pressione R para recomeçar", width/2, 360);
  text("Pressione ENTER para voltar ao início", width/2, 395);
}

void keyPressed() {
  if (tela == 0 && keyCode == ENTER) {
    tela = 1;
  }

  if ((tela == 2 || tela == 3) && (key == 'r' || key == 'R')) {
    iniciarJogo();
    tela = 1;
  }

  if ((tela == 2 || tela == 3) && keyCode == ENTER) {
    iniciarJogo();
    tela = 0;
  }

  if (tela != 1) {
    return;
  }

  if (keyCode == LEFT) {
    player.movingLeft = true;
  }

  if (keyCode == RIGHT) {
    player.movingRight = true;
  }

  if (key == ' ') {
    bullets.add(new Bullet(player.x, player.y - 20));
  }
}

void keyReleased() {
  if (tela != 1) {
    return;
  }

  if (keyCode == LEFT) {
    player.movingLeft = false;
  }

  if (keyCode == RIGHT) {
    player.movingRight = false;
  }
}

class Player {
  float x;
  float y;

  boolean movingLeft = false;
  boolean movingRight = false;

  Player() {
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
    image(imgNave, x, y, 70, 70);
  }
}

class Bullet {
  float x;
  float y;

  Bullet(float x, float y) {
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
  }

  boolean hits(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    return d < 25;
  }
}

class Enemy {
  float x;
  float y;

  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void show() {
    imageMode(CENTER);
    image(imgAsteroide, x, y, 40, 40);
  }
}

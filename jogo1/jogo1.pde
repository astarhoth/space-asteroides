Player player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

int score = 0;
boolean gameOver = false;
int enemyDir = 1;

void setup() {
  size(600, 600);
  player = new Player();

  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 8; x++) {
      enemies.add(new Enemy(70 + x * 60, 60 + y * 45));
    }
  }
}

void draw() {
  background(10);

  if (gameOver) {
    fill(255);
    textAlign(CENTER);
    textSize(40);
    text("GAME OVER", width/2, height/2);
    textSize(20);
    text("Pontuação: " + score, width/2, height/2 + 40);
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
      gameOver = true;
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
    fill(255);
    textAlign(CENTER);
    textSize(35);
    text("VOCÊ VENCEU!", width/2, height/2);
  }
}

void keyPressed() {
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

    x = constrain(x, 25, width - 25);
  }

  void show() {
    fill(0, 200, 255);
    triangle(x, y - 25, x - 25, y + 20, x + 25, y + 20);
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
    fill(255, 60, 100);
    ellipse(x, y, 35, 35);

    fill(0);
    ellipse(x - 8, y - 5, 6, 6);
    ellipse(x + 8, y - 5, 6, 6);
  }
}

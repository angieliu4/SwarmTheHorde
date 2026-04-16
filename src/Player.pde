// Player class

class Player {
  float x, y, w, h, speed;
  float health = 100;
  int maxHealth = 100;

  boolean isMovingLeft, isMovingRight, isMovingUp, isMovingDown;

  Player(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    speed = 10;

    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;
  }

  void display() {
    //placeholder
    fill(255, 0, 0);
    ellipse(x, y, w, h);

    drawHealthBar();
    move();
  }


  void move() {
    if (isMovingLeft) x -= speed;
    if (isMovingRight) x += speed;
    if (isMovingUp) y -= speed;
    if (isMovingDown) y += speed;

    if (x + w/2 >= width) {
      x = width - w/2;
    }
    if (x - w/2 <= 0) {
      x = 0 + w/2;
    }
    if (y - h/2 <= 100) {
      y = 100 + w/2;
    }
    if (y + h/2 >= height) {
      y = height - w/2;
    }
  }

  //health bar
  void drawHealthBar() {
    fill(50);
    rect(x, y + 65, maxHealth, 10);
    fill(0, 255, 0);
    rect(x, y + 65, health, 10);
  }
  
  //boolean fire() {
    
  //}
}

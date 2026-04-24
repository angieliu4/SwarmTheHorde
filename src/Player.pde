// Player class

class Player {
  float x, y, w, h, speed;
  float health = 120;
  float exp = 0;
  float maxExp = 100;
  float maxHealth = 120;
  
  String character;

  boolean isMovingLeft, isMovingRight, isMovingUp, isMovingDown;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    w = 50;
    h = 50;
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;
  }

  void display() {
    //placeholder
    if (character == "hank") {
      fill(0, 0, 0);
    } else if (character == "apricot") {
      fill(#bf8d62);
    }
    ellipse(x, y, w, h);
    
    //only shows if player loses health
    if (health < 120) {
      drawHealthBar();
    }
    move();
  }


  void move() {
    if (character == "hank") {
      speed = 4;
    } else if (character == "apricot") {
      speed = 5.5;
    }
    
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
    rect(x, y + 40, maxHealth/3, 7);
    fill(0, 255, 0);
    rect(x, y + 40, health/3, 7);
  }
  
  //boolean fire() {
    
  //}
}

// Player class

class Player {
  float x, y, w, h, speed;
  float health = 100; //will get changed when player chooses character (in mouse clicked)
  float exp = 0;
  float maxExp = 100;
  float maxHealth = 100; //will get changed when player chooses character (in mouse clicked)

  String character;

  boolean isMovingLeft, isMovingRight, isMovingUp, isMovingDown;

  PImage image;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    w = 70;
    h = 70;
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;

    
  }

  void display() {
    if (character == "hank") {
      if (level < 15) {
        image = loadImage("fatrat.png");
      }
      if (level == 15) {
        image = loadImage("flabberghastedrat.png");
      } else if (level == 25) {
        image = loadImage("ballrat.png");
      } else if (level == 35) {
        image = loadImage("chickenrat.png");
      } else if (level == 45) {
        image = loadImage("logarithmicrat.png");
      } else if (level == 55) {
        image = loadImage("demonrat.png");
      }
    } else if (character == "apricot") {
      if (level == 15) {
        image = loadImage("moldyrat.png");
      } else if (level == 25) {
        image = loadImage("moldyrat.png");
      } else if (level == 35) {
        image = loadImage("moldyrat.png");
      } else if (level == 45) {
        image = loadImage("moldyrat.png");
      } else if (level == 55) {
        image = loadImage("moldyrat.png");
      }
    }
    image(image, x, y);


    //only shows if player loses health
    if (health < maxHealth) {
      drawHealthBar();
    }

    if (health >= maxHealth) {
      health = maxHealth;
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
    rect(x, y + 50, maxHealth/3, 7);
    fill(0, 255, 0);
    rect(x, y + 50, health/3, 7);
  }

  //boolean fire() {

  //}
}

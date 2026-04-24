class Enemy {
  float x, y, w, h, speed, damage;
  String type;
  int health;

  Enemy(float x, float y, String type) {
    this.x = x;
    this.y = y;
    this.type = type;
    //speed is set in the intersect method down below

    if (type == "red") {
      w = 30;
      h = 30;
      damage = 1;
      health = 100;
    } else if (type == "blue") {
      w = 25;
      h = 25;
      damage = 0.5;
      health = 75;
    } else if (type == "green") {
      w = 40;
      h = 40;
      damage = 2;
      health = 150;
    }
  }

  void display() {
    //placeholder
    if (type == "red") {
      fill(255, 0, 0);
    } else if (type == "blue") {
      fill(0, 0, 255);
    } else if (type == "green") {
      fill(0, 255, 0);
    }

    ellipse(x, y, w, h);
    
    //calling the follow and intersect methods so we don't need to do it in the main class
    update();
    intersect(player);
  }

  void update() {
    //calculates the distance to the player and angle then move towards it
    float dx = player.x - x;
    float dy = player.y - y;
    float angle = atan2(dy, dx);

    this.x += cos(angle) * speed;
    this.y += sin(angle) * speed;
  }

  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    //checks if the edges of the hitboxes for enemy and player are colliding
    //w and h are the hitbox for the enemy, p.w and p.h are the hitbox for the player
    if (d < (w/2 + p.w/2) && d < (h/2 + p.h/2)) {
      speed = 0;
      p.health -= damage;
      return true;
    } else {
      if (type == "red") {
        speed = 1;
      } else if (type == "green") {
        speed = 0.5;
      } else if (type == "blue") {
        speed = 2;
      }
      return false;
    }
  }
}

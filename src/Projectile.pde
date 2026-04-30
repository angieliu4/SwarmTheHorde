//Projectiles

class Projectile {
  float x, y, w, h, tx, ty, speed;
  float vx, vy;
  PImage image;


  Projectile(float x, float y, float tx, float ty) {
    this.x = x;
    this.y = y;
    this.tx = tx;
    this.ty = ty;
    image = loadImage("projectile.png");
    w = 20;
    h = 20;
    speed = 6;

    float dx = tx - x;
    float dy = ty - y;

    float dist = sqrt(dx * dx + dy * dy);

    vx = (dx / dist) * speed;
    vy = (dy / dist) * speed;
  }

  void display() {
    image(image, x, y);
    
    move();
  }
  
  void move () {
    x += vx;
    y += vy;
  }
  
  boolean offScreen() {
    if (x < 0 || x > width || y < 0 || y > height) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    //checks if the edges of the hitboxes for projectile and enemy are colliding
    //w and h are the hitbox for the projectile, e.w and e.h are the hitbox for the enemy
    if (d < (w/2 + e.w/2) && d < (h/2 + e.h/2)) {
      return true;
    } else {
      return false;
    }
  }
}

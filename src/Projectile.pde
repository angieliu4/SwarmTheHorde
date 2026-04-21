//Projectiles

class Projectile {
  float x, y, w, h, tx, ty, speed, damage;
  float vx, vy;


  Projectile(float x, float y, float tx, float ty) {
    this.x = x;
    this.y = y;
    this.tx = tx;
    this.ty = ty;
    w = 30;
    h = 30;
    speed = 10;
    damage = 20;

    float dx = tx - x;
    float dy = ty - y;

    float dist = sqrt(dx * dx + dy * dy);

    vx = (dx / dist) * speed;
    vy = (dy / dist) * speed;
  }

  void display() {
    fill(#7242f5);
    ellipse(x, y, w, h);
    move();
  }
  
  void move () {
    x += vx;
    y += vy;
  }

  boolean intersect(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    //checks if the edges of the hitboxes for projectile and enemy are colliding
    //w and h are the hitbox for the projectile, e.w and e.h are the hitbox for the enemy
    if (d < (w/2 + e.w/2) && d < (h/2 + e.h/2)) {
      e.health -= damage;
      return true;
    } else {
      return false;
    }
  }
}

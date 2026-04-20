//Projectiles

class Projectile {
  float x, y, w, h, tx, ty, speed, damage;


  Projectile(float x, float y, float tx, float ty) {
    this.x = x;
    this.y = y;
    this.tx = tx;
    this.ty = ty;
    w = 30;
    h = 30;
    speed = 10;
    damage = 20;
  }

  void display() {
    fill(#7242f5);
    ellipse(x, y, w, h);
    update();
  }

  //void fire(float x, float y, float tx, float ty) {
  //  float dx = tx - x;
  //  float dy = ty - y;

  //  float dist = sqrt(dx * dx + dy * dy);

  // velocity x vx = (dx / dist) * 5;
  // velocity y vy = (dy / dist) * 5;

  //  px = sx;
  //  py = sy;
  //}

  void update() {
      float dx = mouseX - x;
      float dy = mouseY - y;
      float angle = atan2(dy, dx);
      this.x += cos(angle) * speed;
      this.y += sin(angle) * speed;
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

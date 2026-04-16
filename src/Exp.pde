//Projectiles

class Exp {
  float x, y, w, h, amount;
  String type;

  Exp(float x, float y, String type) {
    this.x = x;
    this.y = y;
    this.type = type;
    w = 30;
    h = 30;
    
  }

  void display() {
    fill(#de83ad);
    ellipse(x, y, w, h);
  }
 

  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    //checks if the edges of the hitboxes for projectile and enemy are colliding
    //w and h are the hitbox for the projectile, e.w and e.h are the hitbox for the enemy
    if (d < (w/2 + p.w/2) && d < (h/2 + p.h/2)) {
      p.exp += amount;
      return true;
    } else {
      return false;
    }
  }
}

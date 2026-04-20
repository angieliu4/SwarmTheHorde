//Projectiles

class Exp {
  float x, y, w, h, amount;
  String type;

  Exp(float x, float y, String type) {
    this.x = x;
    this.y = y;
    this.type = type;
    w = 15;
    h = 15;
    if (type == "tier1") {
      amount = 10;
    }
    
  }

  void display() {
    if (type == "tier1") {
      fill(#de83ad);
    }
    ellipse(x, y, w, h);
  }
 

  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    //checks if the edges of the hitboxes for exp and player are colliding
    //w and h are the hitbox for the exp, p.w and p.h are the hitbox for the player
    if (d < (w/2 + p.w/2) && d < (h/2 + p.h/2)) {
      p.exp += amount;
      return true;
    } else {
      return false;
    }
  }
}

//Food

class Food {
  float x, y, w, h;
  String type;
  
  PImage carrot;

  Food(float x, float y) {
    this.x = x;
    this.y = y;
    w = 20;
    h = 20;
  }

  void display() {
    carrot = loadImage("carrot.png");
    image(carrot, x, y);
  }


  boolean intersect(Player p) {
    float d = dist(x, y, p.x, p.y);
    //checks if the edges of the hitboxes for exp and player are colliding
    //w and h are the hitbox for the food, p.w and p.h are the hitbox for the player
    if (d < (w/2 + p.w/2) && d < (h/2 + p.h/2)) {
      return true;
    } else {
      return false;
    }
  }
}

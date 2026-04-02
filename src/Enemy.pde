class Enemy {
  float x, y, w, h, speed;
  int health = 100;

  Enemy(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    speed = 5;
  }

  void display() {
    //placeholder
    fill(0, 0, 255);
    ellipse(x, y, w, h);
    update();
  }
  
  void update() {
    //calculates the distance to the player and angle then move towards it
    float dx = player.x - x;
    float dy = player.y - y;
    float angle = atan2(dy, dx);
    
    this.x += cos(angle) * speed;
    this.y += sin(angle) * speed;
  }
}

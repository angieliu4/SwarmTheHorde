//Main class

//screens
String screen = "game"; //title, game, settings, lose, win

//timer
int time = 60;
int level = 1;

//player
Player player;

//enemies
Enemy enemy;

void setup() {
  size(1200, 1000);
  background(255);
  pixelDensity(1);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  rectMode(CENTER);
  
  //set up player
  player = new Player(600, 500, 100, 100);
  
  //setup enemies
  enemy = new Enemy(200, 200, 60, 60);
}

void draw() {
  switch (screen) {
    case "game":
      gameScreen();
      break;
  }
}

void startScreen() {}

void gameScreen() {
  background(255);
  
  //gamebar
  fill(#fccce9);
  rect(600, 50, 1200, 100);
  
  fill(255);
  textSize(75);
  text(time, 100, 40);
  text("Level: " + level, 600, 40);
 
  player.display();
  enemy.display();
 
}

void settingsScreen() {}

void gameOver() {}

void win() {}

void keyPressed() {
  if (key == 'a' || keyCode == LEFT) {
    player.isMovingLeft = true;
  }
  if (key == 'd' || keyCode == RIGHT) {
    player.isMovingRight = true;
  }
  if (key == 'w' || keyCode == UP) {
    player.isMovingUp = true;
  }
  if (key == 's' || keyCode == DOWN) {
    player.isMovingDown = true;
  }
}

void keyReleased() {
  //stops movement if the key is released
  if (key == 'a' || keyCode == LEFT) {
    player.isMovingLeft = false;
  }
  if (key == 'd' || keyCode == RIGHT) {
    player.isMovingRight = false;
  }
  if (key == 'w' || keyCode == UP) {
    player.isMovingUp = false;
  }
  if (key == 's' || keyCode == DOWN) {
    player.isMovingDown = false;
  }
}

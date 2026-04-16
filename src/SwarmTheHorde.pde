//Main class

//screens
String screen = "game"; //title, game, settings, lose, win

//waves and player level
int wave = 1;
int level = 1;

//game over switch and pause switch
boolean isGameOver = false;
boolean isPaused = false;

//timers
Timer pTime;

//player
Player player;

//enemies
Enemy enemy1, enemy2, enemy3;

//projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

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
  enemy1 = new Enemy(200, 200, "red");
  enemy2 = new Enemy(400, 1000, "blue");
  enemy3 = new Enemy(1000, 100, "green");
  
  //setup timers
  pTime = new Timer(500);
  pTime.start();
  
}

void draw() {
  //screen manager
  switch (screen) {
  case "game":
    gameScreen();
    if (isGameOver) {
      gameOver();
    }
    break;
  }
}

void startScreen() {
}

void gameScreen() {
  //where everything in the game is running
  //only runs if the game isn't over or paused
  if (isGameOver == false && isPaused == false) {
    background(255);

    //gamebar
    fill(#fccce9);
    rect(600, 50, 1200, 100);

    fill(255);
    textSize(60);
    text("Wave: " + wave, 150, 40);
    text("Level: " + level, 600, 40);

    if (player.health <= 0) {
      isGameOver = true;
    }
    
    //player projectiles
    
    if (pTime.isFinished()) {
      projectiles.add(new Projectile(player.x, player.y, enemy1.x, enemy1.y));
      println(projectiles.size());
      pTime.start();
    }
    
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile pjct = projectiles.get(i);
      
      //temp until better solution
      if(pjct.intersect(enemy1)) {
        projectiles.remove(pjct);
      }
      
      pjct.display();
    }

    player.display();
    enemy1.display();
    enemy2.display();
    enemy3.display();
  }
}

void settingsScreen() {
}

void pauseScreen() {
}

void gameOver() {
  background(255);

  fill(#fccce9);
  rect(600, 50, 1200, 100);

  fill(255);
  textSize(60);
  text("Wave: " + wave, 150, 40);
  text("Level: " + level, 600, 40);
  
  fill(0);
  text("You died!", 600, 300);
}

void win() {
}

void keyPressed() {
  //player movement
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

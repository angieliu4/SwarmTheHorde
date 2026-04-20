//Main class

//screens
String screen = "game"; //title, game, settings, lose, win

//waves and player level
int wave = 1;
int level = 1;

//game over switch and pause switch
boolean isGameOver = false;
boolean isPaused = false;

//random enemy generation
int randEnemy;

//timers
Timer pTime, enemyTime, waveTime;

//player
Player player;

//enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//exp
ArrayList<Exp> exps = new ArrayList<Exp>();

void setup() {
  size(1200, 1000);
  background(255);
  pixelDensity(1);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  rectMode(CENTER);

  //set up player
  player = new Player(600, 500, 100, 100);

  //setup timers
  pTime = new Timer(500);
  pTime.start();

  enemyTime = new Timer(2000);
  enemyTime.start();
  
  waveTime = new Timer(60000);
  waveTime.start();
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

    //random enemy spawning, each enemy is weighted different, sometimes doesn't spawn an enemy
    if (enemyTime.isFinished()) {
      randEnemy = (int)random(0, 10);
      if (randEnemy == 1 || randEnemy == 2 || randEnemy == 3 || randEnemy == 4) {
        enemies.add(new Enemy(1300, 200, "red"));
      } else if (randEnemy == 5 || randEnemy == 6 || randEnemy == 7) {
        enemies.add(new Enemy(1300, 200, "blue"));
      } else if (randEnemy == 8 || randEnemy == 9) {
        enemies.add(new Enemy(1300, 200, "green"));
      } else {
      }
      enemyTime.start();
    }

    //rendering enemies
    for (int j = 0; j < enemies.size(); j++) {
      Enemy enemy = enemies.get(j);
      enemy.display();
    }

    //spawning player projectiles when timer has ended
    if (pTime.isFinished()) {
      projectiles.add(new Projectile(player.x, player.y, mouseX, mouseY));
      pTime.start();
    }

    //checking for enemy/projectile collision, projectile rendering, exp spawning
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile pjct = projectiles.get(i);

      for (int j = 0; j < enemies.size(); j++) {
        //temp until better solution
        Enemy enemy = enemies.get(j);
        if (pjct.intersect(enemy)) {
          if (enemy.health <= 0) {
            exps.add(new Exp(enemy.x, enemy.y, "tier1"));
            enemies.remove(enemy);
          }
          projectiles.remove(pjct);
        }
      }
      pjct.display();
    }
    
    //rendering exp, player level up
    for (int k = 0; k < exps.size(); k++) {
      Exp exp = exps.get(k);
      if(exp.intersect(player)) {
        exps.remove(exp);
        println("Exp:" + player.exp);
        //player needs more exp to level up the higher their level is
        if (player.exp >= player.maxExp) {
          level += 1;
          player.maxExp += 10;
          player.exp = 0;
          println("Max Exp:" + player.maxExp);
        }
      }
      exp.display();
    }
    
    //wave timer
    if (waveTime.isFinished()) {
      wave += 1;
      waveTime.start();
    }

    //rendering player
    player.display();
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
//Main class

//screens
String screen = "game"; //title, game, settings, lose, win

//waves and player level
int wave = 1;
int level = 1;

//game over switch and pause switch
boolean isGameOver = false;
boolean isPaused = false;

//random enemy generation
int randEnemy;

//timers
Timer pTime, enemyTime, waveTime;

//player
Player player;

//enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//exp
ArrayList<Exp> exps = new ArrayList<Exp>();

void setup() {
  size(1200, 1000);
  background(255);
  pixelDensity(1);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  rectMode(CENTER);

  //set up player
  player = new Player(600, 500, 100, 100);

  //setup timers
  pTime = new Timer(500);
  pTime.start();

  enemyTime = new Timer(2000);
  enemyTime.start();
  
  waveTime = new Timer(60000);
  waveTime.start();
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

    //random enemy spawning, each enemy is weighted different, sometimes doesn't spawn an enemy
    if (enemyTime.isFinished()) {
      randEnemy = (int)random(0, 10);
      if (randEnemy == 1 || randEnemy == 2 || randEnemy == 3 || randEnemy == 4) {
        enemies.add(new Enemy(1300, 200, "red"));
      } else if (randEnemy == 5 || randEnemy == 6 || randEnemy == 7) {
        enemies.add(new Enemy(1300, 200, "blue"));
      } else if (randEnemy == 8 || randEnemy == 9) {
        enemies.add(new Enemy(1300, 200, "green"));
      } else {
      }
      enemyTime.start();
    }

    //rendering enemies
    for (int j = 0; j < enemies.size(); j++) {
      Enemy enemy = enemies.get(j);
      enemy.display();
    }

    //spawning player projectiles when timer has ended
    if (pTime.isFinished()) {
      projectiles.add(new Projectile(player.x, player.y, mouseX, mouseY));
      pTime.start();
    }

    //checking for enemy/projectile collision, projectile rendering, exp spawning
    for (int i = 0; i < projectiles.size(); i++) {
      Projectile pjct = projectiles.get(i);

      for (int j = 0; j < enemies.size(); j++) {
        //temp until better solution
        Enemy enemy = enemies.get(j);
        if (pjct.intersect(enemy)) {
          if (enemy.health <= 0) {
            exps.add(new Exp(enemy.x, enemy.y, "tier1"));
            enemies.remove(enemy);
          }
          projectiles.remove(pjct);
        }
      }
      pjct.display();
    }
    
    //rendering exp, player level up
    for (int k = 0; k < exps.size(); k++) {
      Exp exp = exps.get(k);
      if(exp.intersect(player)) {
        exps.remove(exp);
        println("Exp:" + player.exp);
        //player needs more exp to level up the higher their level is
        if (player.exp >= player.maxExp) {
          level += 1;
          player.maxExp += 10;
          player.exp = 0;
          println("Max Exp:" + player.maxExp);
        }
      }
      exp.display();
    }
    
    //wave timer
    if (waveTime.isFinished()) {
      wave += 1;
      waveTime.start();
    }

    //rendering player
    player.display();
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

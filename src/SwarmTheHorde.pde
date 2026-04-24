//Main class

//screens
String screen = "title"; //title, game, settings, lose, win, pause, level up, evolution

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

//stat trackers
float playerDamage = 15; //seperate tracker for projectile damage
float totalDamage = 0;
float totalKills = 0;

//enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//exp
ArrayList<Exp> exps = new ArrayList<Exp>();

//buttons
Button btnStart, btnSettings, btnQuit, btnBack, btnMenu, btnRestart, btnDamageUpgrade, btnHealthUpgrade, btnFRUpgrade, btnSpeedUpgrade, btnYippee, btnSkip;

void setup() {
  size(1200, 1000);
  background(255);
  pixelDensity(1);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  rectMode(CENTER);

  //set up player
  player = new Player(600, 500);

  //setup timers
  pTime = new Timer(1200);
  pTime.start();

  enemyTime = new Timer(3000);
  enemyTime.start();

  waveTime = new Timer(60000);
  waveTime.start();

  //button setup, parameters in order are text, x position, y position, width, height, normal color, hovering color, text size
  btnStart = new Button ("Start", 600, 500, 400, 100, #2f7542, #53b86e, 75);
  btnSettings = new Button("Settings", 600, 625, 200, 50, #2f7542, #53b86e, 35);
  btnQuit = new Button("Quit", 600, 700, 150, 50, #2f7542, #53b86e, 35);
  btnBack = new Button("Back", 100, 50, 150, 50, #2f7542, #53b86e, 35);
  btnRestart = new Button("Restart", 600, 500, 400, 100, #2f7542, #53b86e, 75);
  btnMenu = new Button("Main Menu", 600, 625, 210, 50, #2f7542, #53b86e, 35);
  btnDamageUpgrade = new Button("Select", 755, 330, 100, 40, #2f7542, #53b86e, 25);
  btnHealthUpgrade = new Button("Select", 755, 430, 100, 40, #2f7542, #53b86e, 25);
  btnFRUpgrade = new Button("Select", 760, 530, 100, 40, #2f7542, #53b86e, 25);
  btnSpeedUpgrade = new Button("Select", 730, 630, 100, 40, #2f7542, #53b86e, 25);
  btnYippee = new Button("Yippee!", 600, 760, 120, 50, #2f7542, #53b86e, 30);
  btnSkip = new Button("Skip", 600, 750, 120, 50, #2f7542, #53b86e, 30);
}

void draw() {
  //screen manager
  switch (screen) {
  case "game":
    gameScreen();
    break;
  case "title":
    startScreen();
    break;
  case "settings":
    settingsScreen();
    break;
  case "pause":
    pauseScreen();
    break;
  case "lose":
    gameOver();
    break;
  case "level up":
    levelUp();
    break;
  case "evolution":
    evolution();
    break;
  }
}

void startScreen() {
  background(255);

  fill(0);
  textSize(100);
  //temp
  text("Swarm the Horde!", 600, 130);
  textSize(30);
  text("Humanity's last chances are... guinea pigs!?", 600, 225);

  //rendering buttons
  btnStart.display();
  btnSettings.display();
  btnQuit.display();
}

void gameScreen() {
  //where everything in the game is running
  //only runs if the game isn't over or paused
  if (isGameOver == false && isPaused == false) {
    background(255);
    strokeWeight(1);
    stroke(0);

    player.character = "apricot";

    //rendering player
    player.display();

    if (player.health <= 0) {
      isGameOver = true;
      screen = "lose";
    }

    //random enemy spawning, each enemy is weighted different, sometimes doesn't spawn an enemy
    if (enemyTime.isFinished()) {
      randEnemy = (int)random(0, 10);
      if (randEnemy == 1 || randEnemy == 2 || randEnemy == 3 || randEnemy == 4) {
        enemies.add(new Enemy(random(0, 1300), 0, "red"));
      } else if (randEnemy == 5 || randEnemy == 6 || randEnemy == 7) {
        enemies.add(new Enemy(random(0, 1300), 0, "blue"));
      } else if (randEnemy == 8 || randEnemy == 9) {
        enemies.add(new Enemy(random(0, 1300), 0, "green"));
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
      if (pjct.offScreen()) {
        projectiles.remove(pjct);
      }
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
      exp.display();
      if (exp.intersect(player)) {
        exps.remove(exp);
        println("Exp:" + player.exp);
        //player needs more exp to level up the higher their level is
        if (player.exp >= player.maxExp) {
          level += 1;
          player.maxExp += 20;
          player.exp = 0;
          if (level == 15) {
            screen = "evolution";
          } else {
            screen = "level up";
          }
          println("Max Exp:" + player.maxExp);
        }
      }
    }

    //wave timer
    if (waveTime.isFinished()) {
      wave += 1;
      waveTime.start();
    }
    
    //gamebar
    fill(#fccce9);
    rectMode(CENTER);
    rect(600, 50, 1200, 100);

    fill(255);
    textSize(60);
    text("Wave: " + wave, 150, 40);
    text("Level: " + level, 600, 40);
    
    
  }
}

void levelUp() {
  isPaused = true;
  fill(255);
  rect(600, 500, 450, 600, 20);
  fill(0);
  textSize(50);
  text("Level Up!", 600, 230);
  line(375, 275, 825, 275);
  textSize(30);
  text("+2 Damage" + " " + "(" + playerDamage + "→" + (playerDamage + 2) + ")", 535, 325);
  text("+5 Health" + " " + "(" + player.maxHealth + "→" + (player.maxHealth + 5) + ")", 540, 425);
  text("-0.05 Fire Rate" + " " + "(" + (pTime.totalTime/1000) + "→" + ((pTime.totalTime - 50)/1000) + ")", 548, 525);
  text("+0.3 Speed" + " " + "(" + player.speed + "→" + (player.speed + 0.3) + ")", 530, 625);

  //rendering buttons
  btnDamageUpgrade.display();
  btnHealthUpgrade.display();
  btnFRUpgrade.display();
  btnSpeedUpgrade.display();
  btnSkip.display();
}

void evolution() {
  if (level == 15) {
    isPaused = true;
    fill(255);
    rect(600, 500, 450, 600, 20);
    fill(0);
    textSize(50);
    text("New Evolution!", 600, 235);
    line(375, 275, 825, 275);
    textSize(40);
    text("Demon Rat", 600, 350);
    textSize(30);
    text("+15 Damage", 600, 625);
    text("-0.25 Fire Rate", 600, 665);
    text("+20 Health", 600, 700);



    //rendering buttons
    btnYippee.display();
  }
}

void settingsScreen() {
  background(255);

  fill(0);
  textSize(100);
  //temp
  text("Settings", 600, 110);

  //rendering buttons
  btnBack.display();
}

void pauseScreen() {
}

void gameOver() {
  background(255);

  fill(0);
  textSize(100);
  //temp
  text("You're DEAD.", 600, 110);
  textSize(30);
  text("The world mourns a great hero...", 600, 200);

  //rendering buttons
  btnRestart.display();
  btnMenu.display();
}

void win() {
}

void mousePressed() {
  switch (screen) {
  case "title":
    if (btnStart.clicked()) {
      screen = "game";
      break;
    } else if (btnSettings.clicked()) {
      screen = "settings";
      break;
    } else if (btnQuit.clicked()) {
      exit();
    }
  case "settings":
    if (btnBack.clicked()) {
      screen = "title";
      break;
    }
  case "lose":
    if (btnRestart.clicked()) {
      screen = "game";
      isGameOver = false;
      player.health = 100;
      player.exp = 0;
      player.maxExp = 100;
      level = 1;
      wave = 1;
      break;
    } else if (btnMenu.clicked()) {
      screen = "title";
      isGameOver = false;
      break;
    }
  case "level up":
    if (btnDamageUpgrade.clicked()) {
      for (int i = 0; i < projectiles.size(); i++) {
        Projectile pjct = projectiles.get(i);
        pjct.damage += 2;
      }
      screen = "game";
      isPaused = false;
      playerDamage += 2;
      break;
    } else if (btnHealthUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      player.maxHealth += 5;
      break;
    } else if (btnFRUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      pTime.totalTime -= 100;
      break;
    } else if (btnSpeedUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      player.speed += 0.3;
      break;
    } else if (btnSkip.clicked()) {
      screen = "game";
      isPaused = false;
      break;
    }
  case "evolution":
    if (btnYippee.clicked()) {
      screen = "game";
      isPaused = false;
      if (level == 15) {
        for (int i = 0; i < projectiles.size(); i++) {
          Projectile pjct = projectiles.get(i);
          pjct.damage += 15;
        }
        player.maxHealth += 20;
        pTime.totalTime -= 250;
        playerDamage += 15;
      }
      break;
    }
  }
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

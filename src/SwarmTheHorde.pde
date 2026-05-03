
//Main class

//font
PFont PixelFont;

//screens
String screen = "title"; //title, game, charselect, settings, lose, win, pause, level up, evolution, credits, tutorial

//waves and player level
int wave = 1;
int level = 1;

//game over switch and pause switch
boolean isGameOver = false;
boolean isPaused = false;
boolean gameAlreadyPlayed = false;

//random enemy generation
int randEnemy;

//random food drops
int randFood;

//timers
Timer pTime, enemyTime, waveTime;

//player
Player player;

//stat trackers
float playerDamage; //tracker for projectile damage
float foodHeal = 50; //tracker for food heal amount
float totalDamage = 0;
float totalKills = 0;

//enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//projectiles
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

//exp
ArrayList<Exp> exps = new ArrayList<Exp>();

//food
ArrayList<Food> foods = new ArrayList<Food>();

//buttons
Button btnStart, btnSettings, btnQuit, btnBack, btnMenu, btnRestart, btnResume, btnDamageUpgrade, btnHealthUpgrade, btnFRUpgrade, btnSpeedUpgrade, btnYippee, btnSkip, btnSelectA, btnSelectH, btnTutorial, btnCredits;

void setup() {
  size(1200, 1000);
  background(255);
  pixelDensity(1);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  rectMode(CENTER);

  //set up font
  PixelFont = createFont("PixelFont.ttf", 32);
  textFont(PixelFont);

  //set up player
  player = new Player(600, 500);

  //setup timers
  pTime = new Timer(0); //will get set when player chooses character (in mouse clicked)
  enemyTime = new Timer(3000);
  waveTime = new Timer(60000);

  //button setup, parameters in order are text, x position, y position, width, height, normal color, hovering color, text size
  btnStart = new Button ("Start", 600, 500, 400, 100, #2f7542, #53b86e, 95);
  btnSettings = new Button("Settings", 600, 625, 200, 50, #2f7542, #53b86e, 45);
  btnQuit = new Button("Quit", 600, 700, 150, 50, #2f7542, #53b86e, 45);
  btnBack = new Button("Back", 100, 50, 150, 50, #2f7542, #53b86e, 45);
  btnRestart = new Button("Restart", 600, 500, 400, 100, #2f7542, #53b86e, 85);
  btnMenu = new Button("Main Menu", 600, 625, 210, 50, #2f7542, #53b86e, 45);
  btnResume = new Button("Resume", 600, 700, 210, 50, #2f7542, #53b86e, 45);
  btnDamageUpgrade = new Button("Select", 755, 330, 100, 40, #2f7542, #53b86e, 35);
  btnHealthUpgrade = new Button("Select", 755, 430, 100, 40, #2f7542, #53b86e, 35);
  btnFRUpgrade = new Button("Select", 760, 530, 100, 40, #2f7542, #53b86e, 35);
  btnSpeedUpgrade = new Button("Select", 730, 630, 100, 40, #2f7542, #53b86e, 35);
  btnYippee = new Button("Yippee!", 600, 760, 120, 50, #2f7542, #53b86e, 35);
  btnSkip = new Button("Skip", 600, 750, 120, 50, #2f7542, #53b86e, 40);
  btnSelectA = new Button("Select", 850, 700, 120, 50, #2f7542, #53b86e, 40);
  btnSelectH = new Button("Select", 350, 700, 120, 50, #2f7542, #53b86e, 40);
  btnTutorial = new Button ("Tutorial", 600, 450, 400, 100, #2f7542, #53b86e, 95);
  btnCredits = new Button ("Credits", 600, 650, 400, 100, #2f7542, #53b86e, 95);
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
  case "charselect":
    characterSelect();
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
  case "win":
    win();
    break;
  case "level up":
    levelUp();
    break;
  case "evolution":
    evolution();
    break;
  case "tutorial":
    tutorialScreen();
    break;
  case "credits":
    creditsScreen();
    break;
  }
}

void startScreen() {
  background(255);

  fill(0);
  textSize(130);
  //temp
  text("Swarm the Horde!", 600, 130);
  textSize(40);
  text("Humanity's last chances are... guinea pigs!?", 600, 220);

  //rendering buttons
  btnStart.display();
  btnSettings.display();
  btnQuit.display();
}

void characterSelect() {
  background(255);

  fill(0);
  textSize(100);
  text("Select Your Character!", 600, 130);
  textSize(60);
  text("Fat Rat", 350, 320);
  text("Moldy Rat", 850, 320);
  textSize(40);
  text("Damage, Health", 350, 775);
  text("Fire Rate, Move Speed", 850, 775);

  //rendering buttons
  btnBack.display();
  btnSelectA.display();
  btnSelectH.display();
}

void gameScreen() {
  //where everything in the game is running
  //only runs if the game isn't over or paused
  if (isGameOver == false && isPaused == false) {
    background(255);
    strokeWeight(1);
    stroke(0);
    imageMode(CENTER);

    //rendering player
    player.display();

    

    if (player.health <= 0) {
      isGameOver = true;
      screen = "lose";
    }
    
    if (wave == 16) {
      isPaused = true;
      screen = "win";
    }

    //random enemy spawning, each enemy is weighted differently based on waves
    if (enemyTime.isFinished()) {
      randEnemy = (int)random(1, 11);
      if (wave <= 3) {
        enemies.add(new Enemy(random(0, 1300), 0, "blue"));
      } else if (wave == 4) {
        if (randEnemy <= 5) {
          enemies.add(new Enemy(random(0, 1300), 0, "blue"));
        } else {
          enemies.add(new Enemy(random(0, 1300), 0, "red"));
        }
      } else if (wave > 5 && wave <= 7) {
        enemies.add(new Enemy(random(0, 1300), 0, "red"));
      } else if (wave > 7 && wave <= 9) {
        if (randEnemy <= 2) {
          enemies.add(new Enemy(random(0, 1300), 0, "green"));
        } else {
          enemies.add(new Enemy(random(0, 1300), 0, "red"));
        }
      } else if (wave == 10) {
        enemies.add(new Enemy(random(0, 1300), 0, "green"));
      } else if (wave == 11) {
        if (randEnemy <= 4) {
          enemies.add(new Enemy(random(0, 1300), 0, "black"));
        } else {
          enemies.add(new Enemy(random(0, 1300), 0, "green"));
        }
      } else if (wave > 11 && wave <= 13) {
        enemies.add(new Enemy(random(0, 1300), 0, "black"));
      } else if (wave > 13 && wave <= 15) {
        enemies.add(new Enemy(random(0, 1300), 0, "pink"));
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
          enemy.health -= playerDamage;
          if (enemy.health <= 0) {
            exps.add(new Exp(enemy.x, enemy.y, "tier1"));
            enemies.remove(enemy);

            randFood = int(random(1, 61)); //has a 1/60 chance to spawn food when enemy dies
            if (randFood == 1) {
              foods.add(new Food(enemy.x + 20, enemy.y + 20));
            }
          }
          projectiles.remove(pjct);
        }
      }
      pjct.display();
    }

    //rendering food and check for intersection
    for (int f = 0; f < foods.size(); f++) {
      Food food = foods.get(f);
      food.display();
      if (food.intersect(player)) {
        foods.remove(food);
        player.health += foodHeal;
        println(player.health);
      }
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
          player.maxExp += 150;
          player.exp = 0;
          if (level == 15 || level == 25 || level == 35 || level == 45 || level == 55) {
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
      enemyTime.totalTime -= 200;
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
  text("+2 Damage" + " " + "(" + playerDamage + " " + "-" + " " + (playerDamage + 2) + ")", 535, 330);
  text("+5 Health" + " " + "(" + player.maxHealth + " " + "-" + " " + (player.maxHealth + 5) + ")", 540, 430);
  text("-0.03 Fire Rate" + " " + "(" + (pTime.totalTime/1000) + " " + "-" + " " + ((pTime.totalTime - 30)/1000) + ")", 548, 530);
  text("+0.3 Speed" + " " + "(" + player.speed + " " + "-" + " " + (player.speed + 0.3) + ")", 530, 630);

  //rendering buttons
  btnDamageUpgrade.display();
  btnHealthUpgrade.display();
  btnFRUpgrade.display();
  btnSpeedUpgrade.display();
  btnSkip.display();
}

void evolution() {
  isPaused = true;
  fill(255);
  rect(600, 500, 450, 600, 20);
  fill(0);
  textSize(50);
  text("New Evolution!", 600, 235);
  line(375, 275, 825, 275);
  textSize(40);
  if (player.character == "hank") {
    if (level == 15) {
      text("Flabbergasted Rat", 600, 350);
      textSize(30);
      text("+15 Damage", 600, 625);
      text("-0.25 Fire Rate", 600, 665);
      text("+20 Health", 600, 700);
    } else if (level == 25) {
      text("Ball Rat", 600, 350);
      text("+20 Damage", 600, 625);
      text("-0.25 Fire Rate", 600, 665);
      text("+20 Health", 600, 700);
    } else if (level == 35) {
      text("Chicken Rat", 600, 350);
      text("+25 Damage", 600, 625);
      text("-0.25 Fire Rate", 600, 665);
      text("+20 Health", 600, 700);
    } else if (level == 45) {
      text("Logarithmic Rat", 600, 350);
      text("+30 Damage", 600, 625);
      text("-0.25 Fire Rate", 600, 665);
      text("+25 Health", 600, 700);
    } else if (level == 55) {
      text("Demon Rat", 600, 350);
      text("+40 Damage", 600, 625);
      text("-0.25 Fire Rate", 600, 665);
      text("+30 Health", 600, 700);
    }
  } else if (player.character == "apricot") {
    if (level == 15) {
      text("Seasoned Rat", 600, 350);
      textSize(30);
      text("+10 Damage", 600, 625);
      text("-0.30 Fire Rate", 600, 665);
      text("+15 Health", 600, 700);
    } else if (level == 25) {
      text("Sleepy Rat", 600, 350);
      text("+10 Damage", 600, 625);
      text("-0.35 Fire Rate", 600, 665);
      text("+15 Health", 600, 700);
    } else if (level == 35) {
      text("Blurry Rat", 600, 350);
      text("+10 Damage", 600, 625);
      text("-0.35 Fire Rate", 600, 665);
      text("+15 Health", 600, 700);
    } else if (level == 45) {
      text("Croissant Rat", 600, 350);
      text("+10 Damage", 600, 625);
      text("-0.35 Fire Rate", 600, 665);
      text("+15 Health", 600, 700);
    } else if (level == 55) {
      text("Rotisserie Rat", 600, 350);
      text("+20 Damage", 600, 625);
      text("-0.45 Fire Rate", 600, 665);
      text("+20 Health", 600, 700);
    }
  }
  //rendering buttons
  btnYippee.display();
}

void settingsScreen() {
  background(255);

  fill(0);
  textSize(130);
  //temp
  text("Settings", 600, 130);

  //rendering buttons
  btnBack.display();
  btnTutorial.display();
  btnCredits.display();
}

void tutorialScreen() {
  background(255);

  fill(0);
  textSize(130);
  //temp
  text("Tutorial", 600, 130);
  textSize(40);
  text("Defeat enemies and collect EXP drops! Use your mouse to aim.", 600, 300);
  text("Once enough EXP is collected, you can upgrade one of your stats.", 600, 400);
  text("There will be different evolutions that are unlocked once your level is high\nenough, each character has unique ones!", 600, 525);
  text("Enemies will progressive get harder as the waves go\n on, allocate your stats wisely!", 600, 650);
  text("You will achieve victory once you have survived\n 15 waves (about 15 minutes).", 600, 800);

  //rendering buttons
  btnBack.display();
}

void creditsScreen() {
  background(255);

  fill(0);
  textSize(130);
  //temp
  text("Credits", 600, 130);
  textSize(70);
  text("Made by Angie Liu!", 600, 500);

  //rendering buttons
  btnBack.display();
}

void pauseScreen() {
  background(255);

  fill(0);
  textSize(130);
  text("Paused", 600, 130);

  //rendering buttons
  btnRestart.display();
  btnMenu.display();
  btnResume.display();
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
  background(255);

  fill(0);
  textSize(100);
  //temp
  text("You have made history!", 600, 110);
  textSize(30);
  text("As the world's first guinea pig to stop the end of human exsistance, you will be honored, Hero!", 600, 200);

  //rendering buttons
  btnRestart.display();
  btnMenu.display();
}

//used to reset the game
void reset () {
  isGameOver = false;
  isPaused = false;
  if (player.character == "hank") {
    player.health = 120;
    player.maxHealth = 120;
    playerDamage = 20;
    player.speed = 4;
    pTime.totalTime = 3200;
  } else if (player.character == "apricot") {
    player.health = 90;
    player.maxHealth = 90;
    playerDamage = 13;
    player.speed = 5.5;
    pTime.totalTime = 2700;
  }
  player.x = 600;
  player.y = 500;
  player.exp = 0;
  player.maxExp = 100;
  level = 1;
  wave = 1;
  projectiles.clear();
  enemies.clear();
  exps.clear();
  pTime.start();
  enemyTime.start();
  waveTime.start();
}

void mousePressed() {
  switch (screen) {
  case "title":
    if (btnStart.clicked()) {
      screen = "charselect";
      //only called reset if game has been played already
      if (gameAlreadyPlayed) {
        reset();
      }
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
    } else if (btnTutorial.clicked()) {
      screen = "tutorial";
      break;
    } else if (btnCredits.clicked()) {
      screen = "credits";
      break;
    }
  case "tutorial":
    if (btnBack.clicked()) {
      screen = "settings";
      break;
    }
  case "credits":
    if (btnBack.clicked()) {
      screen = "settings";
      break;
    }
  case "charselect":
    if (btnSelectA.clicked()) {
      screen = "game";
      player.character = "apricot";
      reset();
      gameAlreadyPlayed = true;
      break;
    } else if (btnSelectH.clicked()) {
      screen = "game";
      player.character = "hank";
      reset();
      gameAlreadyPlayed = true;
      break;
    } else if (btnBack.clicked()) {
      screen = "title";
      break;
    }
  case "lose":
    if (btnRestart.clicked()) {
      screen = "game";
      reset();
      break;
    } else if (btnMenu.clicked()) {
      screen = "title";
      isGameOver = false;
      break;
    }
  case "win":
    if (btnRestart.clicked()) {
      screen = "game";
      reset();
      break;
    } else if (btnMenu.clicked()) {
      screen = "title";
      break;
    }
  case "pause":
    if (btnRestart.clicked()) {
      screen = "game";
      reset();
      break;
    } else if (btnMenu.clicked()) {
      screen = "title";
      isGameOver = false;
      break;
    } else if (btnResume.clicked()) {
      screen = "game";
      isPaused = false;
      break;
    }
  case "level up":
    if (btnDamageUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      playerDamage += 2;
      break;
    } else if (btnHealthUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      if (player.health == player.maxHealth) {
        player.health += 5;
      }
      player.maxHealth += 5;
      break;
    } else if (btnFRUpgrade.clicked()) {
      screen = "game";
      isPaused = false;
      pTime.totalTime -= 30;
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

      if (player.character == "hank") {
        if (level == 15) {
          player.maxHealth += 20;
          pTime.totalTime -= 250;
          playerDamage += 15;
        } else if (level == 25) {
          player.maxHealth += 20;
          pTime.totalTime -= 250;
          playerDamage += 20;
        } else if (level == 35) {
          player.maxHealth += 20;
          pTime.totalTime -= 250;
          playerDamage += 25;
        } else if (level == 45) {
          player.maxHealth += 25;
          pTime.totalTime -= 250;
          playerDamage += 30;
        } else if (level == 55) {
          player.maxHealth += 30;
          pTime.totalTime -= 250;
          playerDamage += 40;
        }
      } else if (player.character == "apricot") {
        if (level == 15) {
          player.maxHealth += 15;
          pTime.totalTime -= 300;
          playerDamage += 10;
        } else if (level == 25) {
          player.maxHealth += 15;
          pTime.totalTime -= 350;
          playerDamage += 10;
        } else if (level == 35) {
          player.maxHealth += 15;
          pTime.totalTime -= 350;
          playerDamage += 10;
        } else if (level == 45) {
          player.maxHealth += 15;
          pTime.totalTime -= 350;
          playerDamage += 10;
        } else if (level == 55) {
          player.maxHealth += 20;
          pTime.totalTime -= 450;
          playerDamage += 20;
        }
      }
      //testing
      println(player.maxHealth);
      println(pTime.totalTime);
      println(playerDamage);
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
  if (screen == "game") {
    if (keyCode == 9) {
      isPaused = true;
      screen = "pause";
    }
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

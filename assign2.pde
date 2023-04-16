
PImage Spaceship;
PImage Hb;
PImage Treasure;
PImage Enemy;
PImage Bg1;
PImage Bg2;
PImage startNormal;
PImage startHover; 
PImage lose;
PImage restart;

//Define game states
final int GAME_START = 1;
final int GAME_RUN = 2;
final int GAME_LOSE = 3;
int gameState = GAME_START;

int x, y, s;
int bg1X, bg2X;

//Spaceship position and speed
int SpaceshipX = 450;
int SpaceshipY = 140;
int SpaceshipSpeed = 20;

//Player health 
int health = 100;

//Health bar dimensions 
int barWidth = 40;
int barHeight = 5;

void setup()
{
  //CanvasSize
  size(504,336);
  
  startNormal = loadImage("start1.png");
  startHover = loadImage("start2.png");
  lose = loadImage("end1.png");
  restart = loadImage("restart.png");
  
  //Backgrounds
  Bg1 = loadImage("bg1.png");
  Bg2 = loadImage("bg2.png");
  
  // position x of backgrounds 
  bg1X = 0; 
  bg2X = -504;

  //Spaceship
  Spaceship = loadImage("Spaceship.png");

  //HealthBarEmpty
  Hb = loadImage("Hb.png");

  //Treasure
  Treasure = loadImage("Treasure.png");
  x = floor(random(25,450));
  y = floor(random(25,280));
 
  //Enemy
  Enemy = loadImage("Enemy.png");
  s = -Enemy.width;
}

void draw(){  
  //Backgrounds
  background(0);

  //all game states 
  if (gameState == GAME_START){
    //draw start screen
    image(startNormal,0,0);
  } else if (gameState == GAME_RUN){

    //show backgrounds
    image(Bg1,bg1X,0);
    image(Bg2,bg2X,0);

    //scroll the backgrounds
    bg1X++;
    bg2X++;
    if (bg1X>=504){
      bg1X = -504;
    } 
    if (bg2X>=504){
      bg2X = -504;
    }
  
    //Spaceship
    image(Spaceship,SpaceshipX, SpaceshipY);

    //Health Bar
    image(Hb, 10, 10);
    int barLenght = (health * barWidth) / 100;
    rect(13,13,barWidth, barHeight);
    fill(#D90429);
    rect(13,13, barLenght, barHeight);

    //Treasure
    image(Treasure,x,y);
  
    //Enemy
    image(Enemy,s,100);
    s +=1;
    if (s > width) {
      s = -Enemy.width;
    }

    //Collisions between Spaceship and enemy
    if (collideAABB(SpaceshipX, SpaceshipY, Spaceship.width, Spaceship.height, s, 100, Enemy.width, Enemy.height)) {
      health -= 20; // Player loses 20 health points when hit by enemy
      s = -Enemy.width; // Enemy reappears on the left side of the screen
    }

    //Collision between Spaceship and treasure
    if (collideAABB(SpaceshipX, SpaceshipY, Spaceship.width, Spaceship.height, x, y, Treasure.width, Treasure.height)){
      health += 10;
      s = -Treasure.width;
    }
    
    //If HealthBar is zero or less
    if (health <= 0) {
      gameState = GAME_LOSE;
    }
  }
}

void keyPressed(){
  // Check key presses to change game state
  if (keyCode == '1') {
    if (gameState == GAME_START || gameState == GAME_LOSE) {
      // Start or restart the game
      gameState = GAME_RUN;
    }
  } else if (keyCode == '2') {
    if (gameState == GAME_RUN) {
      // Pause the game
      gameState = GAME_START;
    }
  } else if (keyCode == '3') {
    if (gameState == GAME_RUN) {
      // End the game and show lose screen
      gameState = GAME_LOSE;
    }
  }
}

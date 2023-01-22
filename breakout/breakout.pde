// Breakout by Jasmine Nelson

// variables to keep track of x and y position an size of the ball
int ballX = 300 + int(random(-50, 50)); //ball starts at random angle each game
int ballY = 400;
int ballSize = 10;
// variables to keep track of speed of the ball
int xSpeed = 2;
int ySpeed = -2;
// variables to keep track of x and y position and size of the paddle
int paddleX = 300, paddleY = 420;
int paddleWidth = 75;
int paddleHeight = 10;
// array to keep track of the blocks
int[] blocks = new int[30];
// variables to track the score, level, and game screen
int score = 0;
int level = 1;
int wait = 0;
int gameScreen = 0;
// make fonts
PFont bitwise;
PFont start;
// other
boolean gameStart = false;
boolean keyMode = false;
boolean mouseMode = false;
boolean secret = false;
boolean easy = false;
boolean normal = false;
boolean hard = false;
boolean extreme = false;
boolean next = false;
int j = int(random(1,6));

void setup() {
  int i;
  size(600, 500);
  bitwise = loadFont("bitwise-100.vlw");
  start = loadFont("PressStartReg-50.vlw");

  // initialize blocks
  for (i=0; i<30; i++) {
    blocks[i] = 1;
  }
}

void draw() {
  int i;
  int blockX; //block x position
  int blockY; //block y position
  int levelCleared;

  //random color scheme every time the program is run
  int a=1, b=1, c=1;
  if (j==1) {a=2; b=4; c=6;} 
  else if (j==2) {a=2; b=6; c=4;}
  else if (j==3) {a=4; b=2; c=6;} 
  else if (j==4) {a=4; b=6; c=2;} 
  else if (j==5) {a=6; b=2; c=4;} 
  else if (j==6) {a=6; b=4; c=2;}

  // display the contents of the current screen
  if (gameScreen == 0) {
    mainMenu();
  } else if (gameScreen == 1) {
    modeSelect();
  } else if (gameScreen == 2) {
    diffSelect();
  }
  
  // start at the main screen 
  gameScreen = 0;

  // for the "main menu" screen
  if (mousePressed && gameScreen == 0) {
    if (gameScreen == 0 && mouseX > width/2-115 && mouseX < width/2+115 &&
      mouseY>310 && mouseY < 390) {
      gameStart = true;
    }
  }
  if (keyPressed && gameScreen == 0) { 
    if (gameScreen == 0 && key == ENTER || key == 10) {
      gameStart = true;
    }
  }
  if (gameStart==true) {
    gameScreen = 1; // go to the next screen
  } 

  // for the "select game mode" screen
  if (mousePressed && gameScreen == 1) {
    if  (gameScreen == 1 && mouseX > 30 && mouseX < 200 && mouseY>300 && mouseY < 370) {
      mouseMode = true;
      next = true;
    }
    if  (gameScreen == 1 && mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
      secret = true;
    }
  }
  if (keyPressed && gameScreen == 1) { 
    if (key == 'k' || key == 'K') {
      keyMode = true;
      next = true;
    }
  }
  if (next == true) {
    gameScreen = 2; // go to the next screen
  } 
  if (secret == true) {
    gameScreen = 3; 
  } 

  // for the "select difficulty" screen
  if (mousePressed && gameScreen == 2) {
    if (gameScreen == 2  && mouseX > 45 && mouseX < 195 && mouseY > 160 && mouseY < 240) {
      easy = true;
    } else if (gameScreen == 2 && mouseX > 225 && mouseX < 378 && mouseY > 160 && mouseY < 240) {
      normal = true;
    } else if (gameScreen == 2 && mouseX > 405 && mouseX < 558 && mouseY > 160 && mouseY < 240) {
      hard = true;
    } else if (gameScreen == 2 && mouseX > 210 && mouseX < 392 && mouseY > 270 && mouseY < 355) {
      extreme = true;
    }
  }
  if (keyPressed && gameScreen == 2) {
    if (key == 'e' || key == 'E') {
      easy = true;
    } else if (key == 'n' || key == 'N') {
      normal = true;
    } else if (key == 'h' || key == 'H') {
      hard = true;
    } else if (key == 'x' || key == 'X') {
      extreme = true;
    }
  }
  if (gameScreen == 2 && easy==true || normal==true || hard==true || extreme==true) {
    gameScreen = 3; //go to the next screen
  } 

  // display the game
  if (gameScreen == 3) {
    background(0);
    fill(255);
    stroke(0);
    rectMode(CENTER);
    textFont(start);

    // show score
    textAlign(LEFT); // without this, the "score" text moves after a Game Over
    textSize(10);
    text("Score: ", 10, 490);
    text(score, 70, 490);
    // show current level
    text("Level", 10, 470);
    text(level, 65, 470);

    // draw ball
    ellipse(ballX, ballY, ballSize, ballSize);

    // draw paddle
    if (easy==true) {
      paddleWidth=100;
    } else if (normal==true) {
      paddleWidth=75;
    } else if (hard==true) {
      paddleWidth=50;
    } else if (extreme==true) {
      paddleWidth=25;
    }
    rect(paddleX, paddleY, paddleWidth, paddleHeight);

    // update ball position by adding speed
    ballX = ballX + xSpeed;
    ballY = ballY + ySpeed;

    // if the ball touches the sides of screen
    if (ballX>width-(ballSize/2) || ballX<0+(ballSize/2)) {  
      xSpeed = -xSpeed;
    }
    // if the ball touches the top of screen
    if (ballY<0+(ballSize/2)) {
      ySpeed = -ySpeed;
    }
    // if the ball goes past bottom of screen
    if (ballY>height) {
      textSize(40);
      textAlign(CENTER);
      text("GAME OVER :(", 300, 300);
      fill(150);
      textSize(10);
      textAlign(LEFT);
      text("Click anywhere or press R/SPACE to restart", 110, 490);
    }
    // if the ball touches the paddle
    if ((paddleX-((paddleWidth/2)+2))<ballX && (paddleX+((paddleWidth/2)+2))>ballX && 
      (paddleY-ballSize)<ballY && (paddleY)>ballY) {
      ySpeed = -ySpeed; // reverse ySpeed to change direction of ball
      score = score + 1;
      //println("boop");
    }

    //allow the user to play using the keyboard
    if (keyMode==true) {
      // set playable keys (can use A and D or LEFT and RIGHT arrow keys)
      if (keyPressed) { // if I used the keyPressed() method, the paddle moves very slow
        if (keyCode == RIGHT || key == 'd' || key == 'D') {
          // move paddle right
          paddleX = paddleX + (4 + (level));
        } else if (keyCode == LEFT || key == 'a' || key == 'A') {
          // move paddle left
          paddleX = paddleX - (4 + (level));
        }
      }
    }
    //allow the user to play using the mouse
    if (mouseMode==true) {
      paddleX = mouseX; 
    }
    // game plays itself (eventually loses at level 9, but still entertaining)
    if (secret==true) {
      paddleX = ballX; 
    }

    levelCleared = 1; // initializes all blocks as "cleared" before they're drawn
    
    // loop for all the blocks
    for (i=0; i<30; i++) {
      // x and y position of upper right corner of each block
      blockX = i%6*100+10; // i%6 will make 6 rows
      blockY = 40*(i/6)+10; 
      
      // if the block exists
      if (blocks[i]==1) { 
        // draw block
        fill(color(100+(i*a*level), 100+(i*b*level), 100+(i*c*level))); // changes each level
        rect(blockX+40, blockY+10, 80, 25);
        levelCleared = 0; /* because the block is drawn, it's not gone. when a block is removed
         with blocks[i]=0, "levelCleared = 0" is no longer true. "if (blocks[i]==1)" checks if 
         there are blocks, so if there are none, it defaults back to levelCleared=1, indicating 
         that the level is completed */
      }

      // check if the ball touches top/bottom of block
      if (ballX>(blockX-1) && ballX<(blockX+81) && // check if the ball is within the x-range
        ballY>blockY-5 && ballY<(blockY+25) && blocks[i]==1) { // check if ball is over/under block
        blocks[i]=0; // remove the block
        ySpeed = -ySpeed; // change to opposite y direction
        score = score + 5; //add 5 points
      }
      // check if the ball touches sides
      if (((ballX>(blockX-5) && ballX<blockX) || (ballX>(blockX+80) && ballX<(blockX+85))) &&
        ballY>blockY-5 && ballY<(blockY+25) && blocks[i]==1) { 
        blocks[i]=0;
        xSpeed = -xSpeed; // change to opposite x direction
        score = score + 5;
      }
    }
    
    // if the level is cleared
    if (levelCleared==1 && wait<400) { // wait allows there to be time between levels
      textSize(40);
      textAlign(CENTER);
      fill(random(0, 255), random(0, 255), random(0, 255));
      text("YOU WIN", 300, 250);
      // stop the ball from moving
      xSpeed = 0;
      ySpeed = 0;
      wait++; // wait increases = time goes by
      if (wait>150 && wait<400) {
        fill(255);
        textSize(25);
        text("LOADING LEVEL " + (level+1), 300, 330);
        wait++;
      }
      if (wait==400) { // goes to next level
        wait = 0;
        ballX = 300 + int(random(-50, 50));
        ballY = 400;
        // speed increases by level (ex: level 2 speed is 4, level 3 speed is 5, etc.)
        xSpeed = 2+level;  
        ySpeed = -2-level;
        paddleX = 300;
        level++;
        // put all blocks back on the screen
        for (i=0; i<30; i++) {
          blocks[i] = 1;
        }
      }
    }
  }
}

// creates Main Menu screen
void mainMenu() {
  int a=1, b=1, c=1;
  if (j==1) {a=2; b=4; c=6;} 
  else if (j==2) {a=2; b=6; c=4;}
  else if (j==3) {a=4; b=2; c=6;} 
  else if (j==4) {a=4; b=6; c=2;} 
  else if (j==5) {a=6; b=2; c=4;} 
  else if (j==6) {a=6; b=4; c=2;}
  background(0);
  fill(150);
  textFont(start);
  textSize(12);
  text("Click PLAY or press ENTER", 150, 490);
  fill(255);
  textFont(bitwise);
  textSize(100);
  text("Breakout", 100, 200);
  textSize(35);
  text("By Jasmine Nelson", 160, 250);
  rectMode(CENTER);
  fill(255);
  if (mouseX > width/2-115 && mouseX < width/2+115 &&
    mouseY>310 && mouseY < 390) {
    //PLAY button color changes depending on color scheme
    fill(color(100+(30*a), 100+(30*b), 100+(30*c)));
  } else {
    fill(255);
  }
  rect(width/2, height/2+100, 230, 80);
  fill(0);
  textFont(start);
  textSize(48);
  text("PLAY", width/2-90, height/2+120);
}

// creates Select Mode screen
void modeSelect() {
  background(0);
  fill(255);
  textFont(bitwise);
  textSize(60);
  text("Select Game Mode", 60, 80);
  rectMode(CORNER);
  rect(30, 160, 170, 70);
  rect(30, 300, 170, 70);
  textFont(start);
  textSize(15);
  text("Move the paddle with the \n \narrow keys or A and D", 215, 180);
  text("Move the paddle with the \n \nmouse", 215, 320);
  fill(0);
  textSize(20);
  text("KEYBOARD", 38, 205);
  textSize(30);
  text("MOUSE", 42, 350);
  fill(150);
  textSize(12);
  text("Press K for Keyboard | Click MOUSE for Mouse", 40, 490);

  fill(0);
  if (mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
    stroke(255);
  } else {
    stroke(0);
    fill(0);
  }
  rect(520, 10, 70, 30);
  if (mouseX > 520 && mouseX < 590 && mouseY > 10 && mouseY < 45) {
    fill(255);
  } else {
    fill(0);
  }
  textSize(10);
  text("SECRET", 527, 30);
}

// creates Difficulty Select screen
void diffSelect() {
  background(0);
  fill(255);
  //stroke(255);
  textFont(bitwise);
  textSize(60);
  text("Select Difficulty", 90, 80);
  rectMode(CORNER);
  rect(45, 160, 150, 80);
  rect(225, 160, 150, 80);
  rect(405, 160, 150, 80);

  rect(210, 270, 180, 80);
  textFont(start);
  fill(0);
  textSize(35);
  text("EASY", 50, 215);
  text("HARD", 415, 215);
  textSize(24);
  text("NORMAL", 230, 210);
  fill(200, 0, 0);
  text("EXTREME", 217, 320);
  fill(150);
  textSize(12);
  text("Click any difficulty", 180, 470);
  textSize(9.8);
  text("Press E for Easy, N for Normal, H for Hard, or X for Extreme", 10, 490);

   if (mouseX > 210 && mouseX < 392 && mouseY > 270 && mouseY < 355) {
    stroke(255, 0, 0);
  } else {
    stroke(255);
  }
}

void keyPressed() {
  int i;
  //restart if user presses SPACE or R during the game
  if (gameScreen == 3 && key == ' ' || key == 'r' || key == 'R') {
    // restart the game (positions, speed, score, level)
    ballX = 300 + int(random(-50, 50));
    ballY = 400;
    paddleX = 300;
    xSpeed = 2;
    ySpeed = -2;
    score = 0;
    level = 1;
    //sometimes paddleWidth would go to 100 after the game restarts, even if it wasn't on Easy
    if (easy==true) {
      paddleWidth=100;
    } else if (normal==true) {
      paddleWidth=75;
    } else if (hard==true) {
      paddleWidth=50;
    } else if (extreme==true) {
      paddleWidth=25;
    }
    // put all the blocks back
    for (i=0; i<30; i++) {
      blocks[i] = 1;
    }
  }
}

void mouseClicked() {
  int i;
  //restart if user clicks on the screen during the game
  if (gameScreen == 3 && mouseX > 0 && mouseX < width &&
    mouseY>0 && mouseY < height) {
    // restart the game (positions, speed, score, level)
    ballX = 300 + int(random(-50, 50));
    ballY = 400;
    paddleX = 300;
    xSpeed = 2;
    ySpeed = -2;
    score = 0;
    level = 1;
    //sometimes paddleWidth would go to 100 after the game restarts, even if it wasn't on Easy
    if (easy==true) {
      paddleWidth=100;
    } else if (normal==true) {
      paddleWidth=75;
    } else if (hard==true) {
      paddleWidth=50;
    } else if (extreme==true) {
      paddleWidth=25;
    }
    // put all the blocks back
    for (i=0; i<30; i++) {
      blocks[i] = 1;
    }
  }
}

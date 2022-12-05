pet petSim;
food feeder;
PImage petSheet, background, dabSprite;
PImage[] pSprites = new PImage[4];
int targetTimer = millis();
int scale = 4;
int gameState = 4;
int mgState = 0;
int dabloons = 150;
int petIndex = 0;
void setup() {
  fullScreen(); //size(640, 1366);
  orientation(PORTRAIT);
  for (int i = 0; i < pSprites.length; i++) {
    pSprites[i] = loadImage("Sheet"+i+".png");
    pSprites[i].resize(160, 160);
  }
  petSheet = loadImage("Sheet0.png");
  background = loadImage("background.jpg");
  dabSprite = loadImage("dabloons.png");
  petSheet.resize(212*scale, 240*scale);
  background.resize(width, height);
  dabSprite.resize(567/scale, 567/scale);
  petSim = new pet();
  feeder = new food();
  feeder.feeding();
}
void draw() {
  background(0);
  if (petSim.energy > 0) {
    image(background, 0, 0);
    if (gameState == 4) { //default state
      petSim.update();
      petSim.display();
      if (mgState == 1) {// feed da doggo minigame
        feeder.FG();
      }
    } else if (gameState == 0) { // minigames
      fill(0);
      for (int i = 0; i < 3; i++) { // game buttons.
        rect(0, 20+400*i, width, 300, 20) ;
      }
      rect(20, height-110, 300, 90); //return button display
      fill(255);
      textSize(50);
      text("return", 90, height-50);
      text("FEED DA DOGGO", width/2-150, 190);
      text("COMING SOON", width/2-150, 570);
      text("COMING SOON", width/2-150, 970);
    } else if (gameState == 1) { // Sprite shop
      for (int x = 0; x < pSprites.length/2; x++) { // two loops to display images poth vertically and horizontally
        for (int y= 0; y < pSprites.length/2; y++) {
          image(pSprites[x+y*2], 350+300*x, 100+300*y);
        }
      }   
      fill(0);
      rect(20, height-110, 300, 90); //return button display
      fill(255);
      textSize(50);
      text("return", 90, height-50);
    } else if (gameState == 2) {
      gameState = 4; // to make sure that you dont get softlocked
    }
  } else {
    textSize(40);
    text("you have run out of energy. please put down your phone and go outside. until you can play again :)", 15, 150, 630, 1366);
    textSize(60);
    text("exit", 260, height-12); //rect(260,height-12,200,200); are the parameters for the exit button.
  }
}
void mousePressed() {
  println(mouseX, mouseY);
  if (petSim.energy > 0) {
    if (gameState == 4) { //default state
      petSim.touch();
    } else if (gameState == 0) { // minigames
      for (int i = 0; i < 3; i++) { 
        if (mouseX<width && mouseX>0 && mouseY<300+20+400*i && mouseY>20+400*i && dabloons >= 25) { // feed the dog minigame. intiate
          int index = int(i*1+1);
          mgState = index;
          dabloons = dabloons - 25;
          if (mgState == 1) {          
            gameState = 4;
          }
        }
      }
      if (mouseX<300+20 && mouseX>20 && mouseY<90+height-110 && mouseY>height-90) { // minigame return button
        gameState = 4;
      }
    } else if (gameState == 1) {
      if (mouseX<300+20 && mouseX>20 && mouseY<90+height-110 && mouseY>height-90) { // Shop return button
        gameState = 4;
      }
      for (int x = 0; x < pSprites.length/2; x++) { // shop buttons
        for (int y= 0; y < pSprites.length/2; y++) {
          if (mouseX<160+350+300*x && mouseX>350+300*x && mouseY<160+100+300*y && mouseY>100+300*y) { // image(pSprites[x+y*2], 350+300*x, 100+300*y); 
            petIndex = (x+y*2);
            gameState = 4;
          }
        }
      }
    } else if (gameState == 2) {
    }
  }
  if (mouseX<260+200 && mouseX>260 && mouseY<height-12+200 && mouseY>height-12) { // exit button
    exit();
  }
}

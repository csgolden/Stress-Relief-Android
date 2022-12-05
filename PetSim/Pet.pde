class pet {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  float topspeed;
  float affection;
  int pets;
  int love;
  int energy;
  boolean petted = false;
  boolean flip = false;
  pet() {location = new PVector(random(640), random(838, 1366));
    velocity = new PVector(1, 1);
    target = new PVector(random(640), random(838, 1366));
    pets = 0;
    love = 0;
    energy = 100;
    topspeed = 2;
    affection = 0;
  }
  void update() {
    if (millis()>targetTimer + 10000 && petted == false) {
      target = new PVector(random(640), random(838, 1366));
      targetTimer = millis();
    }
    if (dist(location.x, location.y, target.x, target.y) > 5) {
      PVector dir = PVector.sub(target, location);  // vector pointing towards target
      dir.normalize();     // Normalize
      dir.mult(0.5);       // Scale
      acceleration = dir;  // Set to acceleration   
      //Velocity changes by acceleration.  Location changes by velocity.
      velocity.add(acceleration);
      velocity.limit(topspeed);
      location.add(velocity);
      if (dir.x < 0) {
        flip = true;
      } else {
        flip = false;
      }
    }
    if (petted) {
      location.x = mouseX;
      location.y = mouseY;
    }
  }

  void display() {
    fill(0);
    textSize(35);
    if (petted) {//ellipse(location.x, location.y, 120, 120);
      image(petSheet.get(0, 800, 160, 180), location.x-80, location.y-80);
    } else {
      if (flip == false) {
        pushMatrix();
        scale(1, 1);
        if(petIndex == 0){
        image(petSheet.get(0, 650, 160, 136), location.x-80, location.y-80);        
        }else{
        image(pSprites[petIndex],location.x-80,location.y-80); 
        }
        popMatrix();
        
      } else if (flip) {
        pushMatrix();
        scale(-1, 1);
        if(petIndex == 0){
        image(petSheet.get(0, 650, 160, 136), -location.x-80, location.y-80); // filps the sprite if target.x = -;
        }else{
        image(pSprites[petIndex],location.x-80,location.y-80); 
        }
        popMatrix();
      }
    }
    for (int i = 0; i < 3; i++) { 
      rect(40+360*i, 20, 290, 130, 20); // Three top buttons.
    }
    fill(#FFFE00);
    rect(10, height-140, map(energy, 0, 100, 0, width-20), 75, 20); // energy bar
    image(dabSprite, 40, 160);
    fill(0);
    text("Energy", 20, height-90);
    fill(255); 
    text("aff "+ nfc(affection, 2), 25, height-190);
    text("pats "+pets, 150, height-240);
    text("love "+love, 25, height-240);
    textSize(50);
    text(""+dabloons,200,240);
    text("Mini Games", 50, 100);
    text("shop",480,100);
    
    if (affection >= 99) {
      affection = 0;
      love++;
      energy = energy - 5;
    }
  }
  void touch() {
    if (mousePressed && sq(mouseX - location.x)/(60*60) + sq(mouseY - location.y)/(60*60) < 1 ) {
      petted = !petted;
      if (petted) {
        affection = affection+random(0.5+love/5, 1.2+love/2);
        pets++;
      }
    }
    for (int i = 0; i < 3; i++) { 
      if (mouseX<290+40+360*i && mouseX>40+360*i && mouseY<130+20 && mouseY>20) { // rect(40+360*i, 20, 290, 130, 20);
        int index = int(i*1);
        gameState = index;
        println(gameState);
      }
    }
  }
}

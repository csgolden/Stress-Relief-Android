class food extends pet {
  ArrayList<PVector>grub;
  PImage[] fSprites;
  food() {
    super();
    grub = new ArrayList<PVector>();
    fSprites = new PImage[14];
  } 
  void feeding() {
    for (int i = 0; i < 6; i++) {
      grub.add(new PVector(int(random(640)), int(random(838, 1366)), random(14)));
    }
    for (int i = 0; i < fSprites.length; i++) {
      fSprites[i] = loadImage("food"+i+".png");
      fSprites[i].resize(26*scale/2, 30*scale/2);
    }
  }
  void FG() {
    for (int i = 0; i < grub.size(); i++) {
      image(fSprites[int(grub.get(i).z)], grub.get(i).x-30, grub.get(i).y-30); // ellipse(grub.get(i).x, grub.get(i).y, 60, 60);
      if (mousePressed && sq(mouseX - grub.get(i).x)/(60*60) + sq(mouseY - grub.get(i).y)/(60*60) < 1 ) {
        grub.get(i).x = mouseX;
        grub.get(i).y = mouseY;
        if (dist(grub.get(i).x, grub.get(i).y, petSim.location.x, petSim.location.y) < 30) {
          grub.remove(i);
        }
      }
    }
    if (grub.size() == 0) {
      petSim.energy = petSim.energy - 10;
      petSim.love = petSim.love + 5;
      mgState = 0;
      for (int i = 0; i < 6; i++) {
        grub.add(new PVector(int(random(640)), int(random(838, 1366)),random(14)));
      }
    }
  }
}

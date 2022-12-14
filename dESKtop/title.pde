// This tab is Title

class Title implements Scene {
  Title() {
  }

  void setup() {
  }

  void draw() {
<<<<<<< HEAD
    textSize(128);
    fill(0, 0, 0);
    text("Title", 250,200);
    textSize(256);
=======
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Title", width/2, height/2);
>>>>>>> dbcf342560ad9d01073450d49be407e6609db6ea
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(3);
    } else if (keyCode == RIGHT) {
      app.changeScene(1);
    }
  }

  void mousePressed() {
  }
}

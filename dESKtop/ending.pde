// This tab is Ending.

class Ending implements Scene {
  Ending() {
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Ending", width/2, height/2);
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(2);
    } else if (keyCode == RIGHT) {
      app.changeScene(0);
    }
  }

  void mousePressed() {
  }
}

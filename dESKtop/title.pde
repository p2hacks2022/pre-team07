// This tab is Title

class Title implements Scene {
  Title() {
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Title", width/2, height/2);
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

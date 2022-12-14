// This tab is Title

class Title implements Scene {
  Title() {
  }

  void setup() {
  }

  void draw() {
    textSize(128);
    fill(0, 0, 0);
    text("Title", 250,200);
    textSize(256);
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(3);
    } else if (keyCode == RIGHT) {
      app.changeScene(1);
    }
  }

  void mousePressed() {
    app.changeScene(1);
  }
}

class DataSelect implements Scene {
  DataSelect() {
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("DataSelect", width/2, height/2);
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(0);
    } else if (keyCode == RIGHT) {
      app.changeScene(2);
    }
  }

  void mousePressed() {
  }

  void load() {
  }
}

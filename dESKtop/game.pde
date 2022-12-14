class Game implements Scene {
  Game() {
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("Game", width/2, height/2);
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(1);
    } else if (keyCode == RIGHT) {
      app.changeScene(3);
    }
  }

  void mousePressed() {
  }
}

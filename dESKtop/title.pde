// This tab is Title

class Title implements Scene {
  Title() {
  }

  void setup() {
  }

  void draw() {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a1730bfffd423606e9e42240e51be3f5a83e9af0
    textSize(128);
    fill(0, 0, 0);
    text("Title", 250,200);
    textSize(256);
<<<<<<< HEAD
=======
=======
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Title", width/2, height/2);
>>>>>>> 8a37402ee160a86c3569aa2a33fc53e4656b214a
>>>>>>> a1730bfffd423606e9e42240e51be3f5a83e9af0
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

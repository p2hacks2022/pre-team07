class DataSelect implements Scene {
  Button[] button;

  DataSelect() {
    this.button = new Button[2];
    this.button[0] = new Button(this, "play", width/2-200, height-100, 100, 50, 0);
    this.button[0].set.lavel("Play", 20);
    this.button[0].visible(false);
    this.button[1] = new Button(this, "delete", width/2+100, height-100, 100, 50, 0);
    this.button[1].set.lavel("Delete", 20);
    this.button[1].visible(false);
  }

  void setup() {
    this.button[0].visible(true);
    this.button[1].visible(true);
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("DataSelect", width/2, height/2);
  }

  // ボタンが押された際に実行される
  void clickButtonEvent(String e) {
    switch(e) {
    case "play":
      button[0].visible(false);
      button[1].visible(false);
      app.changeScene(2);
      break;
    case "delete":
      println("save data deleteed");
      break;
    }
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

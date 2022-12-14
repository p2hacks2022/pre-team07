class DataSelect implements Scene {
  Button[] button;
  String dataName;

  DataSelect() {
    this.button = new Button[3];
    this.button[0] = new Button(this, "Play", width / 2 - 325, height - 100, 300, 50, 0);
    this.button[0].set.lavel("Play", 20);
    this.button[0].visible(false);
    this.button[1] = new Button(this, "Delete", width / 2 + 15, height - 100, 300, 50, 0);
    this.button[1].set.lavel("Delete", 20);
    this.button[1].visible(false);
    this.button[2] = new Button(this, "SaveData1", width*0.1 + 20, 170, width*0.8 - 40, 60, 0);
    this.button[2].set.lavel("SaveData1", 20);
    this.button[2].visible(false);
  }

  void setup() {
    button[0].visible(true);
    button[1].visible(true);
    button[2].visible(true);
    this.dataName = "";
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("DataSelect", width / 2, 100);
    fill(255);
    rect(width*0.1, 150, width*0.8, 200);
    fill(0);
    textSize(20);
    text(dataName, width / 2, 300);
  }

  //ボタンが押された際に実行される
  void clickButtonEvent(String e) {
    switch(e) {
    case "Play":
      if (dataName != "") {
        button[0].visible(false);
        button[1].visible(false);
        button[2].visible(false);
        app.changeScene(2);
        println("play [" + dataName + "]");
      }
      break;
    case "SaveData1":
      dataName = e;
      break;
    case "Delete":
      if (dataName != "") {
        println("[" + dataName +"] deleteed");
        dataName = "";
      }
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

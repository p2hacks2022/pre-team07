class Game implements Scene {
  Table map;
  Player player;
  ArrayList<Npc> npcs;
  Enemy enemy;
  String playData;
  Battle battle;
  final int CAMERA_RANGE_X = 24;
  final int CAMERA_RANGE_Y = 15;
  Game() {
  }

  void setup() {
    loadMap(playData);
    battle = new Battle();
  }

  void loadMap(String _playData) {
    if (_playData == "saveData1") {
      map = loadTable("map1.csv");
    }
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    fill(255);
    text("Game", width/2, height/2-30);
    text("Play:"+playData, width/2, height/2+30);
  }

  void keyPressed() {
    if (keyCode == LEFT) {
      app.changeScene(1);
    } else if (keyCode == RIGHT) {
      app.changeScene(3);
    };
  }

  void mousePressed() {
  }

  class Adventure {
    Adventure() {
    }
    void showMap() {
      int posX = player.pos.x;
      int posY = player.pos.y;
      for (int i = 0; i < CAMERA_RANGE_X; i++) {
        for (int j = 0; j < CAMERA_RANGE_Y; j++) {
        }
      }
    }
  }

  class Battle {
    int phase = 0;
    //trueのとき物理防御falseのとき魔法防御
    boolean guardType;
    //trueのとき物理攻撃falseのとき魔法攻撃
    boolean attackType;
    Button[] buttons;
    Battle() {
      print(enemy);
      buttons = new Button[]{
        new Button(this, "A", 50, height - 100, 70, 70, 10), 
        new Button(this, "B", width - 200, height - 100, 70, 70, 10), 
        new Button(this, "X", 50, height - 100, 70, 70, 10), 
        new Button(this, "Y", width - 200, height - 100, 70, 70, 10)
      };
      buttons[2].visible(false);
      buttons[3].visible(false);
    }
    
    void A() {
       println("click A"); 
    }

    void clickButtonEvent(String e) {
      switch (phase) {
      case 0:
        switch (e) {
        case "A":
          guardType = true;
          break;
        case "B":
          guardType = false;
          break;
        }
        break;
      case 1:
        switch (e) {
        case "X":
          break;
        case "Y":
          break;
        }
        break;
      }
    }
  }
}

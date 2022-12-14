class Game implements Scene {
  Table map;
  Player player;
  ArrayList<Npc> npcs;
  Enemy enemy;
  String playData;

  final int CAMERA_RANGE_X = 24;
  final int CAMERA_RANGE_Y = 15;
  Game() {
  }

  void setup() {
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
    }
  }

  void mousePressed() {
  }

  void loadMap(int mapNum) {
    map = loadTable("map"+mapNum+".csv");
  }

  void showMap() {
    int posX = player.pos.x;
    int posY = player.pos.y;
    for (int i = 0; i < CAMERA_RANGE_X; i++) {
      for (int j = 0; j) {
      }
    }
  }
}

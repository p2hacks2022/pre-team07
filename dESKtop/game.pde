class Game implements Scene {
  int[][] map;
  Player player;
  ArrayList<Npc> npcs;
  Enemy enemy;
  
  Game() {
    
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
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
  
  void loadMap(int mapNum){
    String[] lines = loadStrings("map"+mapNum+".csv");
    for (int i = 0; i < lines.length; i++){
      String line = lines[i];
      char[] chars = line.toCharArray();
      for (int j = 0; j < chars.length; j++){
        width / lines.lengthchars[j];
      }
    }
  }
}

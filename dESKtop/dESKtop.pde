Scene[] scene;
Scene nowScene;

void setup() {
  scene = new Scene[] {
     new Title(),
     new DataSelect(),
     new Game(),
     new Ending()
  };
  nowScene = scene[0];
  size(800, 500);  
}

void draw() {
  nowScene.draw();
}

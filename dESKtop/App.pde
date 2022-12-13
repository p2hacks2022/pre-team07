class App {
  TextLib textLib;
  Scene[] sceneList;
  int scene;
  boolean setupFlag;

  App() {
    textLib = new TextLib();
    sceneList = new Scene[] {
      new Title(), 
      new DataSelect(), 
      new Game(), 
      new Ending(), 
      new Transition()
    };
    // シーン遷移するごとにsetupFlagをtrueにする
    setupFlag = true;
    scene = 0;
  }

  void run() {
    if (setupFlag) {
      sceneList[scene].setup();
      setupFlag = false;
    }
    sceneList[scene].draw();
  }

  void keyPressed() {
    // 左右ともにTransitionは飛ばすようにしてある
    // 左矢印を押すと Ending -> Game -> DateSelect -> Title の順で遷移していく
    if(keyCode == LEFT) {
       scene = --scene < 0 ?  sceneList.length-2 : scene;
    }
    // 右矢印を押すと Title -> DataSelect -> Game -> Ending の順で遷移していく
    else if(keyCode == RIGHT) {
       scene = ++scene > sceneList.length-2 ?  0 : scene;
    }
    sceneList[scene].keyPressed();
  }

  void mousePressed() {
    sceneList[scene].mousePressed();
  }
}

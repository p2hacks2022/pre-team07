class App {
  TextLib textLib;
  Scene[] sceneList;
  int scene;
  boolean setupFlag, sceneChangeFlag;
  // 1(ms)なので1000で1秒
  final long TRANSITION_TIME = 2000;
  long transitionStartTime;

  App() {
    textLib = new TextLib();
    sceneList = new Scene[] {
      new Title(), 
      new DataSelect(), 
      new Game(), 
      new Ending(), 
      new Transition()
    };
    // トランジションのセットアップ用フラグ
    sceneChangeFlag = false;
    // シーン遷移するごとにsetupFlagをtrueにする
    setupFlag = true;
    scene = 0;
  }

  void run() {
    if (setupFlag) {
      sceneList[scene].setup();
      // シーン遷移後一度だけsetup関数を実行しsetupFlagをfalseにすることで以降実行されなくする
      setupFlag = false;
    }
    if (sceneChangeFlag) {
      transition();
      // トランジション開始時間+トランジション継続時間 <= 現在時間
      if (transitionStartTime+TRANSITION_TIME <= millis()) {
        // sceneChangeFlag = false にすることでelseの方が実行されトランジションが終了する
        sceneChangeFlag = false;
      }
    } else {
      sceneList[scene].draw();
    }
  }

  // シーン遷移用関数
  void changeScene(int n) {
    transitionStartTime = millis();
    sceneChangeFlag = true;
    setupFlag = true;
    scene = n;
  }

  // トランジション描画
  void transition() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Transition", width/2, height/2);
  }

  // デバッグ用
  void keyPressed() {
    // 左右ともにTransitionは飛ばすようにしてある
    // 左矢印を押すと Ending -> Game -> DateSelect -> Title の順で遷移していく
    if (keyCode == 'L') {
      scene = --scene < 0 ?  sceneList.length-2 : scene;
    }
    // 右矢印を押すと Title -> DataSelect -> Game -> Ending の順で遷移していく
    else if (keyCode == 'R') {
      scene = ++scene > sceneList.length-2 ?  0 : scene;
    }
    sceneList[scene].keyPressed();
  }

  void mousePressed() {
    sceneList[scene].mousePressed();
  }
}

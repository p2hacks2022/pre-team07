class App {
    TextLib textLib;
    Scene[] sceneList;
    // 0:title, 1:selectData, 2:game, 3:ending
    int scene = 0;
    // シーン遷移するごとにsetupFlagをfalseにする
    boolean setupFlag = true;
    // トランジションのセットアップ用フラグ
    boolean sceneChangeFlag = false;
    // 1(ms)なので1000で1秒
    final long TRANSITION_TIME = 2000;
    long transitionStartTime;
    PFont font;
    int transitionPoint=0;

    App() {
        sceneList = new Scene[] {
            new Title(), 
            new DataSelect(), 
            new Game(), 
            new Ending()
        };
        font = createFont("PixelMplus10-Regular.ttf", 12);
        textFont(font);
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
                setupFlag = true;
            }
        } else {
            sceneList[scene].draw();
        }
    }

    // シーン遷移用関数
    void changeScene(int n) {
        transitionStartTime = millis();
        sceneChangeFlag = true;
        scene = n;
    }

    // トランジション描画
    void transition() {
        image(fileIO.transitionImg, 0, 0, width, height);
        textAlign(RIGHT, BOTTOM);
        textSize(50);
        fill(255);
        text("LOADING   ", width-5, height-5);
        if (frameCount % 10 == 0) {
            transitionPoint = 3<transitionPoint ? 0 : ++transitionPoint;
        }
        switch(transitionPoint) {
        case 1:
            text(".  ", width-5, height-5);
            break;
        case 2:
            text(".. ", width-5, height-5);
            break;
        case 3:
            text("...", width-5, height-5);
            break;
        }
    }

    // デバッグ用（トランジションは発生しない）
    void keyPressed() {
        // 左矢印を押すと Ending -> Game -> DateSelect -> Title の順で遷移していく
        if (keyCode == 'L') {
            scene = --scene < 0 ?  sceneList.length-1 : scene;
        }
        // 右矢印を押すと Title -> DataSelect -> Game -> Ending の順で遷移していく
        else if (keyCode == 'R') {
            scene = ++scene > sceneList.length-1 ?  0 : scene;
        }
        sceneList[scene].keyPressed();
    }

    void mousePressed() {
        if (!sceneChangeFlag) {
            sceneList[scene].mousePressed();
        }
    }

    void dispose() {
        if (scene == 2) {
            ((dESKtop.Game)app.sceneList[2]).dispose();
        }
    }
}

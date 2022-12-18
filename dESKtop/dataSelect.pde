class DataSelect implements Scene {
    Button[] button = new Button[3];
    String dataName;

    DataSelect() {
        this.button[0] = new Button(this, "delete", width / 2 - 325, height - 100, 300, 50, 0);
        this.button[0].set.label("Delete", 20);
        this.button[0].visible(false);
        this.button[1] = new Button(this, "play", width / 2 + 15, height - 100, 300, 50, 0);
        this.button[1].set.label("Play", 20);
        this.button[1].visible(false);
        this.button[2] = new Button(this, "saveData1", width * 0.1 + 20, 170, width * 0.8 - 40, 60, 0);
        this.button[2].set.label("SaveData1", 20);
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
        image(fileIO.panel, width * 0.1, 150, width * 0.8, 200);
        fill(255, 0, 0);
        textSize(20);
        text(dataName, width / 2, 300);
    }

    //ボタンが押された際に実行される
    void play() {
        //fileIO.audioPlayers[1].play();
        if (dataName != "") {
            button[0].visible(false);
            button[1].visible(false);
            button[2].visible(false);
            setPlayData(dataName);
            app.changeScene(2);
            // println("play [" + dataName + "]");
        }
        fileIO.pon.play(0);
    }

    //ボタンが押された際に実行される
    void saveData1() {
        //fileIO.audioPlayers[1].play();
        dataName = "saveData1";
        fileIO.pon.play(0);
    }

    //ボタンが押された際に実行される
    void delete() {
        if (dataName != "") {
            dataName = "";
            println("[" + dataName + "] deleted");
        }
        fileIO.pon.play(0);
    }

    // セーブデータ名をGameクラスへ送る
    void setPlayData(String playData) {
        ((dESKtop.Game)app.sceneList[2]).playData = playData;
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
}

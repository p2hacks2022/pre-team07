import processing.video.*;

class Game implements Scene {
    Player player;
    Enemy[] enemies;
    Enemy enemy;
    TextLib textLib;
    String playData;
    Table map;
    int[] floorMapTotal = new int[]{2, 2, 3};
    String[] floorMapName = new String[]{
        "アプリケーション層", 
        "プレゼンテーション層", 
        "セットアップ層", 
        "トランスポート層", 
        "ネットワーク層", 
        "データリンク層", 
        "物理層"
    };
    GameScene[] gameScenes;
    int sceneNum;
    boolean gameSceneSetupFlag = true;

    final int CAMERA_RANGE_X = 17;
    final int CAMERA_RANGE_Y = 11;

    Game() {
    }

    void setup() {
        player = new Player();
        player.pos = new PVectorInt(int(CAMERA_RANGE_X / 2.0), int(CAMERA_RANGE_Y / 2.0));
        player.vec = new PVectorInt(0, 0);
        enemies = new Enemy[]{
            new Enemy("zako", 128, 100, 150), 
            new Enemy("hutuu", 256, 50, 200), 
            new Enemy("tyubosu", 512, 100, 300), 
            new Enemy("rasubosu", 512, 150, 400), 
            new Enemy("rasubosu2", 512, 200, 500), 
        };
        textLib = new TextLib(); 
        gameScenes = new GameScene[]{
            new Adventure(), 
            new Battle(), 
            new GameOver()
        };
        sceneNum = 0;
        gameSceneChange(0);
    }

    void draw() {
        if (gameSceneSetupFlag) {
            gameScenes[sceneNum].setup();
            gameSceneSetupFlag = false;
        }
        background(0);
        gameScenes[sceneNum].draw();
    }

    void gameSceneChange(int n) {
        sceneNum = n;
        gameSceneSetupFlag = true;
    }

    void keyPressed() {
        if (keyCode == LEFT) {
            app.changeScene(1);
        } else if (keyCode == RIGHT) {
            app.changeScene(3);
        }
        if (keyCode == 'S')
            player.pos.y++;
        if (keyCode == 'W')
            player.pos.y--;
        if (keyCode == 'A')
            player.pos.x--;
        if (keyCode == 'D')
            player.pos.x++;
    }

    void mousePressed() {
        gameScenes[sceneNum].mousePressed();
    }

    class GameScene {
        GameScene() {
        }
        void setup() {
        }
        void draw() {
        }
        void keyPressed() {
        }
        void mousePressed() {
        }
    }

    class Adventure extends GameScene {
        Table map;
        // 行数
        int mapRow;
        // 列数
        int mapCol;
        float tileSize = height / CAMERA_RANGE_Y;
        // クリック時の移動先マス
        int targetX;
        int targetY;
        // 移動中かどうかの判定
        boolean moveFlag;
        // 鍵を持っているかの判定
        boolean keyFlag;
        // 1方向目の移動中か
        int moveDirectCount;
        int moveStep;
        // 敵が出現する確率(0~100%で指定)
        float enemyProbability = 5;

        Adventure() {
            player = new Player();
            loadMap("saveData1");
            mapRow = map.getRowCount();
            mapCol = map.getColumnCount();
            player.pos = new PVectorInt(getMapNum(8)[1], getMapNum(8)[0]);
            player.vec = new PVectorInt(0, 0);
            keyFlag = false;
            setup();
        }

        void setup() {
            moveFlag = false;
        }

        void draw() {
            drawMap();
            drawCursor(mouseX, mouseY);
            drawKeyFrame();
            if (keyFlag) {
                drawKey();
            }
            update();
        }

        void mousePressed() {
            setTarget(mouseX, mouseY);
        }

        int[] getMapNum(int n) {
            for (int i=0; i<mapRow; i++) {
                for (int j=0; j<mapCol; j++) {
                    if (map.getInt(i, j) == n) {
                        return new int[]{i, j};
                    }
                }
            }
            println("NullError");
            return null;
        }

        void drawKeyFrame() {
            push();
            fill(0, 150);
            strokeWeight(3);
            stroke(255);
            rect(25, 25, 50, 50);
            pop();
        }

        void drawKey() {
            fill(240, 240, 0);
            circle(50, 50, 20);
        }

        void update() {
            if (moveFlag) {
                movePlayer();
            }
        }

        void loadMap(String _playData) {
            if (_playData == "saveData1") {
                player.field = fileIO.saveData.getInt(1, 0);
                player.floor = fileIO.saveData.getInt(1, 1);
                map = loadTable("Map"+str(player.field)+"_"+str(player.floor)+".csv");
            }
        }

        void drawPlayer(int x, int y, boolean centerXFlag, boolean centerYFlag) {
            fill(255);
            if (centerXFlag && centerYFlag) {
                circle((CAMERA_RANGE_X / 2.0) * tileSize, (CAMERA_RANGE_Y / 2.0) * tileSize, tileSize);
            } else if (!centerXFlag && !centerYFlag) {
                circle((x + 0.5) * tileSize, (y + 0.5) * tileSize, tileSize);
            } else {
                float drawX = 0;
                float drawY = 0;
                if (!centerXFlag) {
                    drawX = (x + 0.5) * tileSize;
                    drawY = (CAMERA_RANGE_Y / 2.0) * tileSize;
                } else if (!centerYFlag) {
                    drawX = (CAMERA_RANGE_X / 2.0) * tileSize;
                    drawY = (y + 0.5) * tileSize;
                }
                circle(drawX, drawY, tileSize);
            }
        }

        void drawMap() {
            int mapY = 0;
            int mapX = 0;
            int drawPlayerX = 0;
            int drawPlayerY = 0;
            boolean centerXFlag = true;
            boolean centerYFlag = true;

            for (int y = 0; y < CAMERA_RANGE_Y; y++) {
                // playerのy座標が画面y軸中心にする座標範囲か判定
                mapY = y + player.pos.y - int(CAMERA_RANGE_Y / 2.0);
                // 上の外側
                if (player.pos.y <= CAMERA_RANGE_Y / 2.0) {
                    mapY = y;
                    drawPlayerY = player.pos.y;
                    centerYFlag = false;
                }
                // 下の外側
                else if (mapRow - CAMERA_RANGE_Y / 2.0  <= player.pos.y) {
                    mapY = mapRow - CAMERA_RANGE_Y + y;
                    drawPlayerY = player.pos.y - (mapRow - int(CAMERA_RANGE_Y));
                    centerYFlag = false;
                }
                for (int x = 0; x < CAMERA_RANGE_X; x++) {
                    fill(0);
                    // playerのx座標が画面x軸中心にする座標範囲か判定
                    mapX = x + player.pos.x - int(CAMERA_RANGE_X / 2.0);
                    // 左の外側
                    if (player.pos.x <= CAMERA_RANGE_X / 2.0) {
                        mapX = x;
                        drawPlayerX = player.pos.x;
                        centerXFlag = false;
                    }
                    // 右の外側
                    else if (mapCol - CAMERA_RANGE_X / 2.0  <= player.pos.x) {
                        mapX = mapCol - CAMERA_RANGE_X + x;
                        drawPlayerX = player.pos.x - (mapCol - int(CAMERA_RANGE_X));
                        centerXFlag = false;
                    }

                    // マップの数値を取得
                    switch(map.getInt(mapY, mapX)) {
                    case 1:
                        fill(255, 255, 150);
                        break;
                    case 2:
                        fill(255, 255, 100);
                        break;
                    case 3:
                        fill(255, 255, 50);
                        break;
                    case 4:
                        fill(50, 50, 150);
                        break;
                    case 6:
                        fill(100, 100, 150);
                        break;
                    }
                    rect(x * tileSize, y * tileSize, tileSize, tileSize);
                }
            }

            textSize(20);
            fill(0);
            text(player.pos.x + ", " + player.pos.y, width / 2, height / 2 - 60);
            drawPlayer(drawPlayerX, drawPlayerY, centerXFlag, centerYFlag);
        }

        void drawCursor(float x, float y) {
            fill(0, 100);
            rect(int(x / tileSize) * tileSize, int(y / tileSize) * tileSize, tileSize, tileSize);
        }

        void setTarget(float x, float y) {
            if (player.pos.x < CAMERA_RANGE_X / 2.0) {
                targetX = int(x / tileSize);
            } else if (mapCol - CAMERA_RANGE_X / 2.0  <= player.pos.x) {
                targetX = int(x / tileSize) + mapCol - CAMERA_RANGE_X;
            } else {
                targetX = int(x / tileSize) + player.pos.x - int(CAMERA_RANGE_X / 2.0);
            }
            if (player.pos.y < CAMERA_RANGE_Y / 2.0) {
                targetY = int(y / tileSize);
            } else if (mapRow - CAMERA_RANGE_Y / 2.0  <= player.pos.y) {
                targetY = int(y / tileSize) + mapRow - CAMERA_RANGE_Y;
            } else {
                targetY = int(y / tileSize) + player.pos.y - int(CAMERA_RANGE_Y / 2.0);
            }

            if (targetX == player.pos.x && targetY == player.pos.y) {
                return;
            }

            player.vec.x = (targetX - player.pos.x < 0 ? - 1 : 1);
            player.vec.y = (targetY - player.pos.y < 0 ? - 1 : 1);
            moveDirectCount = 0;

            if (abs(player.pos.y - targetY) < abs(player.pos.x - targetX)) {
                moveStep = 1;
                if (player.pos.y - targetY == 0) {
                    moveStep = 2;
                    moveDirectCount++;
                }
            } else {
                moveStep = 2;
                if (player.pos.x - targetX == 0) {
                    moveStep = 1;
                    moveDirectCount++;
                }
            }
            moveFlag = true;
        }

        int aboutBlock(int n) {
            switch(n) {
                // 床なら1を返す
            case 1 : 
            case  2 :
            case 3:
                return 1;
            case 4 :
            case 5:
                return 2;
            case 6 :
            case 7:
                return 3;
            }
            return - 1;
        }

        void getKey(int x, int y) {
            map.setInt(x, y, player.field);
            keyFlag = true;
        }

        void movePlayer() {
            if (frameCount % 10 != 0) {
                return;
            }

            // 縦方向移動
            if (moveStep == 1) {
                int move = map.getInt(player.pos.y + player.vec.y, player.pos.x);
                int block = aboutBlock(move);
                if (!(2<=block && block<=3)) {
                    player.pos.y += player.vec.y;
                }
                if (player.pos.y == targetY || aboutBlock(move) == 2 || aboutBlock(move) == 3) {
                    moveStep = 2;
                    moveDirectCount++;
                }
            }
            // 横方向移動
            else if (moveStep == 2) {
                int move = map.getInt(player.pos.y, player.pos.x +  + player.vec.x);
                int block = aboutBlock(move);
                if (!(2<=block && block<=3)) {
                    player.pos.x += player.vec.x;
                }
                if (player.pos.x == targetX || aboutBlock(move) == 2 || aboutBlock(move) == 3) {
                    moveStep = 1;
                    moveDirectCount++;
                }
            }
            switch(map.getInt(player.pos.y, player.pos.x)) {
                // 鍵ゲット
            case -1:
                moveStep = 0;
                moveDirectCount++;
                getKey(player.pos.y, player.pos.x);
                break;
                // ゴールに到着
            case 9:
                if (keyFlag) {
                    moveStep = 0;
                    player.floor++;
                    if (floorMapTotal[player.field-1] < player.floor) {
                        player.floor = 0;
                        player.field++;
                    }
                    gameSceneChange(0);
                    gameScenes[0] = new Adventure();
                }
                break;
            }
            if (2 <= moveDirectCount) {
                moveFlag = false;
                moveStep = 0;
            }

            // 敵出現
            if (random(100) < enemyProbability && moveStep != 0) {
                moveFlag = false;
                moveStep = 0;
                enemy = new Enemy(enemies[(int)random(3)]);
                gameSceneChange(1);
            }
        }
    }

    class Battle extends GameScene {
        final float SELF_DAMAGE_RATE = 0.1;
        final float PREPARE_TIME = 3;
        int phase = 0;
        String text;
        Button[] buttons;
        float startTime;
        float nowDuration;
        boolean first;
        boolean isMovieFinished = false;
        boolean flag = false;
        Movie movie;

        Battle() {
            fileIO.panel.resize(300, 180);
        }

        void setup() {
            phase = 0;
            println(enemy.name);
            buttons = new Button[]{
                new Button(this, "localGuard", 100, height - 120, 80, 80, 10), 
                new Button(this, "remoteGuard", width - 180, height - 120, 80, 80, 10), 
                new Button(this, "localAttack", 100, height - 120, 80, 80, 10), 
                new Button(this, "remoteAttack", width - 180, height - 120, 80, 80, 10)
            };
            for (Button button : buttons) {
                button.set.align(CENTER, TOP);
            }
            setVisibleXY(false);
            textLib.setVisible(false);
            isMovieFinished = false;
            flag = false;
        }

        void draw() {
            background(0);
            image(fileIO.panel, 275, height - 180);
            textSize(20);
            switch(phase) {
            case 0:
                fill(255, 0, 0);
                text("- 防御選択 -", width / 2, height - 159);
                fill(255);
                textLib.setText("防御方法を選んでください", width / 2, height - 80, 0.1, 0);
                break;
            case 1:
                fill(255, 0, 0);
                text("- 攻撃選択 -", width / 2, height - 159);
                fill(255);
                textLib.setText("攻撃方法を選んでください", width / 2, height - 80, 0.1, 0);
                break;
            case 2:
                if (!isMovieFinished && startTime+nowDuration < millis()) {
                    movie = fileIO.movies[getIndex(enemy.guardType)];
                    movie.jump(0);
                    movie.play();
                    nowDuration = movie.duration() * 1000;
                    fileIO.movies[getIndex(enemy.guardType)].play();
                    isMovieFinished = true;
                } else if (isMovieFinished && startTime+nowDuration < millis()) {
                    isMovieFinished = false;
                    setVisibleAB(true);
                    if (!flag) {
                        actionPrepare(!first);
                        flag = true;
                    } else {
                        flag = false;
                        textLib.setVisible(false);
                        phase = 0;
                    }
                } else {
                    image(movie, 0, 0);
                    fill(255, 0, 0);
                    text("- あなたのターン -", width / 2, height - 159);
                    fill(255);
                    textLib.setText(text, width / 2, height - 80, 0.1, 0);
                }
                break;
            case 3:
                if (!isMovieFinished && startTime+nowDuration < millis()) {
                    movie = fileIO.movies[getIndex(player.guardType)];
                    movie.jump(0);
                    movie.play();
                    nowDuration = movie.duration() * 1000;
                    isMovieFinished = true;
                } else if (isMovieFinished && startTime+nowDuration < millis()) {
                    isMovieFinished = false;
                    setVisibleAB(true);
                    if (!flag) {
                        actionPrepare(!first);
                        flag = true;
                    } else {
                        flag = false;
                        textLib.setVisible(false);
                        phase = 0;
                    }
                } else {
                    image(movie, 0, 0);
                    fill(255, 0, 0);
                    text("- 敵のターン -", width / 2, height - 159);
                    fill(255);
                    textLib.setText(text, width / 2, height - 80, 0.1, 0);
                }
                break;
                //ゲームオーバー
            case 4:
                if (startTime+PREPARE_TIME*1000 < millis()) {
                    gameSceneChange(2);
                    println("gameOver");
                } else {
                    textLib.setText("", width / 2, height - 80, 0.1, 0);
                }
                break;
                //勝利
            case 5:
                if (startTime+PREPARE_TIME*1000 < millis()) {
                    gameSceneChange(0);
                    println("toAdventure");
                } else {
                    textLib.setText("", width / 2, height - 80, 0.1, 0);
                }
                break;
            }
        }

        void keyPressed() {
        }
        void mousePressed() {
        }

        void setVisibleAB(boolean isVisible) {
            buttons[0].visible(isVisible);
            buttons[1].visible(isVisible);
        }

        void setVisibleXY(boolean isVisible) {
            buttons[2].visible(isVisible);
            buttons[3].visible(isVisible);
        }

        void localGuard() {
            player.guardType = "localGuard";
            nextButton();
        }

        void remoteGuard() {
            player.guardType = "remoteGuard";
            nextButton();
        }

        void nextButton() {
            setVisibleAB(false);
            setVisibleXY(true);
            phase = 1;
            textLib.setVisible(false);
        }

        void localAttack() {
            player.attackType = "localAttack";
            finishButton();
        }

        void remoteAttack() {
            player.attackType = "remoteAttack";
            finishButton();
        }

        void finishButton() {
            setVisibleXY(false);
            enemy.actionSelect();
            first = random(1) < 0.5;
            actionPrepare(first);
        }

        void actionPrepare(boolean act) {
            textLib.setVisible(false);
            if (judgeFinish()){
                    return;
                }
            if (act) {
                action(player, enemy);
                phase = 2;
                movie = fileIO.movies[getIndex(player.attackType)];
            } else {
                action(enemy, player);
                phase = 3;
                movie = fileIO.movies[getIndex(enemy.attackType)];
            }
            movie.jump(0);
            movie.play();
            nowDuration = movie.duration() * 1000;
            startTime = millis();
        }

        int getIndex(String type) {
            println(type);
            switch (type) {
            case "localGuard":
                return 0;
            case "remoteGuard":
                return 1;
            case "localAttack":
                return 2;
            case "remoteAttack":
                return 3;
            }
            return -1;
        }

        boolean judgeFinish() {
            setVisibleAB(false);
            setVisibleXY(false);
            textLib.setVisible(false);
            if (enemy.hp <= 0) {
                println("clear!!");
                startTime = millis();
                phase = 5;
                return true;
            } else if (player.hp <= 0) {
                println("gameOver!!");
                startTime = millis();
                phase = 4;
                return true;
            }else {
                return false;
            }
        }

        void action(CharacterBase attack, CharacterBase guard) {
            if (attack.attackType == "localAttack") {
                attack.hp -= (int)(decideDamage(attack) * SELF_DAMAGE_RATE);
                if (guard.guardType == "localGuard") {
                    //ダメージなし
                    guard.hp -= 0;
                    text = guard.name + "は攻撃を防いだ";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp -= decideDamage(attack);

                    text = attack instanceof Player ? 
                        guard.name + "に" + decideDamage(attack) + "GBダメージ与えた" : 
                        guard.name + "は" + decideDamage(attack) + "GBダメージ受けた";
                }
            } else if (attack.attackType == "remoteAttack") {
                if (guard.guardType == "localGuard") {
                    guard.hp -= decideDamage(attack);

                    text = attack instanceof Player ? 
                        guard.name + "に" + decideDamage(attack) + "GBダメージ与えた" : 
                        guard.name + "は" + decideDamage(attack) + "GBダメージ受けた";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp += decideDamage(attack);
                    text = guard.name + "は攻撃を吸収した";
                }
            }
        }

        int decideDamage(CharacterBase attack) {
            return attack.powerLower + (int)random(attack.powerUpper + 1);
        }
    }

    class GameOver extends GameScene {


        GameOver() {
        }
        void setup() {
        }

        void draw() {
            image(fileIO.gameOverImg, 0, 0, width, height);
        }

        void keyPressed() {
        }

        void mousePressed() {
        }
    }
}

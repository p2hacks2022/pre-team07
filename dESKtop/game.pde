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

    int getFloorInt(int a, int b) {
        int ret=0;

        if (a == 1) {
            ret = b;
        } else if (a == 2) {
            ret = floorMapTotal[a-2]+b;
        } else if (a == 3) {
            ret = floorMapTotal[a-3]+floorMapTotal[a-2]+b;
        }

        return ret-1;
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
        // プレーヤ―の画像
        int playerImgNum = 0;
        // 敵が出現する確率(0~100%で指定)
        float enemyProbability = 1;
        boolean changeFloor;

        Adventure() {
            changeFloor = true;
            player = new Player();
            loadMap(playData);
            mapRow = map.getRowCount();
            mapCol = map.getColumnCount();
            player.pos = new PVectorInt(getMapNum(8)[1], getMapNum(8)[0]);
            player.vec = new PVectorInt(0, 1);
            keyFlag = false;
            setup();
            textLib.setVisible(false);
            textLib.setText("ここは「"+floorMapName[getFloorInt(player.floor, player.field)]+"」", width/2.0, height-75, 0.1, 1);
            textLib.setColor(color(255));
        }

        void setup() {
            moveFlag = false;
            player.vec = new PVectorInt(0, 1);
        }

        void draw() {
            drawMap();
            if(!changeFloor) {
                drawCursor(mouseX, mouseY);
            }
            drawKeyFrame();
            if (keyFlag) {
                drawKey();
            }
            update();
            if(changeFloor) {
                fill(0, 150);
                rect(0, 0, width, height);
                int w = fileIO.panel.width;
                int h = fileIO.panel.height;
                image(fileIO.panel, width/2.0-(w*2*0.5), height - 180, w*2, h);
                w = fileIO.playerStandImg.width;
                h = fileIO.playerStandImg.height;
                image(fileIO.playerStandImg, width-100, 100, w*0.7, h*0.7);
            }
        }

        void mousePressed() {
            if (!changeFloor) {
                setTarget(mouseX, mouseY);
            }
            else {
                changeFloor = false;
                textLib.setVisible(false);
            }
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
            fill(100, 100, 255, 150);
            strokeWeight(3);
            stroke(255);
            rect(25, 25, 50, 50);
            pop();
        }

        void drawKey() {
            //fill(240, 240, 0);
            //circle(50, 50, 20);
            image(fileIO.keyImg, 30, 30, 45, 45);
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
                println(player.field, ",", player.floor);
                map = loadTable("Map"+str(player.field)+"_"+str(player.floor)+".csv");
            }
        }

        void drwaPlayerImg(int x, int y, int directX, int directY) {
            if (moveStep == 2) {
                directY = 0;
            } else if (moveStep == 1) {
                directX = 0;
            }
            // 右
            if (directX == 1 && directY == 0) {
                image(fileIO.playerImg[1][playerImgNum], x, y, tileSize, tileSize);
            } 
            // 左
            else if (directX == -1 && directY == 0) {
                image(fileIO.playerImg[3][playerImgNum], x, y, tileSize, tileSize);
            }
            // 上
            else if (directX == 0 && directY == -1) {
                image(fileIO.playerImg[2][playerImgNum], x, y, tileSize, tileSize);
            }
            // 下
            else if (directX == 0 && directY == 1) {
                image(fileIO.playerImg[0][playerImgNum], x, y, tileSize, tileSize);
            }
        }

        void drawPlayer(int x, int y, boolean centerXFlag, boolean centerYFlag) {
            fill(255);
            if (centerXFlag && centerYFlag) {
                // circle(((CAMERA_RANGE_X / 2.0)) * tileSize, ((CAMERA_RANGE_Y / 2.0)) * tileSize, tileSize);
                drwaPlayerImg(int(((CAMERA_RANGE_X / 2.0)-0.5) * tileSize), int(((CAMERA_RANGE_Y / 2.0)-0.5) * tileSize), player.vec.x, player.vec.y);
            } else if (!centerXFlag && !centerYFlag) {
                // circle(x * tileSize, y * tileSize, tileSize);
                drwaPlayerImg(int(x * tileSize), int(y * tileSize), player.vec.x, player.vec.y);
            } else {
                float drawX = 0;
                float drawY = 0;
                if (!centerXFlag) {
                    drawX = x * tileSize;
                    drawY = (CAMERA_RANGE_Y / 2.0 - 0.5) * tileSize;
                } else if (!centerYFlag) {
                    drawX = (CAMERA_RANGE_X / 2.0 - 0.5) * tileSize;
                    drawY = y * tileSize;
                }
                // circle(drawX, drawY, tileSize);
                drwaPlayerImg(int(drawX), int(drawY), player.vec.x, player.vec.y);
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
                    switch(aboutBlock(map.getInt(mapY, mapX))) {
                    case 1:
                        // fill(255, 255, 150);
                        image(fileIO.floorImg[player.field-1], x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    case 2:
                        // fill(255, 255, 100);
                        image(fileIO.wallTopImg[player.field-1], x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    case 3:
                        // fill(255, 255, 50);
                        image(fileIO.wallSideImg[player.field-1], x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    case 4:
                        image(fileIO.keyFloorImg, x * tileSize, y * tileSize, tileSize, tileSize);
                        image(fileIO.keyImg, x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    case 5:
                        image(fileIO.startImg, x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    case 6:
                        image(fileIO.goalImg, x * tileSize, y * tileSize, tileSize, tileSize);
                        break;
                    }

                    // rect(x * tileSize, y * tileSize, tileSize, tileSize);
                }
            }

            textSize(20);
            fill(0);
            // text(player.pos.x + ", " + player.pos.y, width / 2, height / 2 - 60);
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
                // 壁の上面なら2を返す
            case 4 :
            case 5:
                return 2;
                // 壁の側面なら2を返す
            case 6 :
            case 7:
                return 3;
                // 鍵なら4を返す
            case -1:
                return 4;
                // スタートなら5を返す
            case 8:
                return 5;
                // ゴールなら6を返す
            case 9:
                return 6;
            }
            return - 1;
        }

        void getKey(int x, int y) {
            map.setInt(x, y, player.field);
            keyFlag = true;
        }

        Enemy appearEnemy(int n) {
            switch(n) {
                case 1:
                return enemies[int(random(0, 2))];
                case 2:
                return enemies[int(random(1, 4))];
                case 3:
                return enemies[int(random(4, 5))];
            }
            return enemies[-1];
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
                    if (2 <= moveDirectCount) {
                        player.vec.x = 0;
                    }
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
                    if (2 <= moveDirectCount) {
                        player.vec.y = 0;
                    }
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
                    // ラスボス部屋転移
                    if(player.field == 3 && player.floor == 3) {
                        enemy = new Enemy(enemies[5]);
                        gameSceneChange(1);
                    }
                    // 普通の階層転移
                    else {
                        player.floor++;
                        if (floorMapTotal[player.field-1] < player.floor) {
                            player.floor = 1;
                            player.field++;
                        }
                        fileIO.saveData.setInt(1, 0, player.field);
                        fileIO.saveData.setInt(1, 1, player.floor);
                        saveTable(fileIO.saveData, fileIO.dataPath+playData+".csv");
                        gameSceneChange(0);
                        gameScenes[0] = new Adventure();
                    }
                }
                break;
            }
            if (2 <= moveDirectCount) {
                moveFlag = false;
                moveStep = 0;
            }

            // 敵出現
            if (random(100) < enemyProbability && moveStep != 0 && aboutBlock(map.getInt(player.pos.y, player.pos.x)) == 1) {
                moveFlag = false;
                moveStep = 0;
                enemy = new Enemy(appearEnemy(player.field));
                gameSceneChange(1);
            }
        }
    }

    class Battle extends GameScene {
        final float SELF_DAMAGE_RATE = 0.1;
        int phase = 0;
        String text;
        Button[] buttons;
        float startTime;
        float nowDuration;
        boolean first;
        boolean isMovieFinished = false;
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

                print("you : ");
                println(millis() - startTime);
                if (!isMovieFinished && startTime+nowDuration < millis()) {
                    movie = fileIO.movies[getIndex(enemy.guardType)];
                    movie.play();
                    nowDuration = movie.duration() * 1000;
                    fileIO.movies[getIndex(enemy.guardType)].play();
                    isMovieFinished = true;
                } else if (isMovieFinished && startTime+nowDuration < millis()) {
                    isMovieFinished = false;
                    actionPrepare(!first);
                    setVisibleAB(true);
                    phase = 0;
                } else {
                    image(movie, 0, 0);
                    fill(255, 0, 0);
                    text("- あなたのターン -", width / 2, height - 159);
                    fill(255);
                    textLib.setText(text, width / 2, height - 80, 0.1, 0);
                }
                break;
            case 3:
                print("teki : ");
                println(millis() - startTime);
                if (!isMovieFinished && startTime+nowDuration < millis()) {
                    movie = fileIO.movies[getIndex(enemy.guardType)];
                    movie.play();
                    nowDuration = movie.duration() * 1000;
                    isMovieFinished = true;
                } else if (isMovieFinished && startTime+nowDuration < millis()) {
                    isMovieFinished = false;
                    actionPrepare(!first);
                    setVisibleAB(true);
                    phase = 0;
                } else {

                    image(movie, 0, 0);
                    fill(255, 0, 0);
                    text("- 敵のターン -", width / 2, height - 159);
                    fill(255);
                    textLib.setText(text, width / 2, height - 80, 0.1, 0);
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
            textLib.setVisible(false);
            setVisibleXY(false);
            enemy.actionSelect();
            first = random(1) < 0.5;
            actionPrepare(first);
        }

        void actionPrepare(boolean act) {
            if (act) {
                action(player, enemy);
                judgeFinish();
                phase = 2;
                movie = fileIO.movies[getIndex(player.attackType)];
            } else {
                action(enemy, player);
                judgeFinish();
                phase = 3;
                movie = fileIO.movies[getIndex(enemy.attackType)];
            }
            movie.play();
            nowDuration = movie.duration() * 1000;
            startTime = millis();
        }

        int getIndex(String type) {
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

        void judgeFinish() {
            setVisibleAB(false);
            setVisibleXY(false);
            if (enemy.hp <= 0) {
                gameSceneChange(0);
                println("toAdventure");
            } else if (player.hp <= 0) {
                gameSceneChange(2);
                println("gameOver");
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
                    text = guard.name + "に" + decideDamage(attack) + "GBダメージ与えた";
                }
            } else if (attack.attackType == "remoteAttack") {
                if (guard.guardType == "localGuard") {
                    guard.hp -= decideDamage(attack);
                    text = guard.name + "に" + decideDamage(attack) + "GBダメージ与えた";
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

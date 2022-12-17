class Game implements Scene {
<<<<<<< HEAD
    Player player;
    Enemy enemy;
    Adventure adventure;
    String playData;

    final int CAMERA_RANGE_X = 17;
    final int CAMERA_RANGE_Y = 11;

    Game() {
        adventure = new Adventure();
=======
    Table map;
    Player player;
    Enemy enemy;
    String playData;
    GameScene[] gameScenes;
    int sceneNum = 0;

    Game() {
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
    }

    void setup() {
        player = new Player();
<<<<<<< HEAD
        player.pos = new PVectorInt(int(CAMERA_RANGE_X/2.0), int(CAMERA_RANGE_Y/2.0));
        player.vec = new PVectorInt(0, 0);
    }

    void draw() {
        background(0);
        adventure.draw();
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
        adventure.setTarget(mouseX, mouseY);
    }

    class Adventure {
        Table map;
        // 行数
        int mapRow;
        // 列数
        int mapCol;
        float tileSize = height/CAMERA_RANGE_Y;
        // クリック時の移動先マス
        int targetX;
        int targetY;
        // 移動中かどうかの判定
        boolean moveFlag;
        // 1方向目の移動中か
        int moveDirectCount;
        int moveStep;

        Adventure() {
            // loadMap(playData);
            loadMap("saveData1");
            mapRow = map.getRowCount();
            mapCol = map.getColumnCount();
        }

        void draw() {
            drawMap();
            drawCursor(mouseX, mouseY);
            update();
        }

        void update() {
            if (moveFlag) {
                movePlayer();
            }
        }

        void loadMap(String _playData) {
            if (_playData == "saveData1") {
                map = loadTable("Map1_1a.csv");
            }
        }

        void drawPlayer(int x, int y, boolean centerXFlag, boolean centerYFlag) {
            fill(255);
            if (centerXFlag && centerYFlag) {
                circle((CAMERA_RANGE_X/2.0)*tileSize, (CAMERA_RANGE_Y/2.0)*tileSize, tileSize);
            } else if (!centerXFlag && !centerYFlag) {
                circle((x+0.5)*tileSize, (y+0.5)*tileSize, tileSize);
            } else {
                float drawX=0;
                float drawY=0;
                if (!centerXFlag) {
                    drawX = (x+0.5)*tileSize;
                    drawY = (CAMERA_RANGE_Y/2.0)*tileSize;
                } else if (!centerYFlag) {
                    drawX = (CAMERA_RANGE_X/2.0)*tileSize;
                    drawY = (y+0.5)*tileSize;
                }
                circle(drawX, drawY, tileSize);
            }
        }

        void drawMap() {
            int mapY=0;
            int mapX=0;
            int drawPlayerX = 0;
            int drawPlayerY = 0;
            boolean centerXFlag = true;
            boolean centerYFlag = true;

            for (int y=0; y < CAMERA_RANGE_Y; y++) {
                // playerのy座標が画面y軸中心にする座標範囲か判定
                mapY = y+player.pos.y-int(CAMERA_RANGE_Y/2.0);
                // 上の外側
                if (player.pos.y <= CAMERA_RANGE_Y/2.0) {
                    mapY = y;
                    drawPlayerY = player.pos.y;
                    centerYFlag = false;
                }
                // 下の外側
                else if (mapRow-CAMERA_RANGE_Y/2.0  <= player.pos.y) {
                    mapY = mapRow-CAMERA_RANGE_Y + y;
                    drawPlayerY = player.pos.y-(mapRow-int(CAMERA_RANGE_Y));
                    centerYFlag = false;
                }
                for (int x=0; x < CAMERA_RANGE_X; x++) {
                    fill(0);
                    // playerのx座標が画面x軸中心にする座標範囲か判定
                    mapX = x+player.pos.x-int(CAMERA_RANGE_X/2.0);
                    // 左の外側
                    if (player.pos.x <= CAMERA_RANGE_X/2.0) {
                        mapX = x;
                        drawPlayerX = player.pos.x;
                        centerXFlag = false;
                    }
                    // 右の外側
                    else if (mapCol-CAMERA_RANGE_X/2.0  <= player.pos.x) {
                        mapX = mapCol-CAMERA_RANGE_X + x;
                        drawPlayerX = player.pos.x-(mapCol-int(CAMERA_RANGE_X));
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
                    rect(x*tileSize, y*tileSize, tileSize, tileSize);
                }
            }

            textSize(20);
            fill(0);
            text(player.pos.x+", "+player.pos.y, width/2, height/2-60);
            drawPlayer(drawPlayerX, drawPlayerY, centerXFlag, centerYFlag);
        }

        void drawCursor(float x, float y) {
            fill(0, 100);
            rect(int(x/tileSize)*tileSize, int(y/tileSize)*tileSize, tileSize, tileSize);
        }

        void setTarget(float x, float y) {
            if (player.pos.x < CAMERA_RANGE_X/2.0) {
                targetX = int(x/tileSize);
            } else if (mapCol-CAMERA_RANGE_X/2.0  <= player.pos.x) {
                targetX = int(x/tileSize) + mapCol - CAMERA_RANGE_X;
            } else {
                targetX = int(x/tileSize)+player.pos.x-int(CAMERA_RANGE_X/2.0);
            }
            if (player.pos.y < CAMERA_RANGE_Y/2.0) {
                targetY = int(y/tileSize);
            } else if (mapRow-CAMERA_RANGE_Y/2.0  <= player.pos.y) {
                targetY = int(y/tileSize) + mapRow - CAMERA_RANGE_Y;
            } else {
                targetY = int(y/tileSize)+player.pos.y-int(CAMERA_RANGE_Y/2.0);
            }

            if (targetX == player.pos.x && targetY == player.pos.y) {
                return;
            }

            player.vec.x = (targetX - player.pos.x < 0 ? -1: 1);
            player.vec.y = (targetY - player.pos.y < 0 ? -1: 1);
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
            case 1: 
            case 2: 
            case 3:
                return 1;
            case 4: 
            case 5:
                return 2;
            case 6: 
            case 7:
                return 3;
            }
            return -1;
        }

        void movePlayer() {
            if (frameCount % 10 != 1) {
                return;
            }
            // 縦方向移動
            if (moveStep == 1) {
                int move = map.getInt(player.pos.y + player.vec.y, player.pos.x);
                if (aboutBlock(move) ==  1)
                    player.pos.y += player.vec.y;
                if (player.pos.y == targetY || aboutBlock(move) == 2 || aboutBlock(move) == 3) {
                    moveStep = 2;
                    moveDirectCount++;
                }
            }
            // 横方向移動
            else if (moveStep == 2) {
                int move = map.getInt(player.pos.y, player.pos.x +  + player.vec.x);
                if (aboutBlock(move) ==  1)
                    player.pos.x += player.vec.x;
                if (player.pos.x == targetX || aboutBlock(move) == 2 || aboutBlock(move) == 3) {
                    moveStep = 1;
                    moveDirectCount++;
                }
            }
            if (2 <= moveDirectCount) {
                moveFlag = false;
                moveStep = 0;
            }
        }
    }
}

class Battle {
    Battle() {
=======
        enemy = new Enemy();
        gameScenes = new GameScene[]{
            new Battle(), 
            new Adventure()
        };
    }

    void loadMap(String _playData) {
        if (_playData == "saveData1") {
            //map = loadTable("map1.csv");
        }
    }

    void draw() {
        textAlign(CENTER, CENTER);
        textSize(50);
        fill(255);
        text("Game", width/2, height/2-30);
        text("Play:"+playData, width/2, height/2+30);
        gameScenes[sceneNum].draw();
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

    abstract class GameScene implements Scene {
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
        Adventure() {
        }
        void showMap() {
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

    class Battle extends GameScene {
        final float SELF_DAMAGE_RATE = 0.1;
        PImage panel;
        int phase = 0;
        String text;

        Button[] buttons;
        Battle() {
            panel = loadImage("panel.png");
            panel.resize(300, 180);
            buttons = new Button[]{
                new Button(this, "localGuard", 100, height - 120, 80, 80, 10), 
                new Button(this, "remoteGuard", width - 180, height - 120, 80, 80, 10), 
                new Button(this, "localAttack", 100, height - 120, 80, 80, 10), 
                new Button(this, "remoteAttack", width - 180, height - 120, 80, 80, 10)
            };
            for (Button button : buttons){
                //button.set.label(button.getButtonName, 12);
                button.set.align(CENTER, TOP);
            }
            setVisibleXY(false);
        }

        void setup() {
        }

        void draw() {
            background(0);
            image(panel, 250, height-180);
            textSize(20);
            switch(phase) {
            case 0:
                fill(255, 0, 0);
                text("- 防御選択 -", width/2, height-158);
                fill(255);
                text("防御方法を選んでください", width/2, height-80);
                break;
            case 1:
                fill(255, 0, 0);
                text("- 攻撃選択 -", width/2, height-158);
                fill(255);
                text("攻撃方法を選んでください", width/2, height-80);
                break;
            case 2:
                fill(255, 0, 0);
                text("- あなたのターン -", width/2, height-158);
                fill(255);
                text(text, width/2, height-80);
                break;
            case 3:
                fill(255, 0, 0);
                text("- 敵のターン -", width/2, height-158);
                fill(255);
                text(text, width/2, height-80);
                break;
            }
        }

        void keyPressed() {
        }
        void mousePressed() {
        }

        void setVisibleXY(boolean isVisible) {
            buttons[2].visible(isVisible);
            buttons[3].visible(isVisible);
        }

        void localGuard() {
            println("click A"); 
            player.guardType = "localGuard";
            nextButton();
        }

        void remoteGuard() {
            println("click B"); 
            player.guardType = "remoteGuard";
            nextButton();
        }

        void nextButton() {
            buttons[0].visible(false);
            buttons[1].visible(false);
            setVisibleXY(true);
            phase = 1;
        }

        void localAttack() {
            println("click X"); 
            player.attackType = "localAttack";
            finishButton();
        }

        void remoteAttack() {
            println("click Y"); 
            player.attackType = "remoteAttack";
            finishButton();
        }

        void finishButton() {
            setVisibleXY(false);
            enemyActionSelect();
            action(player, enemy);
            judgeFinish();
            action(enemy, player);
            judgeFinish();
            phase = 2;
        }

        void judgeFinish() {
            if (enemy.hp <= 0) {
                sceneNum = 0;
            } else if (player.hp <= 0) {
                sceneNum = 3;
            }
        }

        void enemyActionSelect() {
            enemy.guardType = random(1) < 0.5 ? "localGuard" : "remoteGuard";
            enemy.attackType = random(1) < 0.5 ? "localAttack" : "remoteAttack";
        }

        void action(CharacterBase attack, CharacterBase guard) {
            if (attack.attackType == "localAttack") {
                attack.hp -= (int)(decideDamage(attack) * SELF_DAMAGE_RATE);
                if (guard.guardType == "localGuard") {
                    //ダメージなし
                    guard.hp -= 0;
                    text = guard.name+"は攻撃を防いだ";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp -= decideDamage(attack);
                    text = guard.name+"に"+decideDamage(attack)+"GBダメージ与えた";
                }
            } else if (attack.attackType == "remoteAttack") {
                if (guard.guardType == "localGuard") {
                    guard.hp -= decideDamage(attack);
                    text = guard.name+"に"+decideDamage(attack)+"GBダメージ与えた";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp += decideDamage(attack);
                    text = guard.name+"は攻撃を吸収した";
                }
            }
        }

        int decideDamage(CharacterBase attack) {
            return attack.powerLower + (int)random(attack.powerUpper+1);
        }
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
    }
}

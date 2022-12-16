class Game implements Scene {
    Player player;
    Enemy enemy;
    Adventure adventure;
    String playData;

    final int CAMERA_RANGE_X = 17;
    final int CAMERA_RANGE_Y = 11;

    Game() {
        adventure = new Adventure();
    }

    void setup() {
        player = new Player();
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
    }
}

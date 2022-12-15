class Game implements Scene {
    Table map;
    Player player;
    Enemy enemy;
    String playData;
    Battle battle;
    final int CAMERA_RANGE_X = 24;
    final int CAMERA_RANGE_Y = 15;
    Game() {
    }

    void setup() {
        player = new Player();
        enemy = new Enemy();
        battle = new Battle();
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
        battle.draw();
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

    class Adventure {
        Adventure() {
        }
        void showMap() {
            int posX = player.pos.x;
            int posY = player.pos.y;
            for (int i = 0; i < CAMERA_RANGE_X; i++) {
                for (int j = 0; j < CAMERA_RANGE_Y; j++) {
                }
            }
        }
    }

    class Battle {
        final float SELF_DAMAGE_RATE = 0.1;
        PImage panel;
        
        Button[] buttons;
        Battle() {
            panel = loadImage("panel.png");
            panel.resize(600, 180);
            buttons = new Button[]{
                new Button(this, "localGuard", 170, height - 130, 100, 100, 10), 
                new Button(this, "remoteGuard", width - 270, height - 130, 100, 100, 10), 
                new Button(this, "localAttack", 170, height - 130, 100, 100, 10), 
                new Button(this, "remoteAttack", width - 270, height - 130, 100, 100, 10)
            };
            setVisibleXY(false);
        }
        
        void draw(){
            background(0);
            image(panel,100,height-180);
            textSize(20);
            text("防御方法を選んでください",width/2,height-100);
        }

        void nextButton() {
            buttons[0].visible(false);
            buttons[1].visible(false);
            setVisibleXY(true);
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

        void localAttack() {
            println("click X"); 
            player.attackType = "localAttack";
            setVisibleXY(false);
            enemyActionSelect();
            action(player, enemy);
            action(enemy, player);
        }
        
        void remoteAttack() {
            println("click Y"); 
            player.attackType = "remoteAttack";
            setVisibleXY(false);
            enemyActionSelect();
            action(player, enemy);
            action(enemy, player);
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
                } 
                else if (guard.guardType == "remoteGuard") {
                    guard.hp -= decideDamage(attack);
                }
            } else if (attack.attackType == "remoteAttack") {
                if (guard.guardType == "localGuard") {
                    guard.hp -= decideDamage(attack);
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp += decideDamage(attack);
                }
            }
        }
        
        int decideDamage(CharacterBase attack){
            return attack.powerLower + (int)random(attack.powerUpper+1);
        }
    }
}

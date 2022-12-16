class Game implements Scene {
    Table map;
    Player player;
    Enemy enemy;
    String playData;
    GameScene[] gameScenes;
    int sceneNum = 0;
    
    Game() {
    }

    void setup() {
        player = new Player();
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
        GameScene() {}
        void setup() {}
        void draw() {}
        void keyPressed() {}
        void mousePressed() {}
    }

    class Adventure extends GameScene {
        Adventure() {
        }
        void showMap() {
        }
        void setup() {}
        void draw() {}
        void keyPressed() {}
        void mousePressed() {}
    }

    class Battle extends GameScene {
        final float SELF_DAMAGE_RATE = 0.1;
        PImage panel;
        int phase = 0;
        String text;

        Button[] buttons;
        Battle() {
            panel = loadImage("panel.png");
            panel.resize(600, 180);
            buttons = new Button[]{
                new Button(this, "localGuard", 170, height - 120, 80, 80, 10), 
                new Button(this, "remoteGuard", width - 250, height - 120, 80, 80, 10), 
                new Button(this, "localAttack", 170, height - 120, 80, 80, 10), 
                new Button(this, "remoteAttack", width - 250, height - 120, 80, 80, 10)
            };
            setVisibleXY(false);
        }
        
        void setup() {}

        void draw() {
            background(0);
            image(panel, 100, height-180);
            textSize(20);
            switch(phase) {
            case 0:
                fill(255, 0, 0);
                text("- GUARD READY? -", width/2, height-158);
                fill(255);
                text("CHOOSE GUARD SKILL!", width/2, height-80);
                break;
            case 1:
                fill(255, 0, 0);
                text("- ATTACK READY? -", width/2, height-158);
                fill(255);
                text("CHOOSE ATTACK SKILL!", width/2, height-80);
                break;
            case 2:
                fill(255, 0, 0);
                text("- ATTACK TURN -", width/2, height-158);
                fill(255);
                text(text, width/2, height-80);
                break;
            }
        }
        
        void keyPressed() {}
        void mousePressed() {}

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
            
            action(enemy, player);
            phase = 2;
            
        }
        
        boolean judgeFinish(){
            if (enemy.hp<=0) {
                sceneNum = 0;
            }else if (){
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
                    text = "NO DAMAGE";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp -= decideDamage(attack);
                    text = "DAMAGE";
                }
            } else if (attack.attackType == "remoteAttack") {
                if (guard.guardType == "localGuard") {
                    guard.hp -= decideDamage(attack);
                    text = "DAMAGE";
                } else if (guard.guardType == "remoteGuard") {
                    guard.hp += decideDamage(attack);
                    text = "ABSORBED DAMAGE";
                }
            }
        }

        int decideDamage(CharacterBase attack) {
            return attack.powerLower + (int)random(attack.powerUpper+1);
        }
    }
}

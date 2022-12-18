// This tab is Title

class Title implements Scene {
    Title() {
    }

    void setup() {
    }

    void draw() {
        image(fileIO.title, 0, 0, width, height);
        textAlign(CENTER, CENTER);
        textSize(80);
        fill(255);
        text("ナンノ為ノ物語", width/2, height/2-50);
        textSize(40);
        fill(255, map(sin(frameCount/7.50), -1, 1, 50, 255));
        text("Click to Start", width/2, height-100);
    }

    void keyPressed() {
        if (keyCode == LEFT) {
            app.changeScene(3);
        } else if (keyCode == RIGHT) {
            app.changeScene(1);
        }
    }

    void mousePressed() {
        //fileIO.audioPlayers[0].play();
        app.changeScene(1);
    }
}

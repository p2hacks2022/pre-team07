// This tab is Title

class Title implements Scene {
    Title() {
    }

    void setup() {
    }

    void draw() {
        image(fileIO.title, 0, 0, width, height);
        textAlign(CENTER, CENTER);
        textSize(50);
        text("Title", width/2, height/2-30);
        text("Click to Start", width/2, height/2+30);
    }

    void keyPressed() {
        if (keyCode == LEFT) {
            app.changeScene(3);
        } else if (keyCode == RIGHT) {
            app.changeScene(1);
        }
    }

    void mousePressed() {
        app.changeScene(1);
    }
}

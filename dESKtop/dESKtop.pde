import ddf.minim.*;
import processing.video.*;

App app;
FileIO fileIO;
Minim minim;

void setup() {
    size(850, 550);
    minim = new Minim(this);
    fileIO = new FileIO();
    app = new App();
}

void draw() {
    app.run();
}

void keyPressed() {
    // デバッグ用
    // app.keyPressed();
}

void mousePressed() {
    app.mousePressed();
}

void movieEvent(Movie m) {
    m.read();
}

import ddf.minim.*;
import processing.video.*;

App app;
FileIO fileIO;
Minim minim;

void setup() {
    size(850, 550);
    fileIO = new FileIO();
    app = new App();
    minim = new Minim(this);
}

void draw() {
    app.run();
}

void keyPressed() {
    app.keyPressed();
}

void mousePressed() {
    app.mousePressed();
}

void movieEvent(Movie m) {
    m.read();
}

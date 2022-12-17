App app;
FileIO fileIO;

void setup() {
    size(850, 550);
    fileIO = new FileIO();
    app = new App();
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

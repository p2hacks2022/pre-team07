App app;

void setup() {
    size(800, 500);
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

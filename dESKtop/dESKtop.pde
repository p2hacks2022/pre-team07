App app;

void setup() {
    size(850, 550);
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

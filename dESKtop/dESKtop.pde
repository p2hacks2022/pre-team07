App app;

void setup() {
  size(800, 500);
  app = new App();
}

void draw() {
<<<<<<< HEAD
  new Title().draw();
=======
  app.run();
}

void keyPressed() {
  app.keyPressed();
}

void mousePressed() {
  app.mousePressed();
>>>>>>> 8a37402ee160a86c3569aa2a33fc53e4656b214a
}

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
>>>>>>> dbcf342560ad9d01073450d49be407e6609db6ea
}

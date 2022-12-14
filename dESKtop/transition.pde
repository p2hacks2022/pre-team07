class Transition implements Scene {
  final long TRANSITION_TIME = 2000;
  long transitionSpendTime;

  Transition() {
  }

  void setup() {
  }

  void draw() {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Transition", width/2, height/2);
  }

  void run(int nextScene) {
    transitionSpendTime = 0;
  }

  void keyPressed() {
  }

  void mousePressed() {
  }
}

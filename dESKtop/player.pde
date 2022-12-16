class Player {
    String name;
    PVectorInt pos;
    PVectorInt vec;
    int hp;

    Player() {
    }
}

class PVectorInt {
    int x, y;
    PVectorInt(int _x, int _y) {
        this.x = _x;
        this.y = _y;
    }
}

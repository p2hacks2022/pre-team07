class Player extends CharacterBase {
    PVectorInt pos;
    PVectorInt vec;
    int floor;

    Player() {
        this.name = "アステル";
        this.hp = 1024;
        this.firstHP = 1024;
        this.powerUpper = 300;
        this.powerLower = 100;
    }
}

class PVectorInt {
    int x, y;
    PVectorInt(int _x, int _y) {
        this.x = _x;
        this.y = _y;
    }
}

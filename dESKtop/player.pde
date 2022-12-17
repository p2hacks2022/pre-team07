class Player extends CharacterBase {
    PVectorInt pos;
    PVectorInt vec;
    
    Player() {
        this.name = "アステル";
        this.field = 1;
    }
}

class PVectorInt {
    int x, y;
    PVectorInt(int _x, int _y) {
        this.x = _x;
        this.y = _y;
    }
}

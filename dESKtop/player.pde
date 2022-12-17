class Player extends CharacterBase {
    PVectorInt pos;
    PVectorInt vec;
    int hp;
    
    Player() {
        this.name = "アステル";
    }
}

class PVectorInt {
    int x, y;
    PVectorInt(int _x, int _y) {
        this.x = _x;
        this.y = _y;
    }
}

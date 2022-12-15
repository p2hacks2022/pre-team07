class Player extends CharacterBase {
    //enum型が使えなかったのでStringで代用
    
    String name;
    PVectorInt pos;

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

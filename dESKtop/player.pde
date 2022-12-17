<<<<<<< HEAD
class Player {
    String name;
    PVectorInt pos;
    PVectorInt vec;
    int hp;

    Player() {
=======
class Player extends CharacterBase {
    //enum型が使えなかったのでStringで代用
    PVectorInt pos;

    Player() {
        this.name = "アステル";
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
    }
}

class PVectorInt {
    int x, y;
    PVectorInt(int _x, int _y) {
        this.x = _x;
        this.y = _y;
    }
}

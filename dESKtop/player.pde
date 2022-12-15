class Player {
  String name;
  PVectorInt pos;
  Inventory inventory;
  int hp;
  
  Player() {
    inventory = new Inventory();
  }

  class Inventory {
    ArrayList<Item> item;
    ArrayList<Weapon> weapon;

    Inventory() {
      item = new ArrayList<Item>();
      weapon = new ArrayList<Weapon>();
    }
  }
}

class PVectorInt {
  int x, y;
  PVectorInt(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  }
}

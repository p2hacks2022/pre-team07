class Enemy extends CharacterBase {
    int id;
    Enemy(String name, int hp, int powerUpper, int powerLower, int id) {
        this.name = name;
        this.hp = hp;
        this.firstHP = hp;
        this.powerUpper = powerUpper;
        this.powerLower = powerLower;
        this.id = id;
    }
    
    Enemy(Enemy enemy) {
        this.name = enemy.name;
        this.hp = enemy.hp;
        this.firstHP = hp;
        this.powerUpper = enemy.powerUpper;
        this.powerLower = enemy.powerLower;
    }

    void actionSelect() {
        guardType = random(1) < 0.5 ? "localGuard" : "remoteGuard";
        attackType = random(1) < 0.5 ? "localAttack" : "remoteAttack";
    }
}

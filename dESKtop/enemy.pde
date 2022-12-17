class Enemy extends CharacterBase {
    Enemy(String name, int hp, int powerUpper, int powerLower) {
        this.name = name;
        this.hp = hp;
        this.powerUpper = powerUpper;
        this.powerLower = powerLower;
    }
    
    Enemy(Enemy enemy) {
        this.name = enemy.name;
        this.hp = enemy.hp;
        this.powerUpper = enemy.powerUpper;
        this.powerLower = enemy.powerLower;
    }

    void actionSelect() {
        guardType = random(1) < 0.5 ? "localGuard" : "remoteGuard";
        attackType = random(1) < 0.5 ? "localAttack" : "remoteAttack";
    }
}

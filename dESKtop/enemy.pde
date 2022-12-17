class Enemy extends CharacterBase {
    Enemy(String name) {
        super.name = name;
    }

    void actionSelect() {
        guardType = random(1) < 0.5 ? "localGuard" : "remoteGuard";
        attackType = random(1) < 0.5 ? "localAttack" : "remoteAttack";
    }
}

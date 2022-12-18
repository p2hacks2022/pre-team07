class FileIO {
    String dataPath;
    Table saveData;
    PImage title;
    PImage[] wallImg ;
    PImage[] floorImg;
    PImage[] battleIconImg;
    PImage[] enemyImg;
    PImage keyImg;
    PImage startImg;
    PImage goalImg;
    PImage[][] playerImg;
    PImage panel;
    PImage gameOverImg;
    Movie[] movies;
    AudioPlayer[] audioPlayers;

    FileIO() {
        init();
    }

    void init() {
        dataPath = "./data/";
        saveData = loadTable(dataPath+"saveData1.csv");
        title = loadImage(dataPath+"title.png");
        wallImg = new PImage[] {
            loadImage(dataPath+"wall1.png"), 
            loadImage(dataPath+"wall2.png"), 
            loadImage(dataPath+"wall3.png")
        };
        floorImg = new PImage[] {
            loadImage(dataPath+"floor1.png"), 
            loadImage(dataPath+"floor2.png"), 
            loadImage(dataPath+"floor3.png")
        };
        battleIconImg = new PImage[]{
            loadImage(dataPath+"localGuard_image.png"), 
            loadImage(dataPath+"remoteGuard_image.png"), 
            loadImage(dataPath+"localAttack_image.png"),
            loadImage(dataPath+"remoteAttack_image.png")
        };
        enemyImg = new PImage[]{
            loadImage(dataPath+"bit.png"), 
            loadImage(dataPath+"drone.png"), 
            loadImage(dataPath+"gearfish.png"),
            loadImage(dataPath+"runner.png"),
            loadImage(dataPath+"guardmachine.png"),
            loadImage(dataPath+"lastboss.png")
        };
        keyImg = loadImage(dataPath+"key.png");
        startImg = loadImage(dataPath+"start.png");
        goalImg = loadImage(dataPath+"goal.png");
        playerImg = new PImage[][] {
            {loadImage(dataPath+"player_f1.png"), loadImage(dataPath+"player_f2.png"), loadImage(dataPath+"player_f3.png")}, 
            {loadImage(dataPath+"player_b1.png"), loadImage(dataPath+"player_b2.png"), loadImage(dataPath+"player_b3.png")}, 
            {loadImage(dataPath+"player_r1.png"), loadImage(dataPath+"player_r2.png"), loadImage(dataPath+"player_r3.png")}, 
            {loadImage(dataPath+"player_l1.png"), loadImage(dataPath+"player_l2.png"), loadImage(dataPath+"player_l3.png")}, 
        };
        panel = loadImage(dataPath+"panel.png");
        gameOverImg = loadImage(dataPath+"gameOver.png");
        movies = new Movie[]{
            new Movie(papplet, "localBarrier.mp4"), 
            new Movie(papplet, "remoteBarrier.mp4"), 
            new Movie(papplet, "localAttack.mp4"), 
            new Movie(papplet, "remoteAttack.mp4")
        };
        //audioPlayers = new AudioPlayer[]{
        //    minim.loadFile(""),
        //    minim.loadFile(""),
        //    minim.loadFile(""),
        //    minim.loadFile(""),
        //    minim.loadFile("")
        //};
    }
}

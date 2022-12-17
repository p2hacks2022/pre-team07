class FileIO {
    String dataPath;
    Table saveData;
    PImage title;
    PImage[] wallImg ;
    PImage[] floorImg;
    PImage keyImg;
    PImage startImg;
    PImage goalImg;
    PImage[][] playerImg;
    PImage panel;
    PImage gameOverImg;
    Movie[] movies;

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
            new Movie(papplet, "localBarrier.mov"), 
            new Movie(papplet, "remoteBarrier.mov"), 
            new Movie(papplet, "localAttack.mov"), 
            new Movie(papplet, "remoteAttack.mov")
        };
    }
}

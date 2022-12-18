class FileIO {
    String dataPath;
    Table saveData;
    PImage title;
    PImage transitionImg;
    PImage[] floorImg;
    PImage[] wallSideImg;
    PImage[] wallTopImg;
    PImage keyFloorImg;
    PImage keyImg;
    PImage startImg;
    PImage goalImg;
    PImage[][] playerImg;
    PImage playerStandImg;
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
        transitionImg = loadImage(dataPath+"transition.png");
        floorImg = new PImage[] {
            loadImage(dataPath+"floor1.png"), 
            loadImage(dataPath+"floor2.png"), 
            loadImage(dataPath+"floor3.png")
        };
        wallSideImg = new PImage[] {
            loadImage(dataPath+"wallSide1.png"), 
            loadImage(dataPath+"wallSide2.png"), 
            loadImage(dataPath+"wallSide2.png")
        };
        wallTopImg = new PImage[] {
            loadImage(dataPath+"wallTop1.png"), 
            loadImage(dataPath+"wallTop2.png"), 
            loadImage(dataPath+"wallTop2.png")
        };
        keyImg = loadImage(dataPath+"key.png");
        startImg = loadImage(dataPath+"start.png");
        goalImg = loadImage(dataPath+"goal.png");
        playerImg = new PImage[][] {
            {loadImage(dataPath+"player1-1.png"), loadImage(dataPath+"player1-2.png"), loadImage(dataPath+"player1-3.png")}, 
            {loadImage(dataPath+"player2-1.png"), loadImage(dataPath+"player2-2.png"), loadImage(dataPath+"player2-3.png")}, 
            {loadImage(dataPath+"player3-1.png"), loadImage(dataPath+"player3-2.png"), loadImage(dataPath+"player3-3.png")}, 
            {loadImage(dataPath+"player4-1.png"), loadImage(dataPath+"player4-2.png"), loadImage(dataPath+"player4-3.png")}
        };
        playerStandImg = loadImage(dataPath+"playerStand.png");
        keyFloorImg = loadImage(dataPath+"keyFloor.png");
        keyImg = loadImage(dataPath+"key.png");
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

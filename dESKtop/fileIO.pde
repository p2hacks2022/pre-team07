class FileIO {
    String dataPath;
    Table saveData;
    PImage title;
    PImage transitionImg;
    PImage[] floorImg;
    PImage[] wallSideImg;
    PImage[] wallTopImg;
    PImage keyFloorImg;
    PImage[] battleIconImg;
    PImage[] battleBGImg;
    PImage[] enemyImg;
    PImage keyImg;
    PImage startImg;
    PImage goalImg;
    PImage[][] playerImg;
    PImage playerStandImg;
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
        battleIconImg = new PImage[]{
            loadImage(dataPath+"localGuard_image.png"), 
            loadImage(dataPath+"remoteGuard_image.png"), 
            loadImage(dataPath+"localAttack_image.png"),
            loadImage(dataPath+"remoteAttack_image.png")
        };
        
        battleBGImg = new PImage[]{
            loadImage(dataPath+"MAP1.png"), 
            loadImage(dataPath+"MAP2.png"), 
            loadImage(dataPath+"MAP3.png"),
            loadImage(dataPath+"lastBG.png")
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

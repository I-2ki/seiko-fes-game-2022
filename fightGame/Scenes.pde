class Game{
  GameState gameState;
  Game(){
  }
  void changeState(GameState state){
    gameState = state;
  }
  void update(){
    gameState.update();
  }
}

interface GameState{
  void update();
}

class TitleLoad implements GameState{
  ThreadForLoad threadForLoad;
  TitleLoad(){
    threadForLoad = new ThreadForLoad();
    threadForLoad.start();
  }
  void update(){
    text("nowLoading...",100,100);
    if(threadForLoad.finished){
      game.changeState(new Title());
    }
  }
}

class ThreadForLoad extends Thread{
  boolean finished = false;
  ImageLoader imageLoader = new ImageLoader();
  void run(){
    imageLoader.addSpriteToQueue("Kirby.png");
    spriteListList.add(imageLoader.makeSpriteList());
    finished = true;
  }
}

class Title implements GameState{
  void update(){
    text("格ゲーもどき",width/2,height/2);
    Battle battle = new Battle();
    game.changeState(battle);
  }
}

class Select implements GameState{
  void update(){
  }
}

class Battle implements GameState{
  GameObjectManager gameObjectManager = new GameObjectManager();
  Battle(){
    gameObjectManager.addPlayer(new Kirby(100,100,1,new KeyConfig("shift","left","up","right","down","z","x","c","v")));
    gameObjectManager.addPlayer(new Kirby(100,100,2,new KeyConfig("control","a","w","d","s","q","e","tab","r")));
    gameObjectManager.addBlock(new Block(700,300,100,100));
    gameObjectManager.addBlock(new Block(500,300,100,100));
    gameObjectManager.addBlock(new Block(300,300,100,100));
  }
  void update(){
    gameObjectManager.update();
  }
}

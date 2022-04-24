class Game{
  GameState gameState = new Load();
  Assets assets = new Assets();
  Game(){
  }
  void changeState(GameState gameState){
    this.gameState = gameState;
    this.gameState.start();
  }
  void update(){
    gameState.update();
  }
}
Game game = new Game();

void setup(){
  size(1000,600);
}

void draw(){
  background(0);
  game.update();
}

class Assets{
  HashMap<String,PImage> loadedImageList = new HashMap<String,PImage>();
  Assets(){
  }
  void loadAs(String imageName,String path){
    PImage image = loadImage(path);
    loadedImageList.put(imageName,image);
  }
  PImage getImage(String imageName){
     return loadedImageList.get(imageName);
  }
}

interface GameState{
  void start();
  void update();
}

class Load implements GameState{
  void start(){
  }
  void update(){
    game.assets.loadAs("kirby","kirby.png");
    game.changeState(new Title());
  }
}

class Title implements GameState{
  void start(){
  }
  void update(){
    
  }
}

class Status{
  float maxHealth,recovery;
}

class Chara{
  Status status = new Status();
  float x = float(width)/2;
  float y = float(height)/2;
  Circle collider = new Circle(x,y,10);
  void display(){
    fill(0,255,0);
    collider.display();
  }
  void update(){
  }
}

class Weapon{
}

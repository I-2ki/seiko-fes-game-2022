Game game = new Game();

final boolean DEBUG = true;

ArrayList<ArrayList<Sprite>> spriteListList = new ArrayList<ArrayList<Sprite>>();

void setup(){
  size(1200,700);
  frameRate(60);
  
  surface.setTitle("格ゲーもどき");
  noStroke();
  
  game.changeState(new TitleLoad());
}

void draw(){
  background(0);
  game.update();
  KeyBord.update();
} //<>//

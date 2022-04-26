class Game{
  GameState gameState = new Load();
  Assets assets = new Assets();
  UIManager ui = new UIManager();
  Cursor cursor = new Cursor(width/2,height/2);
  
  class CursorButton extends Button{
    CursorButton(String labelText,float x,float y,int w,int h,int roundCorner){
      super(labelText,x,y,w,h,roundCorner);
    }
    CursorButton(String labelText,float x,float y,int w,int h){
      this(labelText,x,y,w,h,0);
    }
    boolean isHover(){
      return collision.isHitRect(cursor.collision);
    }
    void hover(){
      cursor.displayColor = color(117, 8, 0);
    }
    void unHover(){
      cursor.displayColor = color(255,241,0,100);
    }
    boolean isClicked(){
      return cursor.click;
    }
  }
  
  Game(){
  }
  void changeState(GameState gameState){
    this.gameState = gameState;
    this.gameState.start();
  }
  void update(){
    gameState.update();
    ui.update();
    keyBordUpdate();
    cursor.update();
  }
  
  class Load implements GameState{
    void start(){
      assets.loadAs("kirby","kirby.png");
    }
    void update(){
      changeState(new Title());
    }
  }
  
  class Title implements GameState{
    void start(){
    }
    void update(){
      fill(255);
      if(frameCount % 60 <= 30){
        textSize(50);
        centerText("Press any Key",500);
      }
      textSize(30);
      centerText("何かボタンを押してね",600);
    }
  }
  
  class MainGame implements GameState{
    void start(){
    }
    void update(){
    }
  }
}
Game game;

void setup(){
  size(1000,800);
  PFont font = createFont("HGPｺﾞｼｯｸM",50);
  textFont(font);
  noStroke();
  game = new Game();
}

void draw(){
  background(0);
  game.update();
}

void centerText(String text,int y){
  text(text,width/2 - textWidth(text)/2,y);
}

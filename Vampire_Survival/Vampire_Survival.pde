class Game{
  GameState gameState = new Load();
  Assets assets = new Assets();
  UIManager ui = new UIManager();
  Cursor cursor = new Cursor(width/2,height/2);
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
      
      class StartButton extends Button{
        StartButton(String labelText,float x,float y,int w,int h,int roundCorner){
          super(labelText,x,y,w,h,roundCorner);
        }
        void onClick(){
          ui.delete("Button");
          changeState(new MainGame());
        }
        void display(){
          super.display();
        }
      }
      
      
      ui.create("Button",new StartButton("GameStart",10,10,500,50,5));
    }
    void update(){
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

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
    keyBordUpdate();
  }
  
  class Load implements GameState{
    boolean isLoded = false;
    void start(){
      assets.loadAs("GentlePenguin","GentlePenguin.png");
    }
    void update(){
      if(assets.getImage("GentlePenguin") != null){
        changeState(new Title());
      }
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
      if(keyPressed){
        changeState(new Setting());
      }
    }
  }
  
  class Setting implements GameState{
    ButtonManager buttons = new ButtonManager();
    void start(){
      buttons.create("toExplain",new Button("ゲーム説明",width/2 - 250,400,500,50,5,() -> { changeState(new Explain()); }));
      buttons.create("toCharaSelect",new Button("ゲームスタート",width/2 - 250,600,500,50,5,() -> { changeState(new CharaSelect()); }));
    }
    void update(){
      buttons.update();
    }
  }
  
  class CharaSelect implements GameState{
    ButtonManager buttons = new ButtonManager();
    void start(){
      buttons.create("GentlePenguin",new ImageButton(new Rect(100,100,500,100),assets.getImage("GentlePenguin"),new Rect(50,50,100,100),"ジェントルペンギン",600,100,() -> {
        changeState(new MainGame());
      }));
    }
    void update(){
      buttons.update();
    }
  }
  
  class Explain implements GameState{
    ButtonManager buttons = new ButtonManager();
    void start(){
      buttons.create("back",new Button("戻る",800,100,100,40,5,(() -> {
        changeState(new Setting());
      })));
    }
    void update(){
      buttons.update();
      
      textSize(20);
      fill(255);
      text("このゲームは、5分間敵から生き残るゲームです。\n敵は時間が経つごとにどんどん強くなります。",50,100);
    }
  }
  
  class MainGame implements GameState{
    MainGame(){
    }
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

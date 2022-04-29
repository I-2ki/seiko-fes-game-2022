class Game{
  GameState gameState = new Load();
  Assets assets = new Assets();
  
  class NeutralButton extends Button{
    NeutralButton(String labelText,float x,float y,int w,int h){
      super(labelText,x,y,w,h,10);
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
    keyBordUpdate();
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
      if(keyPressed){
        changeState(new Setting());
      }
    }
  }
  
  class Setting implements GameState{
    ButtonManager buttons = new ButtonManager();
    
    class StartButton extends NeutralButton{
      StartButton(String labelText,float x,float y,int w,int h){
        super(labelText,x,y,w,h);
      }
      void onClick(){
        changeState(new CharaSelect());
      }
    }
    
    class ExplainButton extends NeutralButton{
      ExplainButton(String labelText,float x,float y,int w,int h){
        super(labelText,x,y,w,h);
      }
      void onClick(){
        changeState(new Explain());
      }
    }
    void start(){
      buttons.create("Explain",new ExplainButton("説明",width / 2 - 150,200,300,100));
      buttons.create("StartButton",new StartButton("ゲームスタート",width / 2 - 300,500,600,100));
    }
    void update(){
      buttons.update();
    }
  }
  
  class CharaSelect implements GameState{
    class GenPeButton extends ImageButton{
      GenPeButton(){
      }
    }
    void start(){
    }
    void update(){
      
    }
  }
  
  class Explain implements GameState{
    void start(){
    }
    void update(){
      textSize(20);
      fill(255);
      text("このゲームは、5分間敵から生き残るゲームです。\n敵は時間が経つごとにどんどん強くなります。",0,100);
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

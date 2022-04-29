Assets assets = new Assets();

interface GameState{
  void start();
  void update();
}

class Game{
  GameState gameState;
  Game(){
  }
  class Title implements GameState{
    ButtonManager buttons = new ButtonManager();
    void start(){
      buttons.create("Explain",new Button("説明を見る",width/2-300,350,600,100,5,() -> {
        changeState(new Explain());
      }));
      buttons.create("StartButton",new Button("ゲームを始める",width/2-300,500,600,100,5,() -> {
        changeState(new MainGame());
      }));
    }
    void update(){
      buttons.update();
      textSize(50);
      fill(255);
      centerText("ジェンぺを逃そう!",300);
    }
  }
  
  class Explain implements GameState{
    ButtonManager buttons = new ButtonManager();
    void start(){
      buttons.create("back",new Button("タイトルに戻る",550,80,200,30,5,() -> {
        changeState(new Title());
      }));
    }
    void update(){
      fill(255);
      textSize(25);
      text("〜あらすじ〜\nある日、ジェントルペンギンは空を飛びましたとさ。\nしかし、そこに通りかかった聖光生。\n意地悪な聖光生はジェンぺを焼き鳥にしようと企んでいます。\n串刺しにならないように助けてあげて！",0,100);
      text("〜操作方法〜\nスティックでボタンを選択、\n1ボタンでジェンぺを浮かせられます。",0,400);
      buttons.update();
    }
  }
  
  class MainGame implements GameState{
    class Timer{
      int baseTime;
      Timer(){
        baseTime = millis();
      }
      void display(){
        textSize(30);
        fill(255);
        centerText("Time:"+getMinute()+"分"+getSecond()+"秒",50);
      }
      void countRestart(){
        baseTime = millis();
      }
      int getRowSecond(){
        return (millis() - baseTime)/1000;
      }
      int getSecond(){
        return ((millis() - baseTime)/1000)%60;
      }
      int getMinute(){
        return ((millis() - baseTime)/1000/60)%60;
      }
    }
    Timer timer = new Timer();
    
    class Player extends Rect{
      final float gravity = 0.7;
      final float jumpPower = 10;
      float vy = 0;
      Player(float x){
        super(x,300,40,50);
      }
      void display(){
        PImage img = assets.getImage("player");
        image(img,x-5,y,45,50);
      }
      void update(){
        display();
        if(isPut("z")){
          vy = -jumpPower;
        }
        if(!isHitRect(new Rect(0,0,width,height))){
          changeState(new GameOver());
        }
        
        vy += gravity;
        y += vy;
      }
    }
    Player player = new Player(100);
    
    class Enemy extends Rect{
      float speed = 5;
      boolean destroy = false;
      Enemy(float y,float h){
        super(800,y,10,h);
      }
      void display(){
        noStroke();
        fill(245,194,66);
        super.display();
      }
      void update(){
        display();
        x -= speed;
        if(isHitRect(player)){
          changeState(new GameOver());
        }
        if(x < -10){
          destroy = true;
        }
      }
    }
    
    class EnemyDispatcher{
      ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
      int willTime = 2;
      void add(){
        if(willTime <= timer.getRowSecond()){
          float heightLengthSum = 800 - (100+700/(timer.getMinute()+3));
          float firstLength = random(0,heightLengthSum);
          enemyList.add(new Enemy(0,firstLength));
          enemyList.add(new Enemy(800 - (heightLengthSum - firstLength),heightLengthSum - firstLength));
          willTime += int(random(1,4));
        }
      }
      void update(){  
        add();
        for(Enemy enemy:enemyList){
          enemy.update();
          if(enemy.destroy){
          }
        }
      }
    }
    EnemyDispatcher enemyDispatcher = new EnemyDispatcher();
    
    void start(){
    }
    void update(){
      player.update();
      enemyDispatcher.update();
      timer.display();
    }
  }
  
  class GameOver implements GameState{
    ButtonManager buttons = new ButtonManager();
    GameOver(){
    }
    void start(){
      buttons.create("backTitle",new Button("タイトルに戻る",width/2 - 300,300,600,100,() -> {
        changeState(new Title());
      }));
      buttons.create("reTry",new Button("リトライ",width/2 - 300,500,600,100,() -> {
        changeState(new MainGame());
      }));
    }
    void update(){
      buttons.update();
      fill(255);
      textSize(70);
      centerText("GameOver",200);
    }
  }
  void start(){
    changeState(new Title());
  }
  
  void update(){
    gameState.update();
  }
  void changeState(GameState gameState){
    this.gameState = gameState;
    this.gameState.start();
  }
}

Game game = new Game();

void setup(){
  size(800,800);
  PFont font = createFont("HGPｺﾞｼｯｸM",50);
  textFont(font);
  assets.loadAs("player","ジェンぺ.png");
  assets.loadAs("back","雲.png");
  noStroke();
  game.start();
}

void draw(){
  background(75,191,201);
  game.update();
}

void centerText(String text,int y){
  text(text,width/2 - textWidth(text)/2,y);
}

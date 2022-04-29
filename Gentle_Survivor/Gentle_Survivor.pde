class Game{
  GameState gameState = new Title();
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
      buttons.create("toCharaSelect",new Button("ゲームスタート",width/2 - 250,600,500,50,5,() -> { changeState(new MainGame()); }));
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
    Timer timer = new Timer();
    Camera camera = new Camera();
    
    class Player{
      Circle collision = new Circle(width/2,height/2,30);
      PImage image = assets.getImage("Player");
      int HP = 100;
      Player(){
      }
      void display(){
        noStroke();
        fill(255,0,0);
        camera.drawImage(image,collision.x - 15,collision.y,collision.size,collision.size);
      }
      void update(){
        if(isPut("left")){
          collision.x -= camera.moveSpeed;
        }
        if(isPut("right")){
          collision.x += camera.moveSpeed;
        }
        if(isPut("up")){
          collision.y -= camera.moveSpeed;
        }
        if(isPut("down")){
          collision.y += camera.moveSpeed;
        }
        println(HP);
      }
    }
    Player player = new Player();
    
    class Enemy{
      Circle collision;
      PImage image;
      int damageCoolDown = 0;
      int damagedCoolDown = 0;
      float speed = 1;
      Enemy(PImage image,float x,float y,int size){
        collision = new Circle(x,y,size);
        this.image = image;
      }
      void display(){
        camera.drawImage(image,collision.x - collision.size/2,collision.y,collision.size,collision.size);
      }
      void update(){
        collision.x -= getMoveVectorX();
        collision.y -= getMoveVectorY();
        
        if(collision.isHit(player.collision) && damageCoolDown <= 0){
          player.HP--;
          damageCoolDown = 5;
        }else{
          damageCoolDown--;
        }
      }
      float getMoveVectorX(){
        float dx = collision.x - player.collision.x;
        float dy = collision.y - player.collision.y;
        float distance = sqrt(dx*dx+dy*dy);
        
        return dx/distance*speed;
      }
      float getMoveVectorY(){
        float dx = collision.x - player.collision.x;
        float dy = collision.y - player.collision.y;
        float distance = sqrt(dx*dx+dy*dy);
        return dy/distance*speed;
      }
    }
    Enemy enemy = new Enemy(assets.getImage("Enemy"),100,30,30);
    
    MainGame(){
    }
    void start(){
    }
    void update(){
      player.display();
      player.update();
      
      enemy.display();
      enemy.update();
      
      camera.moveCamera();
      
      timer.display();
    }
  }
}
Game game;
Assets assets = new Assets();

void setup(){
  size(1000,800);
  frameRate(60);
  PFont font = createFont("HGPｺﾞｼｯｸM",50);
  textFont(font);
  noStroke();
  game = new Game();
  assets.loadAs("Player","GentlePenguin.png");
  assets.loadAs("Enemy","Fish.png");
}

void draw(){
  background(0);
  game.update();
}

void centerText(String text,int y){
  text(text,width/2 - textWidth(text)/2,y);
}

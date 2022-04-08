class GameObject extends Rect{
  ArrayList<Sprite> spriteList = new ArrayList<Sprite>();
  int spriteNum = 0;
  float vx,vy;
  GameObject(float x,float y,int w,int h){
    super(x,y,w,h);
  }
  void update(){
    x += vx;
    y += vy;
    
    display();
  }
  void display(){
    if((spriteList.size() <= 0)){
      super.display();
    }else{
      image(spriteList.get(spriteNum).getImage(),x,y,w,h);
    }
    if(DEBUG){
      super.display();
    }
  }
}

class Block extends GameObject{
  Block(int x,int y,int w,int h){
    super(x,y,w,h);
  }
  void display(){
    if((spriteList.size() <= 0)){
      fill(0,255,0);
      rect(x,y,w,h);
    }else{
      image(spriteList.get(spriteNum).getImage(),x,y,w,h);
    }
    if(DEBUG){
      fill(0,255,0);
      rect(x,y,w,h);
    }
  }
}

class Judge extends GameObject{
  int giveDamage;
  float giveVectorX,giveVectorY;
  Judge(float x,float y,int w,int h,int giveDamage,float giveVectorX,float giveVectorY){
    super(x,y,w,h);
    this.giveDamage = giveDamage;
    this.giveVectorX = giveVectorX;
    this.giveVectorY = giveVectorY;
  }
  void update(){
    super.update();
  }
  void display(){
    if(DEBUG){
      fill(0,0,255);
      rect(x,y,w,h);
    }
  }
  void whenHit(Player hitedPlayer){
    hitedPlayer.damage += giveDamage;
  }
}

class Player extends GameObject{
  PlayerAction nowPlayerAction;
  
  float gravity,jumpPower,airJumpPower,walkSpead,airWalkSpead;
  int numOfJump,maxNumOfJump;
  boolean onGround;
  
  String state = "free";
  JudgeManager judgeManager = new JudgeManager();
  KeyConfig keyConfig;
  Rect preRect;
  int playerNumber,damage;
  int front = -1;//-1で左、1で右
  Player(float x,float y,int w,int h,int playerNumber,KeyConfig keyConfig){
    super(x,y,w,h);
    this.keyConfig = keyConfig;
  }
  void update(){
    preRect = new Rect(x,y,w,h);//衝突応答のため前フレームの当たり判定を保存

    vx *= 0.9;
    vy *= 0.95;
    
    vy += gravity;
    
    if(nowPlayerAction == null){
      if(onGround){
        groundAction();
      }else{ 
        airAction();
      }
    }else{
      nowPlayerAction.update();
    }
    if(onGround){
      if(keyConfig.isPut("left")){
        groundLeftMove();
      }
      if(keyConfig.isPut("right")){
        groundRightMove();
      }
    }else{
      if(keyConfig.isPut("left")){
        airLeftMove();
      }
      if(keyConfig.isPut("right")){
        airRightMove();
      }
    }
    
    judgeManager.update();
    super.update();
  }
  void whenLand(){
    numOfJump = maxNumOfJump;
  }
  void groundAction(){
    if(keyConfig.isPut("normalAttack")){
      if(keyConfig.isPut("left")){
        wideNormalAttack();
      }else if(keyConfig.isPut("up")){
        upNormalAttack();
      }else if(keyConfig.isPut("right")){
        wideNormalAttack();
      }else if(keyConfig.isPut("down")){
        downNormalAttack();
      }else{
        normalAttack();
      }
    }else if(keyConfig.isPut("moveAttack")){
      if(keyConfig.isPut("left")){
        if(keyConfig.isPut("left")){
          wideMoveAttack();
        }else if(keyConfig.isPut("up")){
          upMoveAttack();
        }else if(keyConfig.isPut("right")){
          wideMoveAttack();
        }else if(keyConfig.isPut("down")){
          downMoveAttack();
        }else{
          moveAttack();
        }
      }
    }else{
      if(keyConfig.isPutOnce("jump")){
        groundJump();
      }
      if(keyConfig.isPut("down")){
        squat();
      }
      if(keyConfig.isPut("shiled")){
        shiled();
      }
      if(keyConfig.isPut("grab")){
        grab();
      }
    }
  }
  void airAction(){
    if(keyConfig.isPut("normalAttack")){
      if(keyConfig.isPut("left")){
        if(front == -1){
          airInfrontNormalAttack();
        }else{
          airBehindNormalAttack();
        }
      }else if(keyConfig.isPut("up")){
        airUpNormalAttack();
      }else if(keyConfig.isPut("right")){
        if(front == 1){
          airInfrontNormalAttack();
        }else{
          airBehindNormalAttack();
        }
      }else if(keyConfig.isPut("down")){
        airDownNormalAttack();
      }else{
        airNormalAttack();
      }
    }else if(keyConfig.isPut("moveAttack")){
      if(keyConfig.isPut("left")){
        airWideMoveAttack();
      }else if(keyConfig.isPut("up")){
        airUpMoveAttack();
      }else if(keyConfig.isPut("right")){
        airWideMoveAttack();
      }else if(keyConfig.isPut("down")){
        airDownMoveAttack();
      }else{
        airMoveAttack();
      }
    }else{
      if(keyConfig.isPutOnce("jump")){
        airJump();
      }
      if(keyConfig.isPut("down")){
        swoop();
      }
      if(keyConfig.isPut("shiled")){
        avoid();
      }
    }
  }
  //こっからワザ
  void groundJump(){
    onGround = false;
    vy = -1*jumpPower;
  }
  void airJump(){
    if(numOfJump > 0){
     vy = -1*airJumpPower;
     numOfJump--;
    }
  }
  void groundLeftMove(){
    front = -1;
    vx -= walkSpead;
  }
  void groundRightMove(){
    front = 1;
    vx += walkSpead;
  }
  void airLeftMove(){
    front = -1;
    vx -= airWalkSpead;
  }
  void airRightMove(){
    front = 1;
    vx += airWalkSpead;
  }
  void shiled(){
    
  }
  void avoid(){}
  void squat(){
  }
  void swoop(){
    vy = 10;
  }
  void grab(){}
  void normalAttack(){}
  void wideNormalAttack(){}
  void upNormalAttack(){}
  void downNormalAttack(){}
  void moveAttack(){}
  void wideMoveAttack(){}
  void upMoveAttack(){}
  void downMoveAttack(){}
  void airNormalAttack(){}
  void airInfrontNormalAttack(){}
  void airUpNormalAttack(){}
  void airBehindNormalAttack(){}
  void airDownNormalAttack(){}
  void airMoveAttack(){}
  void airWideMoveAttack(){}
  void airUpMoveAttack(){}
  void airDownMoveAttack(){}
}

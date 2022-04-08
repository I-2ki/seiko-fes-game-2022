class Kirby extends Player{
  Kirby(float x,float y,int playerNumber,KeyConfig keyConfig){
    super(x,y,50,50,playerNumber,keyConfig);
    jumpPower = 10;
    airJumpPower = 10;
    maxNumOfJump = 99999;
    numOfJump = maxNumOfJump;
    gravity = 0.2;
    walkSpead = 1;
    airWalkSpead = 0.5;
  }
  void airUpMoveAttack(){
    FinalCutter finalCutter = new FinalCutter(this);
    nowPlayerAction = finalCutter;
  }
}

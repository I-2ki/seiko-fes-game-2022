class ActionFrame{
  Player player;
  int calledFrame;
  ActionFrame(){
  }
  void update(){
  }
}

class TimeLine{
  ArrayList<ActionFrame> actionFrameList = new ArrayList<ActionFrame>();
  TimeLine(){
  }
  void add(int calledFrame,ActionFrame addActionFrame){
    addActionFrame.calledFrame = calledFrame;
    actionFrameList.add(addActionFrame);
  }
  void addManyFrame(int firstFrame,int finalFrame,ActionFrame actionFrame){
    for(int i = 0;i < finalFrame - firstFrame + 1;i++){
      add(int(firstFrame+i),actionFrame);
    }
  }
  void updateActionWithFrame(int calledFrame){
    for(ActionFrame actionFrame:actionFrameList){
      if(actionFrame.calledFrame == calledFrame){
        actionFrame.update();
      }
    }
  }
  void setPlayerToActionFrame(Player player){
    for(ActionFrame actionFrame:actionFrameList){
      actionFrame.player = player;
    }
  }
}

class PlayerAction{
  Player player;
  int nowFrame = 0;
  int ALLFRAME;
  TimeLine timeLine = new TimeLine();
  PlayerAction(Player player,int ALLFRAME){
    this.player = player;
    this.ALLFRAME = ALLFRAME;
  }
  void update(){
    timeLine.setPlayerToActionFrame(player);
    if(nowFrame <= ALLFRAME){
      timeLine.updateActionWithFrame(nowFrame);
      nowFrame++;
    }else{
      player.nowPlayerAction = null;
    }
  }
}

class FinalCutter extends PlayerAction{
  FinalCutter(Player player){
    super(player,80);
    class Rise extends ActionFrame{
      void update(){
        player.vy = -50;
      }
    }
    class Swoop extends ActionFrame{
      void update(){
        player.vy = 15;
      }
    }
    class UpdateAttackJudge extends ActionFrame{
      void update(){
        //player.clearJudge();
        //player.addJudge(new Judge(player.x + player.front * 50,player.y,50,10,100,player.front*-10,-10));
        println(nowFrame);
      }
    }
    timeLine.add(23,new Rise());
    timeLine.addManyFrame(41,50,new Swoop());
    timeLine.addManyFrame(23,63,new UpdateAttackJudge());
  }
}

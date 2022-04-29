class GameObjectManager{
  PlayerManager playerManager = new PlayerManager();
  BlockManager blockManager = new BlockManager();
  GameObjectManager(){
  }
  void addPlayer(Player player){
    playerManager.add(player);
  }
  void addBlock(Block block){
    blockManager.add(block);
  }
  void update(){
    PassBlockInformationToPlayer();
    playerManager.update();
    blockManager.update();
  }
  void PassBlockInformationToPlayer(){
    playerManager.blockList = blockManager.blockList;
  }
}

class PlayerManager{
  ArrayList<Player> playerList = new ArrayList<Player>();
  ArrayList<Block> blockList;
  PlayerManager(){ 
  }
  void add(Player player){
    playerList.add(player);
  }
  void update(){
    sendInfoPlayer();
    for(Player player:playerList){
      player.update();
    }
  }
  boolean onGround(Player player){
    if(blockList == null){
      return false;
    }
    for(Block block:blockList){
      if(!player.isHit(block)){
        return false;
      }
    }
    return player.onGround;
  }
  void sendInfoPlayer(){
    for(Player player:playerList){
      player.onGround = onGround(player);
      setPosition(player);
    }
  }
  void setPosition(Player player){
    for(Block block:blockList){
      if(!player.isHit(block)){
        continue;
      }
      Rect r = player.preRect;
      if((r.x + r.w <= block.x) && (block.y < r.y + r.h) && (r.y < block.y + block.h)){
        player.vx *= -1;
        player.x -= (player.x + player.w) - block.x;
      }
      if((block.x + block.w <= r.x) && (r.y < block.y + block.h) && (block.y < r.y + r.h)){
        player.vx *= -1;
        player.x += (block.x + block.w) - player.x;
      }
      if((r.y + r.h <= block.y) && (block.x < r.x + r.w) && (r.x < block.x + block.w)){
        player.vy = 0;
        player.y = block.y - player.h;
        player.onGround = true;
        player.whenLand();
      }
      if((block.y + block.h <= r.y) && (r.x < block.x + block.w) && (block.x < r.x + r.w)){
        player.vy *= -1;
        player.y += (block.y + block.h) - player.y;
      }
    }
  }
}

class JudgeManager{
  ArrayList<Judge> judgeList = new ArrayList<Judge>();
  JudgeManager(){
  }
  void add(Judge judge){
    judgeList.add(judge);
  }
  void remove(Judge _judge){
    for(int i = 0;i < judgeList.size();i++){
      Judge judge = judgeList.get(i);
      if(_judge == judge){
        judgeList.remove(i);
        return;
      }
    }
  }
  void clearJudge(){
    for(int i = 0;i < judgeList.size();i++){
      judgeList.remove(i);
    }
  }
  void update(){
    for(int i = 0;i < judgeList.size();i++){
      Judge judge = judgeList.get(i);
      judge.update();
    }
  }
}

class BlockManager{
  ArrayList<Block> blockList = new ArrayList<Block>();
  BlockManager(){
  }
  void add(Block block){
    blockList.add(block);
  }
  void update(){
    for(int i = 0;i < blockList.size();i++){
      Block block = blockList.get(i);
      block.update();
    }
  }
}

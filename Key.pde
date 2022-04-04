class KeyConfig{
  HashMap <String,String> keyConfig = new HashMap<String,String>();
  KeyConfig(String jump,String left,String up,String right,String down,String normalAttack,String moveAttack,String shiled,String grab){
    setKey("jump",jump);
    setKey("left",left);
    setKey("up",up);
    setKey("right",right);
    setKey("down",down);
    setKey("normalAttack",normalAttack);
    setKey("moveAttack",moveAttack);
    setKey("shiled",shiled);
    setKey("grab",grab);
  }
  void setKey(String buttonName,String key){
    keyConfig.put(buttonName,key);
  }
  boolean isPut(String button){
    if(keyConfig.get(button) == null){
      return false;
    }
    String key = keyConfig.get(button);
    return KeyBord.isPut(key);
  }
  boolean isPutOnce(String button){//押し続けても最初の1fのみ反応
    if(keyConfig.get(button) == null){
      return false;
    }
    String key = keyConfig.get(button);
    return KeyBord.isPutOnce(key);
  }
}

HashMap <String,Boolean> isPutKeyMap = new HashMap<String,Boolean>();
HashMap <String,Boolean> canPutKeyMap = new HashMap<String,Boolean>();
HashMap <String,Integer> FrameKeyMap = new HashMap<String,Integer>();

void keyBordUpdate(){
  for(String key:isPutKeyMap.keySet()){
    if(FrameKeyMap.get(key) == null){
      FrameKeyMap.put(key,0);
      continue;
    }
    if(isPut(key)){
      int frame = FrameKeyMap.get(key) + 1;
      FrameKeyMap.put(key,frame); 
    }else{
      FrameKeyMap.put(key,0);
    }
  }
}

boolean isPut(String key){
  if(isPutKeyMap.get(key) == null){
    return false;
  }else{
    return isPutKeyMap.get(key);
  }
}

boolean isPutOnce(String key){
  if((isPutKeyMap.get(key) == null)||(canPutKeyMap.get(key) == null)){
    return false;
  }
  if((canPutKeyMap.get(key))&&(isPutKeyMap.get(key))){
    canPutKeyMap.put(key,false);
    return true;
  }else{
    return false;
  }
}

int nowFrameOf(String key){//押されていないときは0を返す
  if(FrameKeyMap.get(key) == null){
    return 0;
  }else{
    return FrameKeyMap.get(key);
  }
}

void updateKeyStatus(String key,boolean putValue){
  isPutKeyMap.put(key,putValue);
  if(putValue == false){
    canPutKeyMap.put(key,true);
  }
}

void changeKeyCordToString(boolean putValue){
  if(key == CODED){
    switch(keyCode){
      case(LEFT):{
        updateKeyStatus("left",putValue);
        break;
      }
      case(UP):{
        updateKeyStatus("up",putValue);
        break;
      }
      case(RIGHT):{
        updateKeyStatus("right",putValue);
        break;
      }
      case(DOWN):{
        updateKeyStatus("down",putValue);
        break;
      }
      case(ALT):{
        updateKeyStatus("alt",putValue);
        break;
      }
      case(CONTROL):{
        updateKeyStatus("control",putValue);
        break;
      }
      case(SHIFT):{
        updateKeyStatus("shift",putValue);
        break;
      }
      default:{
        updateKeyStatus(str(keyCode),putValue);
        break;
      }
    }
  }else{
    switch(key){
      case(TAB):{
        updateKeyStatus("tab",putValue);
        break;
      }
      case(BACKSPACE):{
        updateKeyStatus("backSpace",putValue);
        break;
      }
      case(ENTER):{
        updateKeyStatus("enter",putValue);
        break;
      }
      case(DELETE):{
        updateKeyStatus("delete",putValue);
        break;
      }
      case(ESC):{
        updateKeyStatus("esc",putValue);
        break;
      }
      case(RETURN):{
        updateKeyStatus("return",putValue);
        break;
      }
      default:{
        if(str(key) == " "){
          updateKeyStatus("space",putValue); 
        }else{
          updateKeyStatus(str(key).toLowerCase(),putValue);
        }
        break;
      }
    }
  }
}

void keyPressed(){
  changeKeyCordToString(true);
}

void keyReleased(){
  changeKeyCordToString(false);
}

class Rect{
  float x,y;
  int w,h;
  Rect(float x,float y,int w,int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  boolean isHit(Rect other){
    boolean direction_x = (other.x <= x + w)&&(x <= other.x + other.w);
    boolean direction_y = (other.y <= y + h)&&(y <= other.y + other.h);
    return direction_x && direction_y;
  }
  void display(){
    fill(255);
    rect(x,y,w,h);
  }
}

class Sprite{
  PImage image;
  Rect rect;
  Sprite(PImage image,Rect rect){
    this.rect = rect;
    this.image = image.get(int(rect.x),int(rect.y),rect.w,rect.h);
  }
  PImage getImage(){
    return image;
  }
}

class ImageLoader{
  ArrayList<Sprite> spriteQueue = new ArrayList<Sprite>();
  void addSpriteToQueue(String imagePath,Rect range){
    PImage image = loadImage(imagePath);
    spriteQueue.add(new Sprite(image,range));
  }
  void addSpriteToQueue(String imagePath){
    PImage image = loadImage(imagePath);
    spriteQueue.add(new Sprite(image,new Rect(0,0,image.width,image.height)));
  }
  ArrayList<Sprite> makeSpriteList(){
    return spriteQueue;
  }
  void resetQueue(){
    spriteQueue.clear();
  }
}

public static class KeyBord{//使うときは必ずKeyBord.update()をdraw()内で実行する
  private static final HashMap <String,Boolean> isPutKeyMap = new HashMap<String,Boolean>();
  private static final HashMap <String,Boolean> canPutKeyMap = new HashMap<String,Boolean>();
  private static final HashMap <String,Integer> FrameKeyMap = new HashMap<String,Integer>();
  public static void update(){
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
  public static boolean isPut(String key){
    if(isPutKeyMap.get(key) == null){
      return false;
    }else{
      return isPutKeyMap.get(key);
    }
  }
  public static boolean isPutOnce(String key){
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
  public static int nowFrameOf(String key){//いつでも押されていないときは0を返す
    if(FrameKeyMap.get(key) == null){
      return 0;
    }else{
      return FrameKeyMap.get(key);
    }
  }
}

void setOnKey(boolean putValue){
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

void updateKeyStatus(String key,boolean putValue){
  KeyBord.isPutKeyMap.put(key,putValue);
  if(putValue == false){
    KeyBord.canPutKeyMap.put(key,true);
  }
}


void keyPressed(){
  setOnKey(true);
}

void keyReleased(){
  setOnKey(false);
}

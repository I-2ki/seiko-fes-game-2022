class Game{
  GameState gameState = new Load();
  Assets assets = new Assets();
  UIManager ui = new UIManager();
  KeyBord keyBord = new KeyBord();
  Mouse mouse = new Mouse();
  Game(){
  }
  void changeState(GameState gameState){
    this.gameState = gameState;
    this.gameState.start();
  }
  void update(){
    gameState.update();
    ui.update();
    keyBord.update();
  }
}
Game game = new Game();

interface GameState{
  void start();
  void update();
}

class Assets{
  HashMap<String,PImage> loadedImageList = new HashMap<String,PImage>();
  Assets(){
  }
  void loadAs(String imageName,String path){
    PImage image = loadImage(path);
    loadedImageList.put(imageName,image);
  }
  PImage getImage(String imageName){
     return loadedImageList.get(imageName);
  }
}

interface UI{
  void update();
}

class Button implements UI{
  Rect collision;
  String labelText;
  Button(String labelText,float x,float y,int w,int h,int roundCorner){
    collision = new Rect(x,y,w,h,roundCorner);
    this.labelText = labelText;
  }
  void onClick(){ 
  }
  void hover(){
    if(collision.isPointInside(mouseX,mouseY)){
      cursor(HAND);
    }else{
      cursor(ARROW);
    }
  }
  void display(){
    float fontSize = collision.h*0.8;
    textSize(fontSize);
    rect(collision.x,collision.y,collision.w,collision.h,collision.roundCorner);
    fill(0);
    text(labelText,collision.x + collision.w/2 - textWidth(labelText)/2,collision.y + fontSize);
  }
  void update(){
    display();
    hover();
    if(collision.isPointInside(mouseX,mouseY) && mousePressed){
      onClick();
    }
  }
}

class UIManager{
  HashMap<String,UI> uiList = new HashMap<String,UI>();
  UIManager(){
  }
  void create(String id,UI ui){
    uiList.put(id,ui);
  }
  void delete(String id){
    uiList.remove(id);
  }
  void update(){
    for(String key:uiList.keySet()){
      UI ui = uiList.get(key);
      ui.update();
    }
  }
}

class Rect{
  float x,y;
  int w,h,roundCorner;
  Rect(float x,float y,int w,int h,int roundCorner){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.roundCorner = roundCorner;
  }
  boolean isHitRect(Rect other){
    boolean direction_x = (other.x <= x + w)&&(x <= other.x + other.w);
    boolean direction_y = (other.y <= y + h)&&(y <= other.y + other.h);
    return direction_x && direction_y;
  }
  boolean isPointInside(float x,float y){
    return ((this.x < x)&&(x < this.x + this.w)&&(this.y < y)&&(y < this.y + this.h));
  }
  void display(){
    fill(255);
    rect(x,y,w,h,roundCorner);
  }
}

class Circle{
  float x,y;
  int size;
  Circle(float x,float y,int size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  void display(){
    ellipse(x,y,size,size);
  }
  boolean isHit(Circle other){
    return (dist(x,y,other.x,other.y) <= size + other.size);
  }
}

class Mouse{
  void update(){
  }

  boolean isClickOnce(){
    return true;
  }
}

void mousePressed(){
  println(mouseButton);
}

void mouseReleased(){
}

class KeyBord{
  HashMap <String,Boolean> isPutKeyMap = new HashMap<String,Boolean>();
  HashMap <String,Boolean> canPutKeyMap = new HashMap<String,Boolean>();
  HashMap <String,Integer> FrameKeyMap = new HashMap<String,Integer>();
  void update(){
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
  int nowFrameOf(String key){//いつでも押されていないときは0を返す
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
}

void keyPressed(){
  game.keyBord.changeKeyCordToString(true);
}

void keyReleased(){
  game.keyBord.changeKeyCordToString(false);
}

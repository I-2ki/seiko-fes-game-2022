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
  Rect(float x,float y,int w,int h){
    this(x,y,w,h,0);  
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

class ButtonManager{
  HashMap<String,Button> buttonList = new HashMap<String,Button>();
  int selectedIndex = 0;
  ButtonManager(){
  }
  void create(String id,Button button){
    buttonList.put(id,button);
  }
  void delete(String id){
    buttonList.remove(id);
  }
  void update(){
    moveSelect();
    int count = 0;
    for(String key : buttonList.keySet()){
      Button button = buttonList.get(key);
      button.update();
      if(selectedIndex == count){
        button.isSelected = true; 
      }else{
        button.isSelected = false;
      }
      count++;
    }
  }
  void moveSelect(){
    if(isPutOnce("left")){
      selectedIndex--;
    }
    if(isPutOnce("right")){
      selectedIndex++;
    }
    if(isPutOnce("up")){
      selectedIndex--;
    }
    if(isPutOnce("down")){
      selectedIndex++;
    }
    if(selectedIndex < 0){
      selectedIndex = 0;
    }
    if(buttonList.size() - 1 < selectedIndex){
      selectedIndex = buttonList.size() - 1;
    }
  }
}

class Button{
  Rect collision;
  String labelText;
  boolean isSelected;
  Button(String labelText,float x,float y,int w,int h,int roundCorner){
    collision = new Rect(x,y,w,h,roundCorner);
    this.labelText = labelText;
  }
  Button(String labelText,float x,float y,int w,int h){
    this(labelText,x,y,w,h,0);
  }
  void onClick(){ 
  }
  void display(){
    fill(7,179,53);
    drawButtonBody();
    fill(255);  
    drawButtonText();
  }
  void drawButtonText(){
    float fontSize = collision.h*0.8;
    textSize(fontSize);
    text(labelText,collision.x + collision.w/2 - textWidth(labelText)/2,collision.y + fontSize);
  }
  void drawButtonBody(){
    if(isSelected){
      stroke(255,255,0);
      strokeWeight(5);
    }else{
      noStroke();
    }
    rect(collision.x,collision.y,collision.w,collision.h,collision.roundCorner);
  }
  boolean isClicked(){
    return isPutOnce("z");
  }
  void update(){
    display();
    if(isSelected && isClicked()){
      onClick();
    }
  }
}

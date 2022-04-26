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

interface UI{
  void update();
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

class Button implements UI{
  Rect collision;
  String labelText;
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
    rect(collision.x,collision.y,collision.w,collision.h,collision.roundCorner);
  }
  boolean isHover(){
    return collision.isPointInside(mouseX,mouseY);
  }
  void hover(){
    cursor(HAND);
  }
  void unHover(){
    cursor(ARROW);
  }
  boolean isClicked(){
    return mousePressed;
  }
  void update(){
    display();
    if(isHover()){
      hover();
      if(isClicked()){
        onClick();
      }
    }else{
      unHover();
    }
  }
}

class Cursor{
  boolean click = false;
  Rect collision;
  color displayColor = color(255,241,0,100);
  final int moveSpead = 5;
  Cursor(int initalX,int initalY){
    collision = new Rect(initalX,initalY,30,30);
  }
  void display(){
    fill(displayColor);
    collision.display();
  }
  void update(){
    display();
    if(isPut("left")){
      collision.x -= moveSpead;
    }
    if(isPut("right")){
      collision.x += moveSpead;
    }
    if(isPut("up")){
      collision.y -= moveSpead;
    }
    if(isPut("down")){
      collision.y += moveSpead;
    }
    if(isPut("z")){
      click = true;
    }else{
      click = false;
    }
  }
}

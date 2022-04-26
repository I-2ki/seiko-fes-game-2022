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
  void hover(){
    if(collision.isPointInside(mouseX,mouseY)){
      cursor(HAND);
    }else{
      cursor(ARROW);
    }
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
  boolean isClicked(){
    return (collision.isPointInside(mouseX,mouseY) && mousePressed);
  }
  void update(){
    display();
    hover();
    if(isClicked()){
      onClick();
    }
  }
}

class Cursor{
  Circle collision;
  Cursor(int initalX,int initalY){
    collision = new Circle(initalX,initalY,50);
  }
  void display(){
    fill(255,241,0,100);
    collision.display();
  }
  void update(){
    display();
    if(isPut("left")){
      collision.x --;
    }
  }
}

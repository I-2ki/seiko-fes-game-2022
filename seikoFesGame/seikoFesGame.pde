void setup(){
  size(1000,500);
  noStroke();
}

void draw(){
  background(0);
  KeyBord.update();
}

class Player extends Circle{
  float vx,vy;
  Player(){
    
  }
  void update(){
  }
}

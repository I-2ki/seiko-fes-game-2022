void setup(){
  size(1000,600);
  PFont font = createFont("HGPｺﾞｼｯｸM",50);
  textFont(font);
  noStroke();
}

void draw(){
  background(255);
  game.update();
}

class Load implements GameState{
  void start(){
    game.assets.loadAs("kirby","kirby.png");
  }
  void update(){
    game.changeState(new Title());
  }
}

class Title implements GameState{
  void start(){
    class StartButton extends Button{
      StartButton(String labelText,float x,float y,int w,int h,int roundCorner){
        super(labelText,x,y,w,h,roundCorner);
      }
      void display(){
        fill(180,0,0);
        super.display();
      }
    }
    game.ui.create("Button",new StartButton("ABCDEFG",10,10,500,50,5));
  }
  void update(){
  }
}

class MainGame implements GameState{
  void start(){
  }
  void update(){
  }
}




class Status{
  float maxHealth,recovery;
}

class Chara{
  Status status = new Status();
  float x = float(width)/2;
  float y = float(height)/2;
  Circle collider = new Circle(x,y,10);
  void display(){
    fill(0,255,0);
    collider.display();
  }
  void update(){
  }
}

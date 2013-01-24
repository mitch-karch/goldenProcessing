import java.awt.event.*;
//Mitchell Karchemsky

float goldenRatio = (sqrt(5)+1)/2;
float goldenAngle = (goldenRatio-1)*2*PI;
float offSet      = .9;      
int currGen       = 0;
float lastX       = width/2;
float lastY       = width/2;
int i             = 0;  //Yes this is bad practice
//Colors
int R = (int)(goldenRatio+(i*goldenRatio)%255);
int G = (int)(goldenRatio+(i)%255);
int B = (int)(goldenRatio+(i*goldenRatio)%255);
//UI
int counter       = 0;
int mouseDelta    = 1;
void setup(){
  size(512, 512);
  smooth();
  noStroke();
  frameRate(30);
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }}); 
}

void draw(){
  
  background(goldenRatio);
  
  float generation = currGen+1;
  float rad    = width/2 - 64;             //What does rad do? Magic Number 1 --> 64
  float asmall = (goldenRatio*rad*rad)/generation;   //What does asmall do?

  float cumulativeArea = 0;              //What does cumulativeArea do?
  i=0;
  for(; i<generation;i++){

    float angle = i*goldenAngle;
    //fill(100+(i*5)%100);              //Colorss
    changeColor();
    fill(R,G,B);
    println("("+R+","+G+","+B+")");
    /**/
    float itterativeRatio  = i/(generation-1);
    float nodeOffset       = asmall*offSet*2*itterativeRatio - asmall*offSet;
    float nodeArea         = asmall + nodeOffset;
    float nodeRadius       = sqrt(nodeArea/PI);
    float cumulativeRadius = sqrt(cumulativeArea/PI);
    
    nodeRadius *= min(1,(generation-i)/5.0);
    
    float xLocation = width/2 + sin(angle)*(cumulativeRadius+nodeRadius);
    float yLocation = width/2 + cos(angle)*(cumulativeRadius+nodeRadius);
    
    ellipse(xLocation-nodeRadius, yLocation-nodeRadius, nodeRadius*2, nodeRadius*2);
    if(i%mouseDelta==0){
      println("line at"+lastX+" "+lastY+" through "+ xLocation +" "+yLocation);
      stroke(255,255,255);
      strokeWeight(1);
      line(lastX,lastY,xLocation,yLocation);
      lastX = xLocation;
      lastY = yLocation;
      noStroke();  
    }/**/
    
    cumulativeArea += PI*nodeRadius*nodeRadius;
  }
  
  currGen++;

}

void mousePressed(){
  counter++;
  changeColor();
}

void changeColor(){
  int colorSchemes = 4;
  //Color Scheme changer
  counter%=colorSchemes;
  switch (counter){
    case 0:
      //Aubrey's Joker
      R = (int)(goldenRatio+(i*goldenRatio)%256);
      G = (int)(goldenRatio+(i)%256);
      B = (int)(goldenRatio+(i*goldenRatio)%256);
    break;

    case 1 :
      //Reds and Blues
      R = (int)(i%256);
      G = (int)(goldenRatio);
      B = (int)(goldenRatio+(i*goldenRatio)%256);
    break;

    case 2:
    //purple rose
      R = (int)(i*goldenRatio%256);
      G = (int)(goldenRatio/i%255);
      B = (int)(goldenRatio+(i*goldenRatio)%256);
    break;

    case 3:
    //
      R = (int)((i+goldenRatio)%256);
      G = (int)((goldenRatio/i)%255);
      B = (int)(goldenRatio+(i*goldenRatio)%256);
    break;
  }
}
void mouseWheel(int delta){
  if(delta==0){
    delta = 1;
  }
  mouseDelta = Math.abs(delta); 
}

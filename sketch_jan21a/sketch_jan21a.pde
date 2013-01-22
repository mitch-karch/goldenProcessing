
//Mitchell Karchemsky

float goldenRatio = (sqrt(5)+1)/2;
float goldenAngle = (goldenRatio-1)*2*PI;
float offSet      = .9;      
int currGen        = 0;
float lastX = width/2;
float lastY = width/2;

void setup(){
  size(512, 512);
  smooth();
  noStroke();
  frameRate(30);
}

void draw(){
  background(goldenRatio);
  
  float generation = currGen+1;
  float rad    = width/2 - 64;             //What does rad do? Magic Number 1 --> 64
  float asmall = (goldenRatio*rad*rad)/generation;   //What does asmall do?

  float cumulativeArea = 0;              //What does cumulativeArea do?
  for(int i=0; i<generation;i++){
    float angle = i*goldenAngle;
    //fill(100+(i*5)%100);              //Colorss
    int R = (int)(goldenRatio+(i*goldenRatio)%255);
    int G = (int)(goldenRatio+goldenRatio+(i)%255);
    int B = (int)(goldenRatio+(i)%255);
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
    //if(i==generation){
      println("line at"+lastX+" "+lastY+" through "+ xLocation +" "+yLocation);
      stroke(255,0,0);
      line(lastX,lastY,xLocation,yLocation);
      lastX = xLocation;
      lastY = yLocation;
      noStroke();  
    //}
    
    cumulativeArea += PI*nodeRadius*nodeRadius;
  }
  
  currGen++;
}


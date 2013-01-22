
//Mitchell Karchemsky

float goldenRatio = (sqrt(5)+1)/2;
float goldenAngle = (goldenRatio-1)*2*PI;
float offSet      = .9;			
int currGen    	  = 0;


void setup(){
	size(512, 512);
	smooth();
	noStroke();
	frameRate(10);
}

void draw(){
	background(244);
	
	float generation = currGen+1;
	float rad    = width/2 - 64; 				//What does rad do? Magic Number 1 --> 64
	float asmall = (goldenRatio*rad*rad)/generation; 	//What does asmall do?

	float cumulativeArea = 0;						//What does cumulativeArea do?
	for(int i=0; i<generation;i++){
		float angle = i*goldenAngle;
		fill(100+(i*5)%100);					//Colorss
		
		float itterativeRatio  = i/(generation-1);
		float nodeOffset       = asmall*offSet*2*itterativeRatio - asmall*offSet;
		float nodeArea         = asmall + nodeOffset;
		float nodeRadius       = sqrt(nodeArea/PI);
		float cumulativeRadius = sqrt(cumulativeArea/PI);
		
		nodeRadius *= min(1,(generation-i)/5.0);
		
		float xLocation = width/2 + sin(angle)*(cumulativeRadius+nodeRadius);
		float yLocation = width/2 + cos(angle)*(cumulativeRadius+nodeRadius);

		ellipse(xLocation-nodeRadius, yLocation-nodeRadius, nodeRadius*2, nodeRadius*2);
		cumulativeArea += PI*nodeRadius*nodeRadius;
	}
	println("generation: "+generation);
	currGen++;
}

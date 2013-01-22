
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
	ellipseMode(CENTER);
}

void draw(){
	background(244);
	
	float generation = currGen+1;
	float rad    = width/2 - 64; 				//What does rad do? Magic Number 1 --> 64
	float asmall = (PI*rad*rad)/generation; 	//What does asmall do?

	float cumulativeA = 0;						//What does cumulativeA do?
	for(int i=0; i<generation;i++){
		float angle = i*goldenAngle;
		fill(100+(i*5)%100);					//Colorss
		fill(value1, value2, value3, alpha);
		float itterativeRatio  = i/ (float) (generation-1);
		float nodeOffset       = asmall*offSet*2*itterativeRatio - asmall*offSet;
		float nodeArea         = asmall + nodeOffset;
		float nodeRadius       = sqrt(nodeArea/PI);
		float cumulativeRadius = sqrt(cumulativeA/PI);
		
		nodeRadius *= min(1,(generation-i)/5.0);
		
		float xLocation = width/2 + sin(angle)*(cumulativeRadius+nodeRadius);
		float yLocation = width/2 + cos(angle)*(cumulativeRadius+nodeRadius);

		ellipse(xLocation-nodeRadius, yLocation-nodeRadius, nodeRadius*2, nodeRadius*2);
		cumulativeRadius += PI*nodeRadius*nodeRadius;
	}
	println("generation: "+generation);
	currGen++;
}

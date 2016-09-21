//declare bacteria variables here
Grass [] startingGrass;
Predator [] allPredators;
int counter = 9;
int startingGrassLength = 1;
int predatorLength = 0;
void setup()
{     
	size(1000,600);
	startingGrass = new Grass[1000000];
	startingGrass[0] = new Grass(500,300);
	allPredators = new Predator[1000000];
}   
void draw()
{
	background(0);
	counter++;
	if (counter > 300)
	{
		counter = 0;
	}
	grassCreation();
	predatoryCreation();
}
void grassCreation()
{
	if (counter%150==0)
	{
		int grassNullMeter = 0;
		for (int i=0;i<startingGrassLength;i++)
		{
			if (startingGrass[i].useless == true)
			{
				grassNullMeter++;
			}
		}
		if (grassNullMeter == startingGrassLength)
		{
			startingGrass[0] = new Grass((int)(Math.random()*1001),(int)(Math.random()*601));
		}else
		{
			int looplength= startingGrassLength;
			for (int i=0;i<looplength;i++)
			{
				if ((Math.random()*10000)>startingGrassLength)
				{
					startingGrass[i].grow();
				}
			}
		}
	}
	if (startingGrassLength>0)
	{
		for (int i=0;i<startingGrassLength;i++)
		{
			if (startingGrass[i].useless == false)
			{
				startingGrass[i].show();
			}
		}
	}
}
void predatoryCreation()
{
	int predatorNullMeter=0;
	for(int i=0;i<predatorLength;i++)
	{
		allPredators[i].move();
		allPredators[i].show();
		if (allPredators[i].isDead == true)
		{
			predatorNullMeter++;
		}
	}
	if (predatorNullMeter == predatorLength)
	{
		int predatorNullPoint = 0-12;
		for (int i=0;i<predatorLength;i++)
		{
			if (allPredators[i].isDead == true)
			{
				predatorNullPoint = i;
			}
		}
		if (predatorNullPoint != 0-12)
		{
			allPredators[predatorNullPoint] = new Predator((int)(Math.random()*1001),(int)(Math.random()*601),1,255,0,0);
		}
	}
	if ((predatorLength==0)&&(startingGrassLength>=20))
	{
		allPredators[predatorLength] = new Predator((int)(Math.random()*1001),(int)(Math.random()*601),1,255,0,0);
		predatorLength++;
	}
}
class Grass
{
	int myX, myY,randVarHere;
	boolean useless;
	Grass(int startx, int starty)
	{
		randVarHere = ((int)((Math.random()*101)-50));
		if (startx+((int)((Math.random()*101)-50))<=0)
		{
			myX = 0;
		}else if (startx+((int)((Math.random()*101)-50))>=1000)
		{
			myX = 1000;
		}else
		{
			myX = startx + ((int)((Math.random()*101)-50));
		}
		if (starty+((int)((Math.random()*101)-50))<=0)
		{
			myY = 0;
		}else if (starty+((int)((Math.random()*101)-50))>=600)
		{
			myY = 600;
		}else
		{
			myY = starty + ((int)((Math.random()*101)-50));
		}
		useless = false;
	}
	void show()
	{
		stroke(0,255,0);
		fill(0,255,0);
		ellipse(myX,myY,2,2);
	}
	void grow()
	{
		if (useless == false)
		{
			int grassNullPoint = 0-12;
			for (int i=0;i<startingGrassLength;i++)
			{
				if (startingGrass[i].useless == true)
				{
					grassNullPoint = i;
				}
			}
			if (grassNullPoint != 0-12)
			{
				startingGrass[grassNullPoint] = new Grass(myX,myY);
			}else
			{
				startingGrassLength++;
				startingGrass[startingGrassLength-1] = new Grass(myX,myY);
			}
		}
	}
}
class Predator
{
	int myX, myY, mySize, myRed, myGreen, myBlue, eaten, needToEat, canWalk;
	boolean isDead;
	Predator(int startx, int starty,int inputSize, int inputR, int inputG, int inputB)
	{
		myX = startx;
		myY = starty;
		isDead = false;
		mySize = inputSize;
		myRed = inputR;
		myGreen = inputG;
		myBlue = inputB;
		eaten = 0;
		needToEat = (int)(sq(inputSize*10));
		canWalk = 100;
	}
	void show()
	{
		if (isDead == false)
		{
		stroke(myRed,myGreen,myBlue);
		fill(myRed,myGreen,myBlue);
		ellipse(myX, myY, mySize+2, mySize+2);
		}
	}
	void move()
	{
		if (isDead==false)
		{
			int closestDistance=1600;
			canWalk -= 1;
			int targetX =(int)(Math.random()*1001);
			int targetY =(int)(Math.random()*601);
			//distance finding
			if (mySize == 1);
			{
				for (int i=0;i<startingGrassLength;i++)
				{
					if (startingGrass[i].useless == false)
					{
						if (dist(startingGrass[i].myX,startingGrass[i].myY,myX,myY)<closestDistance)
						{
							closestDistance = (int)(dist(startingGrass[i].myX,startingGrass[i].myY,myX,myY));
							targetX = startingGrass[i].myX;
							targetY = startingGrass[i].myY;
						}
					}
					if ((myX==startingGrass[i].myX)&&(myY==startingGrass[i].myY))
					{
						startingGrass[i].useless=true;
						eaten++;
						if (canWalk <= 115)
						{
							canWalk += 3;
						}
					}
				}
			}
			//actual walking
			if (dist(myX,myY,targetX,targetY)>sq(mySize+2))
			{
				if (targetX==myX)
				{
					myX = myX + (int)((Math.random()*((sq(mySize+1))+(sq(mySize+1))))-(sq(mySize+1)));
				}
				if (targetY==myY)
				{
					myY = myY + (int)((Math.random()*((sq(mySize+1))+(sq(mySize+1))))-(sq(mySize+1)));
				}
				if (targetX>myX)
				{
					if (targetY>myY)
					{
						myX = myX + (int)(Math.random()*sq(mySize+1));
						myY = myY + (int)(Math.random()*sq(mySize+1));
					}
					if (targetY<myY)
					{
						myX = myX + (int)(Math.random()*sq(mySize+1));
						myY = myY - (int)(Math.random()*sq(mySize+1));
					}
				}
				if (targetX<myX)
				{
					if (targetY>myY)
					{
						myX = myX - (int)(Math.random()*sq(mySize+1));
						myY = myY + (int)(Math.random()*sq(mySize+1));
					}
					if (targetY<myY)
					{
						myX = myX - (int)(Math.random()*sq(mySize+1));
						myY = myY - (int)(Math.random()*sq(mySize+1));
					}
				}

			}else
			{
				myX = targetX;
				myY = targetY;
			}
			//spliting
			if (eaten >= needToEat)
			{
				int predatorNullPoint = 0-12;
				for (int i=0;i<predatorLength;i++)
				{
					if (allPredators[i].isDead == true)
					{
						predatorNullPoint = i;
					}
				}
				if (predatorNullPoint != 0-12)
				{
					allPredators[predatorNullPoint] = new Predator(myX,myY,mySize,myRed,myGreen,myBlue);
				}else
				{
					predatorLength++;
					allPredators[predatorLength-1] = new Predator(myX,myY,mySize,myRed,myGreen,myBlue);
				}
			}
			//dying
			if ((canWalk<=0)||(dist(myX,myY,targetX,targetY)>(mySize*100)))
			{
				isDead = true;
			}
		}
	}
} 
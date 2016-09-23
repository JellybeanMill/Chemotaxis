//declare bacteria variables here
Grass [] startingGrass;
Predator1 [] allPredator1;
int counter = 9;
int startingGrassLength = 1;
int predator1Length = 0;
void setup()
{     
	size(1000,600);
	startingGrass = new Grass[1000000];
	startingGrass[0] = new Grass(500,300);
	allPredator1 = new Predator1[1000000];
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
	predatory1Creation();
	destroyEverything();
}
void grassCreation()
{
	if (counter%50==0)
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
void predatory1Creation()
{
	int predatorNullMeter=0;
	int grassHereMeter = 0;
	for (int i=0;i<startingGrassLength;i++)
	{
		if (startingGrass[i].useless == false)
		{
			grassHereMeter++;
		}
	}
	for(int i=0;i<predator1Length;i++)
	{
		allPredator1[i].move();
		allPredator1[i].show();
		if (allPredator1[i].isDead == true)
		{
			predatorNullMeter++;
		}
	}
	if ((predatorNullMeter == predator1Length)&&(grassHereMeter>=20))
	{
		int predatorNullPoint = 0-12;
		for (int i=0;i<predator1Length;i++)
		{
			if (allPredator1[i].isDead == true)
			{
				predatorNullPoint = i;
			}
		}
		if (predatorNullPoint != 0-12)
		{
			allPredator1[predatorNullPoint] = new Predator1((int)((Math.random()*20)+(startingGrass[predatory1PreyFinding()].myX-10)),(int)((Math.random()*20)+(startingGrass[predatory1PreyFinding()].myY-10)),1,predatorNullPoint);
		}
	}
	
	if ((predator1Length==0)&&(grassHereMeter>=20))
	{
		allPredator1[predator1Length] = new Predator1((int)((Math.random()*20)+(startingGrass[predatory1PreyFinding()].myX-10)),(int)((Math.random()*20)+(startingGrass[predatory1PreyFinding()].myY-10)),1,predator1Length);
		predator1Length++;
	}
}
int predatory1PreyFinding()
{
	int [] aliveArray = new int[startingGrassLength];
	int aliveArrayLength = 0;
	for (int i=0;i<startingGrassLength;i++)
	{
		if (startingGrass[i].useless==false)
		{
			aliveArray[aliveArrayLength] = i;
			aliveArrayLength++;
		}
	}
	return aliveArray[(int)(aliveArrayLength*Math.random())];
}
void destroyEverything()
{
	if (mousePressed == true)
	{
		for (int i=0;i<startingGrassLength;i++)
		{
			startingGrass[i].useless=true;
		}
		for (int i=0;i<predator1Length;i++)
		{
			allPredator1[i].isDead=true;
		}
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
			if (Math.random()>0.2)
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
}
class Predator1
{
	int myX, myY, mySize, eaten, needToEat, canWalk, arrayNum;
	boolean isDead;
	Predator1(int startx, int starty,int inputSize, int inputarray)
	{
		myX = startx;
		myY = starty;
		isDead = false;
		mySize = inputSize;
		eaten = 0;
		needToEat = 10;
		canWalk = 100;
		arrayNum = inputarray;
	}
	void show()
	{
		if (isDead == false)
		{
			stroke(255,0,0);
			fill(255,0,0);
			ellipse(myX, myY, mySize+2, mySize+2);
		}
	}
	void move()
	{
		if (isDead==false)
		{
			int closestDistance=1600;
			canWalk -= 2;
			int targetX =(int)(Math.random()*1001);
			int targetY =(int)(Math.random()*601);
			//distance finding
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
					if (canWalk <= 100)
					{
						canWalk += 3;
					}
				}		
			}if (dist(myX,myY,targetX,targetY)>mySize*100)
			{
				for (int i=0;i<predator1Length;i++)
				{
					if (allPredator1[i].isDead==false)
					{
						if (dist(myX,myY,allPredator1[i].myX,allPredator1[i].myY)<dist(myX,myY,targetX,targetY))
						{
							targetX = allPredator1[i].myX;
							targetY = allPredator1[i].myY;
						}
					}
					if ((myX==allPredator1[i].myX)&&(myY==allPredator1[i].myY)&&(i!=arrayNum))
					{
						allPredator1[i].isDead=true;
						if (canWalk <= 100)
						{
							canWalk +=2;
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
				for (int i=0;i<predator1Length;i++)
				{
					if (allPredator1[i].isDead == true)
					{
						predatorNullPoint = i;
					}
				}
				if (predatorNullPoint != 0-12)
				{
					allPredator1[predatorNullPoint] = new Predator1(myX,myY,mySize,predatorNullPoint);
					eaten = 0;
				}else
				{
					predator1Length++;
					allPredator1[predator1Length-1] = new Predator1(myX,myY,mySize,predator1Length-1);
					eaten = 0;
				}
				eaten = 0;
			}
			//dying
			if (canWalk<=0)			
			{
				isDead = true;
			}
			if ((myX<0)||(myX>1000)||(myY<0)||(myY>600))
			{
				isDead = true;
			}
		}
	}
} 
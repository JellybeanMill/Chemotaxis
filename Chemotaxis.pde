//declare bacteria variables here
Grass [] startingGrass;
//Bacteria [] colony1;
int counter = 9;
int startingGrassLength = 1;
void setup()
{     
	size(1000,600);
	startingGrass = new Grass[100000];
	startingGrass[0] = new Grass(500,300);
//	colony1 = new Bacteria[1000];
}   
void draw()
{   
	background(0);
	counter++;
	if (counter > 300)
	{
		counter = 0;
	}
	if (counter == 300)
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
				if ((Math.random()*100000)>startingGrassLength)
					startingGrass[i].grow();
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

class Grass
{
	int myX, myY;
	boolean useless;
	Grass(int startx, int starty)
	{
		myX = startx + ((int)((Math.random()*101)-50));
		myY = starty + ((int)((Math.random()*101)-50));
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
/*
class Bacteria
{     

} 
*/   
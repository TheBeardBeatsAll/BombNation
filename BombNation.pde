void setup()
{
  fullScreen();
  initialise();
}//end setup

float border;
float block;
float block_num;

void draw()
{
  background(0);
  fill(255);
  translate(border, 0);
  rect(0, 0, height, height);
  
  for(int i = 0; i < 15 ; i++)
  {
    for(int j = 0; j < 15; j++)
    {
      if( i == 0 || i == 14 || j == 0 || j == 14 || ( i % 2 == 0 && j % 2 == 0))
      {
        fill(150);
        rect(0 + (i * block), 0 + (j * block), block, block);
      }//end if
    }//end for
  }//end for
}//end draw

void initialise()
{
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
}//end initialise
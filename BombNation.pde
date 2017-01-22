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
  rect(border, 0, height, height);
}//end draw

void initialise()
{
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
}//end initialise
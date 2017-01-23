void setup()
{
  fullScreen();
  initialise();
}//end setup

float border;
float block, block_num;
float x, y;
int x_coord, y_coord;

boolean[] keys = new boolean[1000];
boolean[][] level1 = new boolean[15][15];
Player player1 = new Player(x, y, block, block, 'w', 's', 'a', 'd');

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
  player1.render();
}//end draw

void initialise()
{
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  
  x = block;
  y = block;
  
  x_coord = 1;
  y_coord = 1;
  for(int i = 0; i < 15 ; i++)
  {
    for(int j = 0; j < 15; j++)
    {
      if( i == 0 || i == 14 || j == 0 || j == 14 || ( i % 2 == 0 && j % 2 == 0))
      {
        level1[i][j] = false;
      }//end if
      else
      {
        level1[i][j] = true;
      }//end else
    }//end for
  }//end for
}//end initialise

void keyPressed()
{ 
  keys[keyCode] = true;
}//end keyPressed
 
void keyReleased()
{
  keys[keyCode] = false; 
}//end keyReleased

boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];  
  }
  return false;
}//end checkKey
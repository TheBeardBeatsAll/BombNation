void setup()
{
  fullScreen();
  initialise();
}//end setup

float border;
float block, block_num;
float x, y;
int x_coord, y_coord;

boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();

void initialise()
{
   bricks.clear();
  
  t = loadTable("brickone.csv", "csv");
  for(TableRow row : t.rows())
  {
    Brick b = new Brick(row);
    bricks.add(b);
  }//end for
  
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
        level[i][j] = false;
      }//end if
      else
      {
        level[i][j] = true;
      }//end else
    }//end for
  }//end for
  for (int i = 0; i < bricks.size(); i++)
  {
    Brick b = bricks.get(i);
    level[b.x][b.y] = false;
  }//end for
  
  player = new Player(x, y, 'w', 's', 'a', 'd');
}//end initialise

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
  for (int i = 0; i < bricks.size(); i++)
  {
    Brick b = bricks.get(i);
    b.render();
  }//end for
  player.render();
}//end draw

void keyPressed()
{
  player.update(key);
}//end keyPressed
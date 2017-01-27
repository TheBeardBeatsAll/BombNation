void setup()
{
  fullScreen();
  initialise();
}//end setup

float border, bomb_timer;
float block, block_num;
int player_x, player_y, player_lives;
int bomb_count, max_bomb, bomb_power;

int brick_x, brick_y;

boolean check_b;
boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void initialise()
{
  bricks.clear();
  
  t = loadTable("brickone.csv", "csv");
  for(TableRow row : t.rows())
  {
    Brick b = new Brick(row);
    bricks.add(b);
  }//end for
  
  t = loadTable("enemyone.csv", "csv");
  for(TableRow row : t.rows())
  {
    Enemy e = new Enemy(row);
    enemies.add(e);
  }//end for
  
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  
  bomb_power = 2;
  bomb_count = 2;
  max_bomb = 5;
  
  brick_x = brick_y = 0;
  
  player_lives = 5;
  player_x = player_y = 1;
                  
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
 
  player = new Player('w', 's', 'a', 'd', 'c');
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
    
    if(b.x == brick_x && b.y == brick_y)
    {
      println("delete");
      level[b.x][b.y] = true;
      bricks.remove(i);
      brick_x = brick_y = 0;
    }//end if
  }//end for
  
  player.render(player_x, player_y);
  
  for (int i = 0; i < enemies.size(); i++)
  {
    Enemy e = enemies.get(i);
    e.render();
  }//end for
    
  for(int i = 0; i < bombs.size(); i++)
  {
    Bomb bm = bombs.get(i);
    if(bm.render())
    {
      bombs.remove(bm);
    }//end if
  }//for
}//end draw

void keyPressed()
{
  check_b = player.update(key);
  if(check_b == true && bomb_count > 0)
  {
    bomb_timer = millis();
    Bomb bm = new Bomb(player_x, player_y, bomb_timer);
    bombs.add(bm);
    bomb_count--;
    level[player_x][player_y] = false;
  }//end if
}//end keyPressed
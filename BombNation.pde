void setup()
{
  fullScreen();
  initialise();
}//end setup

float border, bomb_timer;
float[] enemy_timer = new float[10];
float block, block_num;

int player_x, player_y, player_lives;
int bomb_count, max_bomb, bomb_power;
int brick_x, brick_y, level_count;
int portal_x, portal_y, menu_choice, player_score;

boolean check_b, start_level, loader;
boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void initialise()
{
  level_count = 1;
  
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  
  bomb_power = 2;
  bomb_count = 2;
  max_bomb = 5;
  start_level = loader = true;
  brick_x = brick_y = 0;
  
  player_score = 0;
  menu_choice = 1;
  portal_x = 1;
  portal_y = 2;
  
  player_lives = 5;
  player_x = player_y = 1;
  player = new Player('w', 's', 'a', 'd', 'c');
}//end initialise

void draw()
{
  background(0);
  switch(menu_choice)
  {
    case 1:
    {
      fill(200);
      rect(border/2, border/4, width - border, height/2, 50);
      fill(0);
      rect((border * 11)/ 20, (border * 3)/8, width - (border * 11)/10, height/2 - border/4, 50);
      fill(200);
      textSize(140);
      textAlign(CENTER, CENTER);
      text("BombNation", width/2, height/4 + border/8);
      menu();
      break;
    }//end case
    case 2:
    {
      menu();
      break;
    }//end case
    case 3:
    {
      fill(200);
      rect(border, border/2, width - (border * 2), height/2 - border/3, 50);
      fill(0);
      rect((border * 21)/ 20, (border * 4)/6, width - (border * 21)/10, height/2 - (border * 2)/3, 50);
      fill(200);
      textSize(40);
      textAlign(CENTER, CENTER);
      text("Press Enter to exit", width/2, height/4 + border/4);
      menu();
      break;
    }//end case
    case 4:
    {
      switch(level_count)
      {
        case 0:
        {
          break;
        }//end case
        case 1:
        {
          level();
          break;
        }//end case
        case 2:
        {
          level();
          break;
        }//end case
        case 3:
        {
          level();
          break;
        }//end case
        case 4:
        {
          text("YOU WIN", height/2, height/2);
          break;
        }//end case
        case 5:
        {
          text("GAME OVER", height/2, height/2);
          break;
        }//end case
      }//end switch
      break;
    }//end case
  }//end switch
}//end draw

void menu()
{
  fill(200);
  triangle(width/2 - (block * 2), (height * 5)/8 + (menu_choice * block), 
  width/2 - (block * 2), (height * 5)/8 + (block * 1/3) + (menu_choice * block), 
  width/2 - (block * 1.5), (height * 5)/8 + (block/6) + (menu_choice * block));
  textSize(36);
  textAlign(LEFT, CENTER);
  text("Start Game", width/2 - block, (height * 5)/8 + block);
  text("Instructions", width/2 - block, (height * 5)/8 + (block * 2));
  text("Exit Game", width/2 - block, (height * 5)/8 + (block * 3));
}//end menu

void level()
{
  background(0);
  translate(border, 0);
  fill(255);
  rect(0, 0, height, height);
  if(loader)
  {
    level_load();
  }//end if
  drawLevel();
  drawPortal();
  player.render(player_x, player_y);
  checkPlayer();
}//end level

void checkPlayer()
{
  if(player_lives == 0)
  {
    level_count = 5;
  }//end if
  
  if(player_x == portal_x && player_y == portal_y)
  {
    level_count++;
    player_x = player_y = 1;
    loader = true;
  }//end if
}//end checkPlayer

void drawLevel()
{
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
  
  if(start_level)
  {
    for(int i = 0; i < 10; i++)
    {
      enemy_timer[i] = millis();
    }//end ofr
    start_level = false;
  }//end if
  
  for(int i = 0; i < bombs.size(); i++)
  {
    Bomb bm = bombs.get(i);
    if(bm.render())
    {
      bombs.remove(bm);
    }//end if
  }//for
  for (int i = 0; i < bricks.size(); i++)
  {
    Brick b = bricks.get(i);
    b.render();
    
    if(b.x == brick_x && b.y == brick_y)
    {
      level[b.x][b.y] = true;
      bricks.remove(i);
      brick_x = brick_y = 0;
    }//end if
  }//end for
  
  for (int i = 0; i < enemies.size(); i++)
  {
    Enemy e = enemies.get(i);
    e.render();
    if((millis() - enemy_timer[i]) >= 1000)
    {
      e.update();
      enemy_timer[i] = millis();
    }//end if
    if(player_x == e.x && player_y == e.y)
    {
      player_lives--;
      player_x = player_y = 1;
    }//end if
  }//end for
}//end drawLevel

void level_load()
{
  bricks.clear();
  enemies.clear();
  
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
  
  t = loadTable("brick" + level_count + ".csv", "csv");
  for(TableRow row : t.rows())
  {
    Brick b = new Brick(row);
    level[b.x][b.y] = false;
    bricks.add(b);
  }//end for
  
  t = loadTable("enemy" + level_count + ".csv", "csv");
  for(TableRow row : t.rows())
  {
    Enemy e = new Enemy(row);
    enemies.add(e);
  }//end for
  loader = false;
}//end level_load

void drawPortal()
{
  fill(255, 255, 0);
  rect(portal_x * block, portal_y * block, block, block);
}//end drawPortal

void keyPressed()
{
  if(key == ENTER)
  {
    if(menu_choice == 3)
    {
      exit();
    }//end if
    if(menu_choice == 1)
    {
      menu_choice = 4;
    }//end if
  }//end if
  if(menu_choice > 1 && menu_choice <= 3)
  {
    if(key == 'w')
    {
      menu_choice--;
    }//end if
  }//end if
  if(menu_choice >= 1 && menu_choice < 3)
  {
    if(key == 's')
    {
      menu_choice++;
    }//end if
  }//end if
  
  if(level_count >= 1 && level_count <= 3)
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
  }//end if
}//end keyPressed
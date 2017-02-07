void setup()
{
  fullScreen();
  initialise();
}//end setup

float border, level_timer, level_time_start;
float bomb_timer, cooldown;
float[] enemy_timer = new float[10];
float block, block_num, player_button;

int secs_left, player_time;
int player_x, player_y, player_lives;
int bomb_count, max_bomb, bomb_power;
int brick_x, brick_y, level_count, robot_choice;
int portal_x, portal_y, menu_choice, player_score;

boolean check_b, loader, button, destroy;
boolean[] explode = new boolean[5];
boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

void initialise()
{
  for(int i = 0; i < explode.length; i++)
  {
    explode[i] = false;  
  }//end for
  
  level_count = 0;
  level_timer = 240;
  
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  
  bomb_power = 2;
  bomb_count = 1;
  max_bomb = 5;
  loader = button = true;
  destroy = false;
  brick_x = brick_y = 0;
  
  player_time = 0;
  player_score = 0;
  menu_choice = 1;
  cooldown = -1;
  
  robot_choice = 0;
  player_lives = 5;
  player_x = player_y = 1;
}//end initialise

void draw()
{
  background(0);
  switch(menu_choice)
  {
    case 1:
    {
      textBox(0, 0);
      textSize(140);
      text("BombNation", width/2, height/4 + border/8);
      textSize(40);
      text("Press Enter to play", width/2, height/4 + border/2);
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
      textBox(border/2, border/3);
      textSize(40);
      text("Press Enter to exit", width/2, height/4 + border * 3/8);
      menu();
      break;
    }//end case
    case 4:
    {
      switch(level_count)
      {
        case 0:
        {
          textBox(0, -border/8);
          textSize(30);
          text("Choose a Robot Class:", width/2, height/7);
          player = new Kicker('w', 's', 'a', 'd', 'c', 'K', #0DBC20, 0, 1, 'e');
          player.render(player_x + 3, player_y + 3, 2);
          player = new Blocker('w', 's', 'a', 'd', 'c', 'B', #0064FF, 0, 1, 'e');
          player.render(player_x + 9.5, player_y + 3, 2);
          player = new Destroyer('w', 's', 'a', 'd', 'c', 'D', #D80726, 0, 1, 'e');
          player.render(player_x + 16, player_y + 3, 2);
          fill(200);
          textSize(24);
          textAlign(LEFT, CENTER);
          text("Kicker", border * 5/6, border * 7/12);
          text("Blocker", border * 23/12, border * 7/12);
          text("Destroyer", border * 3, border * 7/12);
          textSize(12);
          //text("", border * 5/6, border * 7/12);
          //text("", border * 23/12, border * 7/12);
          //text("", border * 3, border * 7/12);
          triangle((border * 5.1/6) + (robot_choice * border * 1.11), border * 1.35, 
          (border * 5.6/6) + (robot_choice * border * 1.11), border * 1.25, 
          (border * 6.1/6) + (robot_choice * border * 1.11), border * 1.35);
          break;
        }//end case
        case 1:
        {
          portal_x = 7;
          portal_y = 11;
          level();
          break;
        }//end case
        case 2:
        {
          portal_x = 13;
          portal_y = 4;
          level();
          break;
        }//end case
        case 3:
        {
          portal_x = 9;
          portal_y = 8;
          level();
          break;
        }//end case
        case 4:
        {
          int mins = player_time/60;
          int secs = (player_time % 60);
          textBox(border/8, 0);
          textSize(30);
          text("Congratulations you won\nYour Score is " + player_score
          + "\nYour time is " + mins + " mins " + secs + " secs" + "\nYou have " + player_lives + " lives remaining"
          + "\nPress any key to return to main menu", width/2, height/3);
          break;
        }//end case
        case 5:
        {
          textBox(border/8, 0);
          textSize(30);
          text("GAME OVER\nYour Score is " + player_score
          + "\nPress any key to return to main menu", width/2, height/3);
          //Game Over
          break;
        }//end case
      }//end switch
      break;
    }//end case
  }//end switch
}//end draw

void textBox(float o, float p)
{
  fill(200);
  rect(border/2 + o, border/4 + p, width - (border + (2 * o)), height/2 - p, 50);
  fill(0);
  rect((border * 11)/ 20 + o, (border * 3)/8 + p, width - ((border * 11)/10  + (2 * o)), height/2 - (border/4 + p), 50);
  fill(200);
  textAlign(CENTER, CENTER);
}//end textBox

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
  sideBars();
  fill(#59BCAE);
  rect(0, 0, height, height);
  if(loader)
  {
    level_load();
  }//end if
  drawLevel();
  checkPlayer();
}//end level

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
    if(e.type == 2)
    {
      e = new Tough(row);
    }//end if
    else if(e.type == 3)
    {
      e = new Smart(row);
    }//end else if
    enemies.add(e);
  }//end for
  for(int i = 0; i < enemy_timer.length; i++)
  {
    enemy_timer[i] = millis();
  }//end for
  
  bomb_timer = 0;
  
  level_time_start = millis();
  player_button = millis();
  
  loader = false;
}//end level_load

void sideBars()
{
  float check = (millis() - level_time_start) / 1000;
  secs_left = int(level_timer - check);
  int mins = secs_left/60;
  int secs = (secs_left % 60);
  fill(200);
  textSize(36);
  textAlign(LEFT, CENTER);
  text("Level " + level_count, - block * 4.5, block * 2);
  text("Time:", - block * 4.5, block * 4);
  text( mins + " mins\n" + secs + "secs", - block * 4.5, block * 5.5);
  text("Player Lives:", height + block, block * 2);
  text("Player Score:\n" + player_score, height + block, block * 5);
  text("Power Ready:\n", height + block, block * 7);
  String power = "";
  if( cooldown != -1)
  {
    power = "No";
  }//end else
  else
  {
    power = "Yes";
  }//end else
  text(power, height + block, block * 8);
  for(int i = 0; i < player_lives; i++)
  {
    player.render(15.3 + (i * 1.1), 2.75, 0);
  }//end for
  
  if(secs_left == 0)
  {
    level_count = 5;
  }//end if
}//end sideBars

void checkPlayer()
{
  player.render(player_x, player_y, 0);
  if(player_lives == 0)
  {
    level_count = 5;
  }//end if
  
  if(player_x == portal_x && player_y == portal_y)
  {
    level_count++;
    player_score += 1000;
    player_time += level_timer - secs_left;
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
        stroke(0);
        fill(150);
        rect(0 + (i * block), 0 + (j * block), block, block);
        fill(255);
        rect(0 + (i * block) + (block/6), 0 + (j * block) + (block/6), block - (block/3), block - (block/3));
        fill(50);
        rect(0 + (i * block) + (block/3), 0 + (j * block) + (block/3), block - (block * 2/3), block - (block * 2/3));
      }//end if
      else
      {
        fill(#278945);
        stroke(#278945);
        rect(0 + (i * block) + (block * 7/16), 0 + (j * block)  + (block * 7/16), block/8, block/8);
        rect(0 + (i * block) + (block * 7/16), 0 + (j * block)  + (block/8), block/8, block * 3/16);
        rect(0 + (i * block) + (block * 7/16), 0 + (j * block)  + (block * 11/16), block/8, block * 3/16);
        rect(0 + (i * block) + (block/8), 0 + (j * block)  + (block * 7/16), block * 3/16, block/8);
        rect(0 + (i * block) + (block * 11/16), 0 + (j * block)  + (block * 7/16), block * 3/16, block/8);
      }//end else
    }//end for
  }//end for
  
  for(int i = bombs.size() - 1; i >= 0; i--)
  {
    Bomb bm = bombs.get(i);
    if(bm.render(i))
    {
      bombs.remove(bm);
    }//end if
    if(explode[i])
    {
      explosion(-1, 0, bm.x, bm.y);
      explosion(0, -1, bm.x, bm.y);
      explosion(1, 0, bm.x, bm.y);
      explosion(0, 1, bm.x, bm.y);
    }//end if
  }//for
  for (int i = bricks.size() - 1; i >= 0; i--)
  {
    Brick b = bricks.get(i);
    b.render();
    
    if(b.x == brick_x && b.y == brick_y)
    {
      if(destroy)
      {
        b.destroy();
      }//end if
      else
      {
        level[b.x][b.y] = true;
        bricks.remove(i);
        brick_x = brick_y = 0;
      }//end if
    }//end if
  }//end for
  
  for (int i = enemies.size() - 1; i >= 0; i--)
  {
    Enemy e = enemies.get(i);
    pushMatrix();
    translate(e.x * block, e.y * block);
    e.render();
    popMatrix();
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
  
  if(millis() - player_button > 250)
  {
    button = true;
    player_button = millis();
  }//end if
  
  if(cooldown != -1)
  {
    if((millis() - cooldown) / 1000 >= 10)
    {
      cooldown = -1;
    }//end if
  }//end if
  
  drawPortal();
}//end drawLevel


void explosion(int l, int k, int x, int y)
{
  int n, j;
  fill(#BF4C04);
  rect(x * block, y * block, block, block);
  ellipseMode(CENTER);
  fill(#E0B400);
  arc(x * block, y * block, block/2, block/2, 0, HALF_PI);
  arc((x + 1) * block, y * block, block/2, block/2, HALF_PI, PI);
  arc(x * block, (y + 1) * block, block/2, block/2, PI + HALF_PI, TWO_PI);
  arc((x + 1) * block, (y + 1) * block, block/2, block/2, PI, PI + HALF_PI);
  
  fill(#59BCAE);
  arc(x * block, y * block, block/4, block/4, 0, HALF_PI);
  arc((x + 1) * block, y * block, block/4, block/4, HALF_PI, PI);
  arc(x * block, (y + 1) * block, block/4, block/4, PI + HALF_PI, TWO_PI);
  arc((x + 1) * block, (y + 1) * block, block/4, block/4, PI, PI + HALF_PI);
  for(int i = 1; i < bomb_power; i++)
  {
    if(!level[x + (l * i)][y + (k * i)])
    {
      brick_x = x + (l * i);
      brick_y = y + (k * i);
      return;
    }//end if
    if(l == 1 || l == -1)
    {
      n = 0;
      j = 1;
    }//end if
    else
    {
      n = 1;
      j = 0;
    }//end else
    pushMatrix();
    translate((x + (l * i)) * block, (y + (k * i)) * block);
    if(i  == bomb_power - 1)
    {
      pushMatrix();
      translate(block/2, block/2);
      float theta = 0;
      if(l == -1 || k == -1)
      {
        theta = PI;
      }//end if
      rotate(theta);
      fill(#E0B400);
      triangle((-block * 3/8 * n) - (block/2 * j), (-block * 3/8 * j) - (block/2 * n), 
      (block * 3/8 * n)  - (block/2 * j), (block * 3/8 * j) - (block/2 * n), (block * 3/8 * j), (block * 3/8 * n));
      fill(#BF4C04);
      triangle((-block * 1/4 * n) - (block/2 * j), (-block * 1/4 * j) - (block/2 * n), 
      (block * 1/4 * n)  - (block/2 * j), (block * 1/4 * j) - (block/2 * n), (block * 1/8 * j), (block * 1/8 * n));
      popMatrix();
    }//end if
    else
    {
      fill(#E0B400);
      rect((block/8) * n,(block/8) * j, block - (block * 1/4 * n), block - (block * 1/4 * j));
      fill(#BF4C04);
      rect((block/4) * n,(block/4) * j, block - (block * 1/2 * n), block - (block * 1/2 * j));
    }//end else
    popMatrix();
    if((player_x == (x + (l * i)) && player_y == (y + (k * i))) ||
    (player_x == x && player_y == y))
    {
      player_x = player_y = 1;
      player_lives--;
    }//end if
    for (int m = enemies.size() - 1; m >= 0; m--)
    {
      Enemy e = enemies.get(m);
      if((e.x == (x + (l * i)) && e.y == (y + (k * i))) ||
      (e.x == x && e.y == y))
      {
        e.lives--;
        if(e.lives <= 0)
        {
          player_score += e.score;
          enemies.remove(m);
        }//end if
      }//end if
    }//end for
  }//end for
}//end explosion

void drawPortal()
{
  fill(0);
  rect(portal_x * block, portal_y * block, block, block);
  fill(#091DE8);
  rect(portal_x * block + block/6, portal_y * block + block/6, block - block/3, block - block/3);
}//end drawPortal

void keyPressed()
{
  if(menu_choice >= 1 && menu_choice <= 3)
  {
    if(key == 'w' && menu_choice > 1)
    {
      menu_choice--;
    }//end if
    else if(key == 's' && menu_choice < 3)
    {
      menu_choice++;
    }//end else if
    else if(key == ENTER && menu_choice == 3)
    {
      exit();
    }//end else if
    else if(key == ENTER && menu_choice == 1)
    {
      menu_choice = 4;
    }//end else if
  }//end if
  else if(menu_choice == 4)
  {
    if(level_count == 0)
    {
      if(key == 'a' && robot_choice > 0)
      {
        robot_choice--;
      }//end if
      else if(key == 'd' && robot_choice < 2)
      {
        robot_choice++;
      }//end else if
      else if(key == ENTER)
      {
        switch(robot_choice)
        {
          case 0:
          {
            player = new Kicker('w', 's', 'a', 'd', 'c', 'K', #0DBC20, 0, 1, 'e');
            level_count++;
            break;
          }//end case
          case 1:
          {
            player = new Blocker('w', 's', 'a', 'd', 'c', 'B', #0064FF, 0, 1, 'e');
            level_count++;
            break;
          }//end case
          case 2:
          {
            player = new Destroyer('w', 's', 'a', 'd', 'c', 'D', #D80726, 0, 1, 'e');
            level_count++;
            break;
          }//end case
        }//end switch
      }//end else if
    }//end if
    else if(level_count >= 1 && level_count <= 3)
    {
      if(key == 'g')
      {
        menu_choice = 1;
        level_count = 0;
        player_x = player_y = 1;
        player_lives = 5;
      }//end if
      if(button)
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
        button = false;
      }//end if
    }//end else if
    else if( level_count == 4 || level_count == 5)
    {
      menu_choice = 1;
      level_count = 0;
      player_x = player_y = 1;
      player_lives = 5;
    }//end else if
  }//end else if
}//end keyPressed
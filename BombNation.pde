void setup()
{
  //intialise as fullscreen and all starting variables
  fullScreen();
  level_count = 0;
  level_timer = 240;
  block_num = 15;
  border = (width - height)/2;
  block = height / block_num;
  menu_choice = 1;
  robot_choice = 0;
}//end setup

//declare all global variables used
float border, level_timer, level_time_start;
float bomb_timer, cooldown, player_death;
float[] enemy_timer = new float[10];
float[] enemy_death = new float[10];
float block, block_num, player_button;

int secs_left, player_time, robot_choice;
int player_x, player_y, player_lives, level_count;
int bomb_count, max_bomb, bomb_power;
int[][] brick_xy = new int[4][2];
int portal_x, portal_y, menu_choice, player_score;

boolean check_b, loader, button, destroy;
boolean[] explode = new boolean[5];
boolean[][] level = new boolean[15][15];

Table t;

Player player;
ArrayList<Brick> bricks = new ArrayList<Brick>();
ArrayList<Bomb> bombs = new ArrayList<Bomb>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Pbomb> powerups = new ArrayList<Pbomb>();

//initialise all variables at the start of each level
void initialise()
{
  for(int i = 0; i < explode.length; i++)
  {
    explode[i] = false;  
  }//end for
  for(int i = 0; i < 4; i++)
  {
    for(int j = 0; j < 2; j++)
    {
      brick_xy[i][j] = 0; 
    }//end for
  }//end for 
  for(int i = 0; i < enemy_timer.length; i++)
  {
    enemy_timer[i] = 0;
  }//end for 
  for(int i = 0; i < enemy_death.length; i++)
  {
    enemy_death[i] = -1;
  }//end for 
  bomb_power = 2;
  bomb_count = 1;
  max_bomb = 5;
  loader = button = true;
  destroy = false;
  player_time = 0;
  player_score = 0;
  cooldown = player_death = -1;
  player_lives = 5;
  player_x = player_y = 1;
}//end initialise

void draw()
{
  background(0);
  //menu visuals
  switch(menu_choice)
  {
    case 1:
    {
      //to play screen
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
      //instructions screen
      textBox(-border/4, -border/4);
      fill(#59BCAE);
      rect(width * 0.1, height * 0.215, width * 0.75, height * 0.3);
      fill(0);
      rect(width * 0.2, height * 0.23, width * 0.2, height * 0.27);
      fill(200);
      textSize(18);
      text("Move using w,a,s & d keys\nPlant a bomb: c\nUse robot ability: e\nExit to main menu: g", width * 0.2, height * 0.23, width * 0.2, height * 0.27);
      textSize(40);
      text("How To Play", width/2, height/8);
      textSize(24);
      text("Player Robots", width * 5/32, height * 3/16);
      text("Bombs", width * 7/16, height * 3/16);
      text("Blocks", width * 9/16, height * 3/16);
      text("Enemies", width * 11/16, height * 3/16);
      text("Power Ups", width * 13/16, height * 3/16);
      Player pl = new Kicker('w', 's', 'a', 'd', 'c', 'K', #0DBC20, 0, 1, 'e');
      pl.render(3, 3.5, 0);
      pl = new Blocker('w', 's', 'a', 'd', 'c', 'B', #0064FF, 0, 1, 'e');
      pl.render(3, 5, 0);
      pl = new Destroyer('w', 's', 'a', 'd', 'c', 'D', #D80726, 0, 1, 'e');
      pl.render(3, 6.5, 0);
      
      pushMatrix();
      translate(width * 0.41, height * 0.225);
      Bomb b = new Bomb(1, 1, 1);
      b.renderTick();
      translate(0, height * 0.1);
      b.renderTock();
      
      translate(width * 0.13, -height * 0.1);
      Brick br = new Brick(1, 1);
      br.render();
      translate(0, height * 0.1);
      drawWall();
      translate(0, height * 0.1);
      drawPortal();
      
      translate(width * 0.125, -height * 0.2);
      Enemy e = new Enemy(1, 1);
      e.render();
      translate(0, height * 0.1);
      e = new Smart(1, 1);
      e.render();
      translate(0, height * 0.1);
      e = new Tough(1, 1);
      e.render();
      
      translate(width * 0.12, 0);
      Pbomb p = new Pbomb(1, 1);
      p.render();
      translate(0, -height * 0.1);
      p = new Pboom(1, 1);
      p.render();
      translate(0, -height * 0.1);
      p = new Pscore(1, 1);
      p.render();
      popMatrix();
      menu();
      break;
    }//end case
    case 3:
    {
      //exit screen
      textBox(border/2, border/3);
      textSize(40);
      text("Press Enter to exit", width/2, height/4 + border * 3/8);
      menu();
      break;
    }//end case
    case 4:
    {
      //levels and victory/game over screens
      switch(level_count)
      {
        case 0:
        {
          //choose your robot screen
          initialise();
          textBox(0, -border/8);
          textSize(30);
          text("Choose a Robot Class:", width/2, height/7);
          player = new Kicker('w', 's', 'a', 'd', 'c', 'K', #0DBC20, 0, 1, 'e');
          player.render(4, 4, 2);
          player = new Blocker('w', 's', 'a', 'd', 'c', 'B', #0064FF, 0, 1, 'e');
          player.render(10.5, 4, 2);
          player = new Destroyer('w', 's', 'a', 'd', 'c', 'D', #D80726, 0, 1, 'e');
          player.render(17, 4, 2);
          fill(200);
          textSize(24);
          textAlign(LEFT, CENTER);
          text("Kicker", border * 5/6, border * 7/12);
          text("Blocker", border * 23/12, border * 7/12);
          text("Destroyer", border * 3, border * 7/12);
          textSize(20);
          text("Can kick a bomb away", border * 1.25, border * 0.75, border * 0.3, border * 0.3);
          text("Can create a block of bricks", border * 2.4, border * 0.75, border * 0.3, border * 0.4);
          text("Can destroy a block of bricks", border * 3.45, border * 0.75, border * 0.3, border * 0.4);
          triangle((border * 5.2/6) + (robot_choice * border * 1.11), border * 1.35, 
          (border * 5.7/6) + (robot_choice * border * 1.11), border * 1.25, 
          (border * 6.2/6) + (robot_choice * border * 1.11), border * 1.35);
          break;
        }//end case
        case 1:
        {
          //level 1 screen
          portal_x = 7;
          portal_y = 11;
          level();
          break;
        }//end case
        case 2:
        {
          //level 2 screen
          portal_x = 13;
          portal_y = 4;
          level();
          break;
        }//end case
        case 3:
        {
          //level 3 screen
          portal_x = 9;
          portal_y = 8;
          level();
          break;
        }//end case
        case 4:
        {
          //victory screen
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
          //game over screen
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
  //boxes used in main menu screens
  fill(200);
  rect(border/2 + o, border/4 + p, width - (border + (2 * o)), height/2 - p, 50);
  fill(0);
  rect((border * 11)/ 20 + o, (border * 3)/8 + p, width - ((border * 11)/10  + (2 * o)), height/2 - (border/4 + p), 50);
  fill(200);
  textAlign(CENTER, CENTER);
}//end textBox

void menu()
{
  //menu selection visuals
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
  //all parts for a level, level is loaded only at the start
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

//loads info for level only once at the start
void level_load()
{
  bricks.clear();
  enemies.clear();
  powerups.clear();
  
  //set grid coords to true or false
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
  
  //load in bricks, enemies and power ups and set brick coord to false
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
  
  t = loadTable("power" + level_count + ".csv", "csv");
  for(TableRow row : t.rows())
  {
    Pbomb p = new Pbomb(row);
    if(p.type == 2)
    {
      p = new Pboom(row);
    }//end if
    else if(p.type == 3)
    {
      p = new Pscore(row);
    }//end else if
    powerups.add(p);
  }//end for
  
  //start timers for enemies,player key and level timer
  for(int i = 0; i < enemy_timer.length; i++)
  {
    enemy_timer[i] = millis();
  }//end for
  
  bomb_timer = 0;
  
  level_time_start = millis();
  player_button = millis();
  
  loader = false;
}//end level_load

//draw side info for level: score, timer, lives, ability ready
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
  
  //if time runs out game over
  if(secs_left == 0)
  {
    level_count = 5;
  }//end if
}//end sideBars

//draw player and do checks
void checkPlayer()
{
  player.render(player_x, player_y, 0);
  //if no more lives game over
  if(player_lives == 0)
  {
    level_count = 5;
  }//end if
  
  //if player goes into portal go to next level
  if(player_x == portal_x && player_y == portal_y)
  {
    level_count++;
    player_score += 1000;
    player_time += level_timer - secs_left;
    player_x = player_y = 1;
    loader = true;
  }//end if
  
  //if player picks up powerups implement them
  for (int i = powerups.size() - 1; i >= 0; i--)
  {
    Pbomb p = powerups.get(i);
    if(player_x == p.x && player_y == p.y)
    {
      if(p.type == 1 && bomb_count < max_bomb)
      {
        bomb_count++;
      }//end if
      else if(p.type == 2)
      {
        bomb_power++;
      }//end else if
      else if(p.type == 3)
      {
        player_score += 1000;
      }//end else if
      powerups.remove(i);
    }//end if
  }//end for
  
  //if player dies they are invulnerable for 2 secs
  if(player_death != -1)
  {
    fill(#AD9E1C);
    rect((player_x + 0.1) * block, (player_y - 0.2) * block, block * 0.8, block * 0.1);
    if((millis() - player_death) / 1000 >= 2)
    {
      player_death = -1;
    }//end if
  }//end if
  //player can do actions every 0.25 secs
  if(millis() - player_button > 250)
  {
    button = true;
    player_button = millis();
  }//end if 
  //ability cooldown is 10 secs
  if(cooldown != -1)
  {
    if((millis() - cooldown) / 1000 >= 10)
    {
      cooldown = -1;
    }//end if
  }//end if
}//end checkPlayer

//draw the level
void drawLevel()
{
  drawBlocks();
  drawBombs();
  drawPortal();
  drawPowerups();
  drawBricks();
  drawEnemies();
}//end drawLevel

//draw the walls and floor patterns
void drawBlocks()
{
  for(int i = 0; i < 15 ; i++)
  {
    for(int j = 0; j < 15; j++)
    {
      pushMatrix();
      translate(i * block, j * block);
      if( i == 0 || i == 14 || j == 0 || j == 14 || ( i % 2 == 0 && j % 2 == 0))
      {
        drawWall();
      }//end if
      else
      {
        drawFloor();
      }//end else
      popMatrix();
    }//end for
  }//end for
}//end drawBlocks

//draw the bombs and then each explosions
void drawBombs()
{
  for(int i = bombs.size() - 1; i >= 0; i--)
  {
    Bomb bm = bombs.get(i);
    pushMatrix();
    translate(bm.x * block, bm.y * block);
    if(bm.render(i))
    {
      bombs.remove(bm);
    }//end if
    if(explode[i])
    {
      explosion(0, -1, bm.x, bm.y);
      explosion(0, 1, bm.x, bm.y);
      explosion(-1, 0, bm.x, bm.y);
      explosion(1, 0, bm.x, bm.y);
    }//end if
    popMatrix();
  }//for
}//end drawBombs

//draw the bricks and if they get blown up their destruction visual then remove them
void drawBricks()
{
  for (int i = bricks.size() - 1; i >= 0; i--)
  {
    Brick b = bricks.get(i);
    pushMatrix();
    translate(b.x * block, b.y * block);
    b.render();
    
    for(int j = 0; j < 4; j++)
    {
      if(b.x == brick_xy[j][0] && b.y == brick_xy[j][1])
      {
        if(destroy)
        {
          b.destroy();
        }//end if
        else
        {
          level[b.x][b.y] = true;
          bricks.remove(i);
          brick_xy[j][0] = brick_xy[j][1] = 0;
        }//end else
      }//end if
    }//end for
    popMatrix();
  }//end for
}//end void drawBricks

//draw enemies
void drawEnemies()
{
  for (int i = enemies.size() - 1; i >= 0; i--)
  {
    Enemy e = enemies.get(i);
    pushMatrix();
    translate(e.x * block, e.y * block);
    e.render();
    popMatrix();
    //update enemies ever 1 sec
    if((millis() - enemy_timer[i]) >= 1000)
    {
      e.update();
      enemy_timer[i] = millis();
    }//end if
    //if player runs into enemy player dies
    if(player_x == e.x && player_y == e.y)
    {
      playerDeath();
    }//end if
    //if enemy loses a life it is destroyed if lives = 0
    //or it is invulnerable for 2 secs
    if(enemy_death[i] != -1)
    {
      if(e.lives <= 0)
      {
        fill(#EEF702);
        ellipseMode(CENTER);
        ellipse((e.x * block) + block/2, (e.y * block) + block/2, block, block);
        fill(#F79A02);
        ellipse((e.x * block) + block/2, (e.y * block) + block/2, block/2, block/2);
        fill(#F79A02);
        ellipse((e.x * block) + block/2, (e.y * block) + block/2, block/4, block/4);
        player_score += e.score;
        enemies.remove(i);
      }//end if
      else if(e.type == 2)
      {
        fill(#AD9E1C);
        rect((e.x + 0.1) * block, (e.y - 0.2) * block, block * 0.8, block * 0.1);
      }//end else
      if((millis() - enemy_death[i]) / 1000 >= 2)
      {
        enemy_death[i] = -1;
      }//end if
    }//end if
  }//end for
}//end drawEnemies

//draw power ups
void drawPowerups()
{
  for (int i = powerups.size() - 1; i >= 0; i--)
  {
    Pbomb p = powerups.get(i);
    pushMatrix();
    translate(p.x * block, p.y * block);
    p.render();
    popMatrix();
  }//end for
}//end drawPowerups

//what happens when a player dies ie reset to spawn
//with 1 bomb and basic power
void playerDeath()
{
  if(player_death == -1)
  {
    player_lives--;
    bomb_power = 2;
    bomb_count = 1;
    player_x = player_y = 1;
    player_death = millis();
  }//end if
}//end playerDeath

//draw the wall sections
void drawWall()
{
  stroke(0);
  fill(150);
  rect(0, 0, block, block);
  fill(255);
  rect(block/6, block/6, block - (block/3), block - (block/3));
  fill(50);
  rect(block/3, block/3, block - (block * 2/3), block - (block * 2/3));
}//end drawWall

//draw the floor patterns
void drawFloor()
{
  fill(#278945);
  stroke(#278945);
  rect(block * 7/16, (block * 7/16), block/8, block/8);
  rect(block * 7/16, (block/8), block/8, block * 3/16);
  rect(block * 7/16, block * 11/16, block/8, block * 3/16);
  rect(block/8, block * 7/16, block * 3/16, block/8);
  rect(block * 11/16, block * 7/16, block * 3/16, block/8);
}//end drawFloor

//draw portal
void drawPortal()
{
  fill(0);
  rect(portal_x * block, portal_y * block, block, block);
  fill(#091DE8);
  rect(portal_x * block + block/6, portal_y * block + block/6, block - block/3, block - block/3);
}//end drawPortal

//draw explosions and check does it destroy anything
void explosion(int l, int k, int x, int y)
{
  //draw center part of explosion
  int n, j;
  fill(#BF4C04);
  rect(0, 0, block, block);
  ellipseMode(CENTER);
  fill(#E0B400);
  arc(0, 0, block/2, block/2, 0, HALF_PI);
  arc(block, 0, block/2, block/2, HALF_PI, PI);
  arc(0, block, block/2, block/2, PI + HALF_PI, TWO_PI);
  arc(block, block, block/2, block/2, PI, PI + HALF_PI);
  
  fill(#59BCAE);
  arc(0, 0, block/4, block/4, 0, HALF_PI);
  arc(block, 0, block/4, block/4, HALF_PI, PI);
  arc(0, block, block/4, block/4, PI + HALF_PI, TWO_PI);
  arc(block, block, block/4, block/4, PI, PI + HALF_PI);
  for(int i = 1; i < bomb_power; i++)
  {
    //pass on coords above,below,left and right if brick gets blown up
    if(!level[x + (l * i)][y + (k * i)])
    {
      if(l == 1)
      {
        brick_xy[0][0] = x + (l * i);
        brick_xy[0][1] = y + (k * i);
      }//end if
      else if(l == -1)
      {
        brick_xy[1][0] = x + (l * i);
        brick_xy[1][1] = y + (k * i);
      }//end else if
      else if(k == 1)
      {
        brick_xy[2][0] = x + (l * i);
        brick_xy[2][1] = y + (k * i);
      }//end else if
      else if(k == -1)
      {
        brick_xy[3][0] = x + (l * i);
        brick_xy[3][1] = y + (k * i);
      }//end else if
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
    translate((l * i) * block, (k * i) * block);
    //draw end part of explosion
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
      //draw middle bits of explosioon
      fill(#E0B400);
      rect((block/8) * n,(block/8) * j, block - (block * 1/4 * n), block - (block * 1/4 * j));
      fill(#BF4C04);
      rect((block/4) * n,(block/4) * j, block - (block * 1/2 * n), block - (block * 1/2 * j));
    }//end else
    popMatrix();
    //if player caught in explosion player dies
    if((player_x == (x + (l * i)) && player_y == (y + (k * i))) ||
    (player_x == x && player_y == y))
    {
      playerDeath();
    }//end if
    //if enemy caught in explosion enemy loses a life
    for (int m = enemies.size() - 1; m >= 0; m--)
    {
      Enemy e = enemies.get(m);
      if((e.x == (x + (l * i)) && e.y == (y + (k * i))) ||
      (e.x == x && e.y == y))
      {
        if(enemy_death[m] == -1)
        {
          e.lives--;
          enemy_death[m] = millis();
        }//end if
      }//end if
    }//end for
  }//end for
}//end explosion

//key bindings
void keyPressed()
{
  //menu movements
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
  //in game movements
  else if(menu_choice == 4)
  {
    //move between robots and select them
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
    //in level, if g go to main menu
    //o/w player key bindings
    else if(level_count >= 1 && level_count <= 3)
    {
      if(key == 'g')
      {
        reset();
      }//end if
      if(button)
      {
        //player keys
        check_b = player.update(key);
        //if bomb is placed
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
    //if on victory or game over screen hit any key to go to main menu
    else if( level_count == 4 || level_count == 5)
    {
      reset();
    }//end else if
  }//end else if
}//end keyPressed

//variable reset to initial set up
void reset()
{
  menu_choice = 1;
  level_count = 0;
  robot_choice = 0;
  player_x = player_y = 1;
  player_lives = 5;
}//end reset
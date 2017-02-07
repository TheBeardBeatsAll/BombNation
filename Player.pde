abstract class Player
{ 
  int xdir, ydir;
  char up, down, left, right, bomb, initial, power;
  color body;
  
  Player(char up, char down, char left, char right, char bomb, char initial, color body, int xdir, int ydir, char power)
  {
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    this.bomb = bomb;
    this.initial = initial;
    this.body = body;
    this.xdir = xdir;
    this.ydir = ydir;
    this.power = power;
  }//end constructor
 
  void render(float x, float y, float size)
  {
    fill(255);
    triangle((x + 0.15 * (1 + size)) * block, (y + 1 + size) * block, (x + 0.5 * (1 + size)) * block, y * block, (x + 0.85 * (1 + size)) * block, (y + 1 + size) * block);
    fill(body);
    triangle(x * block, y * block, (x + 1 + size) * block, y * block, (x + 0.5 * (1 + size)) * block, (y + 1 + size) * block);
    fill(0);
    quad((x + 0.25 * (1 + size)) * block, (y + 0.35 * (1 + size)) * block, 
    (x + 0.5 * (1 + size)) * block, (y + 0.55 * (1 + size)) * block, 
    (x + 0.75 * (1 + size)) * block, (y + 0.35 * (1 + size)) * block, 
    (x + 0.5 * (1 + size)) * block, (y + 0.45 * (1 + size)) * block);
    rect((x + 0.2 * (1 + size)) * block, (y + 0.075 * (1 + size)) * block, (0.59 + (0.6 * size)) * block, (0.14 + (0.2 * size)) * block);
    fill(255);
    rect((x + 0.25 * (1 + size)) * block, (y + 0.1 * (1 + size)) * block, (0.47 + (0.5 * size)) * block, (0.11 + (0.12 * size)) * block);
    fill(0);
    textSize(10 + (size * 10));
    textAlign(CENTER, CENTER);
    text(initial, (x + 0.5 * (1 + size)) * block, (y + 0.75 * (1 + size)) * block);
  }//end render

  abstract void ability();

  boolean update(char k)
  {
    if(k == up)
    {
      xdir = 0;
      ydir = -1;
      if(level[player_x][player_y - 1])
      {
        player_y -= 1;
      }//end if
    }//end if
    else if(k == left)
    {
      xdir = -1;
      ydir = 0;
      if(level[player_x - 1][player_y])
      {
        player_x -= 1;
      }//end if
    }//end if
    else if(k == down)
    {
      xdir = 0;
      ydir = 1;
      if(level[player_x][player_y + 1])
      {
        player_y += 1;
      }//end if
    }//end if
    else if(k == right)
    {
      xdir = 1;
      ydir = 0;
      if(level[player_x + 1][player_y])
      {
        player_x += 1;
      }//end if
    }//end if
    else if(k == power)
    {
      if(cooldown == -1)
      {
        ability();
        cooldown = millis();
      }//end if
    }//end if
    else if(k == bomb)
    {
      return true;
    }//end if
    return false;
  }//end update
}//end Player
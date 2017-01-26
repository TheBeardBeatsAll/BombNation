class Player
{
  float x, y;
  char up, down, left, right, bomb;
  
  Player(float x, float y, char up, char down, char left, char right, char bomb)
  {
    this.x = x;
    this.y = y;
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    this.bomb = bomb;
  }//end constructor
   
  void render()
  {
    fill(0, 255, 0);
    ellipseMode(CORNER);
    ellipse(x, y, block, block);
  }//end render
  
  boolean update(char k)
  {
    if(k == up)
    {
      if(level[player_x][player_y - 1])
      {
        y -= block;
        player_y -= 1;
      }//end if
    }//end if
    else if(k == left)
    {
      if(level[player_x - 1][player_y])
      {
        x -= block;
        player_x -= 1;
      }//end if
    }//end if
    else if(k == down)
    {
      if(level[player_x][player_y + 1])
      {
        y += block;
        player_y += 1;
      }//end if
    }//end if
    else if(k == right)
    {
      if(level[player_x + 1][player_y])
      {
        x += block;
        player_x += 1;
      }//end if
    }//end if
    else if(k == bomb)
    {
      return true;
    }//end if
    return false;
  }//end update
}//end Player
abstract class Player
{ 
  char up, down, left, right, bomb;
  
  Player(char up, char down, char left, char right, char bomb)
  {
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    this.bomb = bomb;
  }//end constructor
 
  abstract void render(float x, float y, float size);

  abstract void ability();

  boolean update(char k)
  {
    if(k == up)
    {
      if(level[player_x][player_y - 1])
      {
        player_y -= 1;
      }//end if
    }//end if
    else if(k == left)
    {
      if(level[player_x - 1][player_y])
      {
        player_x -= 1;
      }//end if
    }//end if
    else if(k == down)
    {
      if(level[player_x][player_y + 1])
      {
        player_y += 1;
      }//end if
    }//end if
    else if(k == right)
    {
      if(level[player_x + 1][player_y])
      {
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
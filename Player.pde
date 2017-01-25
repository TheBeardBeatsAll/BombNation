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
      if(level[x_coord][y_coord - 1])
      {
        y -= block;
        y_coord -= 1;
      }//end if
    }//end if
    else if(k == left)
    {
      if(level[x_coord - 1][y_coord])
      {
        x -= block;
        x_coord -= 1;
      }//end if
    }//end if
    else if(k == down)
    {
      if(level[x_coord][y_coord + 1])
      {
        y += block;
        y_coord += 1;
      }//end if
    }//end if
    else if(k == right)
    {
      if(level[x_coord + 1][y_coord])
      {
        x += block;
        x_coord += 1;
      }//end if
    }//end if
    else if(k == bomb)
    {
      return true;
    }//end if
    return false;
  }//end update
}//end Player
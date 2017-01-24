class Player
{
  float x, y;
  char up, down, left, right;
  
  Player(float x, float y, char up, char down, char left, char right)
  {
    this.x = x;
    this.y = y;
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }//end constructor
   
  void render()
  {
    fill(0, 255, 0);
    ellipseMode(CORNER);
    ellipse(x, y, block, block);
  }//end render
  
  void update(char k)
  {
    if(k == up)
    {
      if(level1[x_coord][y_coord - 1])
      {
        y -= block;
        y_coord -= 1;
      }//end if
    }//end if
    else if(k == left)
    {
      if(level1[x_coord - 1][y_coord])
      {
        x -= block;
        x_coord -= 1;
      }//end if
    }//end if
    else if(k == down)
    {
      if(level1[x_coord][y_coord + 1])
      {
        y += block;
        y_coord += 1;
      }//end if
    }//end if
    else if(k == right)
    {
      if(level1[x_coord + 1][y_coord])
      {
        x += block;
        x_coord += 1;
      }//end if
    }//end if
  }//end update
}//end Player
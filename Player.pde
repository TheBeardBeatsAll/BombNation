class Player
{
  float x, y;
  float size_w, size_h;
  char up, down, left, right;
  
  Player(float x, float y, float size_w, float size_h, char up, char down, char left, char right)
  {
    this.x = x;
    this.y = y;
    this.size_w = size_w;
    this.size_h = size_h;
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }//end constructor
   
  void render()
  {
    if(key == 'w')
    {
      if(level1[x_coord][y_coord - 1])
      {
        y -= block;
        y_coord -= 1;
      }//end if
    }//end if
    if(key == 'a')
    {
      if(level1[x_coord - 1][y_coord])
      {
        x -= block;
        x_coord -= 1;
      }//end if
    }//end if
    if(key == 's')
    {
      if(level1[x_coord][y_coord + 1])
      {
        y += block;
        y_coord += 1;
      }//end if
    }//end if
    if(key == 'd')
    {
      if(level1[x_coord + 1][y_coord])
      {
        x += block;
        x_coord += 1;
      }//end if
    }//end if
    fill(0, 255, 0);
    ellipseMode(CORNER);
    ellipse(X_pos, Y_pos, block, block);
  }//end render
}//end Player
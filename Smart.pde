class Smart extends Enemy
{
  Smart(TableRow row)
  {
    super(row);
  }//end constructor
  
  Smart(int x, int y)
  {
    super(x, y);
  }
  
  void render()
  {
    fill(#DDFF08);
    ellipseMode(CORNER);
    ellipse(0, 0, block, block);
    fill(0);
    line((block * 1/4), (block * 1/4), (block * 1/2), (block * 1/2));
    line((block * 1/4), (block * 1/2), (block * 1/2), (block * 1/4));
    line((block * 1/2), (block * 1/4), (block * 3/4), (block * 1/2));
    line((block * 1/2), (block * 1/2), (block * 3/4), (block * 1/4));
    line((block * 1/4), (block * 5/8), (block * 3/4), (block * 5/8));
    ellipseMode(CENTER);
    ellipse((block * 3/8), (block * 3/8), block/8, block/8);
    ellipse((block * 5/8), (block * 3/8), block/8, block/8);
    fill(255);
    triangle((block * 5/12), (block * 5/8), (block * 1/2), (block * 5/8)
    , (block * 11/24), (block * 3/4));
    triangle((block * 7/12), (block * 5/8), (block * 2/3), (block * 5/8)
    , (block * 15/24), (block * 3/4));
  }//end render
  
  void update()
  {
    if(level[x + x_dir][y] == false && x_dir != 0)
    {
      if(level[x][y + 1] == false && level[x][y - 1] == false)
      {
        x_dir = -x_dir;
      }//end if
      else if(level[x][y - 1] == false && level[x][y + 1] == true)
      {
        y_dir = 1;
        x_dir = 0;
      }//end else if
      else if(level[x][y + 1] == false && level[x][y - 1] == true)
      {
        x_dir = 0;
        y_dir = -1;
      }//end else if
      else if(level[x][y + 1] == true && level[x][y - 1] == true)
      {
        x_dir = 0;
        y_dir = -1;
      }//end if
    }//end if
    else if(level[x][y + y_dir] == false && y_dir != 0)
    {
      if(level[x - 1][y] == false && level[x + 1][y] == false)
      {
        y_dir = -y_dir;
      }//end if
      else if(level[x - 1][y] == false && level[x + 1][y] == true)
      {
        y_dir = 0;
        x_dir = 1;
      }//end if
      else if(level[x + 1][y] == false && level[x - 1][y] == true)
      {
        y_dir = 0;
        x_dir = -1;
      }//end if
      else if(level[x + 1][y] == true && level[x - 1][y] == true)
      {
        x_dir = 1;
        y_dir = 0;
      }//end if
    }//end else if
    x += x_dir;
    y += y_dir;
  }//end update
}//end Smart
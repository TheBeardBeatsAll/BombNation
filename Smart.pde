class Smart extends Enemy
{
  Smart(TableRow row)
  {
    super(row);
  }//end constructor
  
  void render()
  {
    fill(#DDFF08);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block, block);
    line((x * block) + (block * 1/4), (y * block) + (block * 5/8), (x * block) + (block * 3/4), (y * block) + (block * 5/8));
    fill(255);
    triangle((x * block) + (block * 5/12), (y * block) + (block * 5/8), (x * block) + (block * 1/2), (y * block) + (block * 5/8)
    , (x * block) + (block * 11/24), (y * block) + (block * 3/4));
    triangle((x * block) + (block * 7/12), (y * block) + (block * 5/8), (x * block) + (block * 2/3), (y * block) + (block * 5/8)
    , (x * block) + (block * 15/24), (y * block) + (block * 3/4));
  }//end render
  
  void update()
  {
    if(level[x + x_dir][y] == false && x_dir != 0)
    {
      if(level[x][y + 1] == false && level[x][y - 1] == false)
      {
        x_dir = -x_dir;
      }//end if
      else if(level[x][y - 1] == false)
      {
        y_dir = 1;
        x_dir = 0;
      }//end else if
      else if(level[x][y + 1] == false)
      {
        x_dir = 0;
        y_dir = -1;
      }//end else if
    }//end if
    else if(level[x][y + y_dir] == false && y_dir != 0)
    {
      if(level[x - 1][y] == false && level[x - 1][y] == false)
      {
        y_dir = -y_dir;
      }//end if
      else if(level[x - 1][y] == false)
      {
        y_dir = 0;
        x_dir = 1;
      }//end if
      else if(level[x + 1][y] == false)
      {
        y_dir = -1;
        x_dir = 0;
      }//end if
    }//end else if
    x += x_dir;
    y += y_dir;
  }//end update
}//end Smart
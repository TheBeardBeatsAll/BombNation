class Enemy
{
  int x, y, lives;
  int x_dir, y_dir, type, score;
  
  Enemy(TableRow row)
  {
    this.x = row.getInt(0);
    this.y = row.getInt(1);
    this.lives = row.getInt(2);
    this.x_dir = row.getInt(3);
    this.y_dir = row.getInt(4);
    this.type = row.getInt(5);
    this.score = row.getInt(6);
  }//end Brick
  
  Enemy(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  //visual for basic enemy
  void render()
  {
    fill(#115AB7);
    ellipseMode(CORNER);
    ellipse(0, 0, block, block);
    fill(#4411B7);
    ellipseMode(CENTER);
    ellipse(block/2, block/2, block/2, block/2);
    fill(255);
    ellipse(block/2, block/2, block/4, block/4);
  }//end render
  
  //movement update for basic enemy & tough enemy
  //will turn around if a block or bomb is in front of it
  void update()
  {
    if(level[x + x_dir][y] == false && x_dir != 0)
    {
      x_dir = -x_dir;
    }//end if
    if(level[x][y + y_dir] == false && y_dir != 0)
    {
      y_dir = -y_dir;
    }//end if
    x += x_dir;
    y += y_dir;
  }//end update
}//end Enemy
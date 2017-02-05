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
  
  void render()
  {
    fill(0, 255, 125);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block, block);
  }//end render
  
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
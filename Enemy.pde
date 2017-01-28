class Enemy
{
  int x, y, lives;
  int x_dir, y_dir;
  
  Enemy(TableRow row)
  {
    this.x = row.getInt(1);
    this.y = row.getInt(0);
    this.lives = row.getInt(2);
    this.x_dir = row.getInt(3);
    this.y_dir = row.getInt(4);
  }//end Brick
  
  void render()
  {
    if(lives > 0)
    {
      float time = millis() - level_timer;
      fill(0, 255, 125);
      ellipseMode(CORNER);
      ellipse(x * block, y * block, block, block);
    }//end if
  }//end render
}//end Enemy
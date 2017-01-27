class Enemy
{
  int x, y, lives;
  
  Enemy(TableRow row)
  {
    this.x = row.getInt(1);
    this.y = row.getInt(0);
    this.lives = row.getInt(2);
  }//end Brick
  
  void render()
  {
    if(lives > 0)
    {
      fill(0, 255, 125);
      ellipseMode(CORNER);
      ellipse(x * block, y * block, block, block);
    }//end if
  }//end render
}//end Enemy
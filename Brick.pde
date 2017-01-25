class Brick
{
  int x, y;
  
  Brick(TableRow row)
  {
    this.x = row.getInt(1);
    this.y = row.getInt(0);
  }//end Brick
  
  void render()
  {
    fill(0, 0, 255);
    rect(x * block, y * block, block, block);
  }//end render
  
  void destroy()
  {
    
  }//end destroy
}//end Brick
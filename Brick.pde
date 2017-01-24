class Brick
{
  float x, y;
  
  Brick(float x, float y)
  {
    this.x = x;
    this.y = y;
  }//end Brick
  
  void render()
  {
    fill(0, 0, 255);
    rect(x, y, block, block);
  }//end render
}//end Brick
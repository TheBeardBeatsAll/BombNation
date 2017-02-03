class Tough extends Enemy
{
  Tough(TableRow row)
  {
    super(row);
  }//end constructor
  
  void render()
  {
    if(lives > 0)
    {
      fill(0, 255, 255);
      ellipseMode(CORNER);
      ellipse(x * block, y * block, block, block);
    }//end if
  }//end render
}//end Tough
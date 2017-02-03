class Smart extends Enemy
{
  Smart(TableRow row)
  {
    super(row);
  }//end constructor
  
  void render()
  {
    if(lives > 0)
    {
      fill(125, 255, 0);
      ellipseMode(CORNER);
      ellipse(x * block, y * block, block, block);
    }//end if
  }//end render
}//end Tough
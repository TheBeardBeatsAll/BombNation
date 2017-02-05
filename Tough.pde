class Tough extends Enemy
{
  Tough(TableRow row)
  {
    super(row);
  }//end constructor
  
  void render()
  {
    fill(0, 255, 255);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block, block);
  }//end render
}//end Tough
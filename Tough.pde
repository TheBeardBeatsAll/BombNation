class Tough extends Enemy
{
  Tough(TableRow row)
  {
    super(row);
  }//end constructor
  
  void render()
  {
    fill(#903480);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block, block);
    fill(0);
    ellipseMode(CENTER);
    ellipse((x * block) + (block * 5/16), (y * block) + (block * 3/8), block/6, block/6);
    ellipse((x * block) + (block * 11/16), (y * block) + (block * 3/8), block/6, block/6);
    rect((x * block) + (block * 1/4), (y * block) + (block * 5/8), block/2, block/8);
  }//end render
}//end Tough
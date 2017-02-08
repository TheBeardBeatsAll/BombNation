class Tough extends Enemy
{
  Tough(TableRow row)
  {
    super(row);
  }//end constructor
  
  Tough(int x, int y)
  {
    super(x, y);
  }

  //visuals for tough enemy
  void render()
  {
    fill(#903480);
    ellipseMode(CORNER);
    ellipse(0, 0, block, block);
    fill(0);
    ellipseMode(CENTER);
    ellipse((block * 5/16),(block * 3/8), block/6, block/6);
    ellipse((block * 11/16), (block * 3/8), block/6, block/6);
    rect((block * 1/4), (block * 5/8), block/2, block/8);
  }//end render
}//end Tough
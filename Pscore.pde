class Pscore extends Pbomb
{
  Pscore(TableRow row)
  {
    super(row);
  }//end Pscore
  
  Pscore(int x, int y)
  {
    super(x, y);
  }//end Brick
  
  //visual for score powerup
  void render()
  {
    fill(#5BF559);
    rect(0, 0, block, block);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("+1000\nScore", block/2, block/2);
  }//end render
}//end Pscore
class Pboom extends Pbomb
{
  Pboom(TableRow row)
  {
    super(row);
  }//end Pboom
  
  Pboom(int x, int y)
  {
    super(x, y);
  }//end Brick
  
  //visual for boom powerup
  void render()
  {
    fill(#5BF559);
    rect(0, 0, block, block);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("MORE\nBOOM", block/2, block/2);
  }//end render
}//end Pboom
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
  
  void render()
  {
    fill(#5BF559);
    rect(x * block, y * block, block, block);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("MORE\nBOOM",  x * block + block/2, y * block + block/2);
  }//end render
}//end Pboom
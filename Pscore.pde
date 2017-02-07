class Pscore extends Pbomb
{
  Pscore(TableRow row)
  {
    super(row);
  }//end Pscore
  
  void render()
  {
    fill(#5BF559);
    rect(x * block, y * block, block, block);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("+1000\nScore",  x * block + block/2, y * block + block/2);
  }//end render
}//end Pscore
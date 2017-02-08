class Brick
{
  int x, y;
  
  Brick(TableRow row)
  {
    this.x = row.getInt(0);
    this.y = row.getInt(1);
  }//end Brick
  
  Brick(int x, int y)
  {
    this.x = x;
    this.y = y;
  }//end Brick
  
  //visual for brick
  void render()
  {
    for(int i = 0; i < 5; i++)
    {
      if(i % 2 == 0)
      {
        fill(#6A0D0D);
        rect(0, (i * block/5), block, block/5);
        fill(#C66126);
        rect(block/3, (i * block/5), block/3, block/5);
      }//end if
      else
      {
        fill(#9B530B);
        rect(0, (i * block/5), block/2, block/5);
        fill(#AA2409);
        rect(block/2, (i * block/5), block/2, block/5);
      }//end else
    }//end for
  }//end render
  
  //visual for brick as its being destroyed
  void destroy()
  {
    fill(#E9FF00);
    rect(0, 0, block, block);
    stroke(0);
    fill(#FF8400);
    rect((block/6), (block/6), block - (block/3), block - (block/3));
    fill(#FF3300);
    rect((block/3), (block/3), block - (block * 2/3), block - (block * 2/3));
  }//end destroy
}//end Brick
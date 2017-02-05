class Brick
{
  int x, y;
  
  Brick(TableRow row)
  {
    this.x = row.getInt(0);
    this.y = row.getInt(1);
  }//end Brick
  
  void render()
  {
    for(int i = 0; i < 5; i++)
    {
      if(i % 2 == 0)
      {
        fill(#6A0D0D);
        rect(x * block, (y * block) + (i * block/5), block, block/5);
        fill(#C66126);
        rect((x * block) + block/3, (y * block) + (i * block/5), block/3, block/5);
      }//end if
      else
      {
        fill(#9B530B);
        rect(x * block, (y * block) + (i * block/5), block/2, block/5);
        fill(#AA2409);
        rect(x * block + block/2, (y * block) + (i * block/5), block/2, block/5);
      }//end else
    }//end for
  }//end render
  
  void destroy()
  {
    
  }//end destroy
}//end Brick
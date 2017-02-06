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
  
  boolean destroy(float t)
  {
    float time = ((millis() - t) / 1000);
    if(time <= 4)
    {
      fill(#E9FF00);
      rect(x * block, y * block, block, block);
      stroke(0);
      fill(#FF8400);
      rect(x * block + (block/6), y * block + (block/6), block - (block/3), block - (block/3));
      fill(#FF3300);
      rect(x * block + (block/3), y * block + (block/3), block - (block * 2/3), block - (block * 2/3));
      return false;
    }//end if
    else
    {
      return true;
    }//end 
  }//end destroy
}//end Brick
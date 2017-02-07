class Pbomb 
{
  int type, x, y;
  Pbomb(TableRow row)
  {
    this.x = row.getInt(0);
    this.y = row.getInt(1);
    this.type = row.getInt(2);
  }//end Brick
  
  Pbomb(int x, int y)
  {
    this.x = x;
    this.y = y;
  }//end Brick
  
  void render()
  {
    fill(#5BF559);
    rect(x * block, y * block, block, block);
    fill(0);
    textSize(12);
    textAlign(CENTER, CENTER);
    text("MORE\nBOMBS",  x * block + block/2, y * block + block/2);
  }//end render
}//end Pbomb
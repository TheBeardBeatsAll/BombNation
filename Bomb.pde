class Bomb
{
  int x, y;
  
  Bomb(int x, int y)
  {
    this.x = x;
    this.y = y;
  }//end Bomb
  
  void render()
  {
    fill(255, 0, 0);
    triangle(x * block, y * block,(x + 1) * block, y * block, (x + 0.5) * block, (y + 1) * block);
  }//end render
}//end Bomb
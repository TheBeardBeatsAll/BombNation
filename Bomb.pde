class Bomb
{
  int x, y;
  
  Bomb(int x, int y)
  {
    this.x = x;
    this.y = y;
  }//end Bomb
  
  boolean render()
  {
    float time = ((millis() - timer_b) / 1000); 
    if(time < 0.5 || (time >= 1 && time < 1.5) || (time >= 2 && time < 2.5))
    {
      fill(255, 0, 0);
      triangle(x * block, y * block,(x + 1) * block, y * block, (x + 0.5) * block, (y + 1) * block);
    }//end if
    else if((time >= 0.5 && time < 1) || (time >= 1.5 && time < 2) || (time >= 2.5 && time < 3))
    {
      fill(255, 0, 255);
      triangle(x * block, y * block,(x + 1) * block, y * block, (x + 0.5) * block, (y + 1) * block);
    }//end else if
    else
    {
      return true;
    }//end if
    return false;
  }//end render
}//end Bomb
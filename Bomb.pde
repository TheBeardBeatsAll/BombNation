class Bomb
{
  int x, y;
  float t;
  
  Bomb(int x, int y, float t)
  {
    this.x = x;
    this.y = y;
    this.t = t;
  }//end Bomb
  
  boolean render()
  {
    //bomb_data[k][2]
    float time = ((millis() - t) / 1000); 
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
      bomb_count++;
      level[x][y] = true;
      return true;
    }//end if
    return false;
  }//end render
}//end Bomb
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
  
  boolean render(int i)
  {
    float time = ((millis() - t) / 1000); 
    ellipseMode(CORNERS);
    if(time < 0.5 || (time >= 1 && time < 1.5) || (time >= 2 && time < 2.5))
    {
      fill(125);
      rect((x + 0.55) * block, (y + 0.1) * block, block * 0.2, block * 0.4);
      fill(0);
      ellipse((x + 0.25) * block, (y + 0.25) * block, (x + 1) * block, (y + 1) * block);
      fill(255);
      ellipse((x + 0.35) * block, (y + 0.65) * block, (x + 0.55) * block, (y + 0.85) * block);
    }//end if
    else if((time >= 0.5 && time < 1) || (time >= 1.5 && time < 2) || (time >= 2.5 && time < 3))
    {
      fill(125);
      rect((x + 0.45) * block, y * block, block * 0.2, block * 0.4);
      fill(#B71611);
      ellipse((x + 0.125) * block, (y + 0.125) * block, (x + 1) * block, (y + 1) * block);
      fill(255);
      ellipse((x + 0.225) * block, (y + 0.525) * block, (x + 0.55) * block, (y + 0.85) * block);
    }//end else if
    else if(time >= 3 && time < 4)
    {
      explode[i] = true;
      destroy = true;
    }//end if
    else
    {
      destroy = false;
      explode[i] = false;
      bomb_count++;
      return level[x][y] = true;
    }//end else
    return false;
  }//end render 
}//end Bomb
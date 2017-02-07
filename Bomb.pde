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
  
  void renderTick()
  {
    ellipseMode(CORNERS);
    fill(125);
    rect(0.55 * block, 0.1 * block, block * 0.2, block * 0.4);
    fill(0);
    ellipse(0.25 * block, 0.25 * block, block, block);
    fill(255);
    ellipse(0.35 * block, 0.65 * block, 0.55 * block, 0.85 * block);
  }//end renderStatic
  
  void renderTock()
  {
    ellipseMode(CORNERS);
    fill(125);
    rect(0.45 * block, 0, block * 0.2, block * 0.4);
    fill(#B71611);
    ellipse(0.125 * block, 0.125 * block, block, block);
    fill(255);
    ellipse(0.225 * block, 0.525 * block, 0.55 * block, 0.85 * block);
  }//end renderTock
 
  boolean render(int i)
  {
    float time = ((millis() - t) / 1000); 
    if(time < 0.5 || (time >= 1 && time < 1.5) || (time >= 2 && time < 2.5))
    {
      renderTick();
    }//end if
    else if((time >= 0.5 && time < 1) || (time >= 1.5 && time < 2) || (time >= 2.5 && time < 3))
    {
      renderTock();
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
class Kicker extends Player
{
  Kicker(char up, char down, char left, char right, char bomb, char initial, color body, int xdir, int ydir, char power)
  {
    super(up, down, left, right, bomb, initial, body, xdir, ydir, power);
  }//end constructor
  
  //will kick a bomb in direction player is facing until it hits a 
  //block or an enemy
  void ability()
  {
    if(!level[player_x + xdir][player_y + ydir])
    {
      for (int i = bombs.size() - 1; i >= 0; i--)
      {
        Bomb b = bombs.get(i);
        if(b.x == player_x + xdir && b.y == player_y + ydir)
        {
          while(level[b.x + xdir][b.y + ydir])
          {
            level[b.x][b.y] = true;
            level[b.x + xdir][b.y + ydir] = false;
            b.x += xdir;
            b.y += ydir;
            for (int m = enemies.size() - 1; m >= 0; m--)
            {
              Enemy e = enemies.get(m);
              if(e.x == b.x && e.y == b.y)
              {
                if(enemy_death[m] == -1)
                {
                  e.lives--;
                  enemy_death[m] = millis();
                }//end if
                return;
              }//end if
            }//end for
          }//end while
        }//end if
      }//end for
    }//end if
  }//end ability
}//end Player
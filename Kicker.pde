class Kicker extends Player
{
  Kicker(char up, char down, char left, char right, char bomb, char initial, color body, int xdir, int ydir, char power)
  {
    super(up, down, left, right, bomb, initial, body, xdir, ydir, power);
  }//end constructor
  
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
          }//end while
        }//end if
      }//end for
    }//end if
  }//end ability
}//end Player
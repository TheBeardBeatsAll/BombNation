class Destroyer extends Player
{
  Destroyer(char up, char down, char left, char right, char bomb, char initial, color body, int xdir, int ydir, char power)
  {
    super(up, down, left, right, bomb, initial, body, xdir, ydir, power);
  }//end constructor
  
  void ability()
  {
    if(!level[player_x + xdir][player_y + ydir])
    {
      for (int i = bricks.size() - 1; i >= 0; i--)
      {
        Brick b = bricks.get(i);
        if(b.x == player_x + xdir && b.y == player_y + ydir)
        {
          pushMatrix();
          translate(b.x * block, b.y * block);
          b.destroy();
          popMatrix();
          bricks.remove(b);
          level[b.x][b.y] = true;
        }//end if
      }//end for
    }//end if
  }//end ability
}//end Player
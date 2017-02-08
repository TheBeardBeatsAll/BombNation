class Blocker extends Player
{
  Blocker(char up, char down, char left, char right, char bomb, char initial, color body, int xdir, int ydir, char power)
  {
    super(up, down, left, right, bomb, initial, body, xdir, ydir, power);
  }//end constructor
   
  //creates a block of bricks beside the player in the direction it is facing
  void ability()
  {
    if(level[player_x + xdir][player_y + ydir])
    {
      Brick b = new Brick(player_x + xdir, player_y + ydir);
      bricks.add(b);
    }//end if
  }//end ability
}//end Player
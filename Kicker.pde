class Kicker extends Player
{
  Kicker(char up, char down, char left, char right, char bomb)
  {
    super(up, down, left, right, bomb);
  }//end constructor
   
  void render(int x, int y)
  {
    fill(0, 255, 0);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block, block);
  }//end render
  
  void ability()
  {
    
  }//end ability
}//end Player
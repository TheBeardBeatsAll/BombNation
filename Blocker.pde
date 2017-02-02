class Blocker extends Player
{
  Blocker(char up, char down, char left, char right, char bomb)
  {
    super(up, down, left, right, bomb);
  }//end constructor
   
  void render(float x, float y, float size)
  {
    fill(255, 255, 0);
    ellipseMode(CORNER);
    ellipse(x * block, y * block, block * size, block * size);
  }//end render
  
  void ability()
  {
    
  }//end ability
}//end Player
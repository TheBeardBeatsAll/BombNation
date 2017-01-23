class Player
{
  int lives;
  float X_pos = 0;
  float Y_pos = 0;
  
  void render(float x, float y)
  {
    X_pos = x;
    Y_pos = y;
    fill(0, 255, 0);
    ellipseMode(CORNER);
    ellipse(X_pos, Y_pos, block, block);
  }//end render
  
  //void update(float x, float y)
  //{
  //  X_coord += x;
  //  Y_coord += y;
  //  fill(0, 255, 0);
  //  ellipseMode(CORNER);
  //  ellipse(X_coord, Y_coord, block, block);
  //}//end update
}//end Player
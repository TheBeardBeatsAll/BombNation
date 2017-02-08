# Assignment 2 - BombNation

#Youtube Video
[![Video](https://i.gyazo.com/ae8549a81f33e6f995d9257714cfebc8.png)](https://www.youtube.com/watch?v=OW6_nz342Cc)

#Concept
After having no idea what game to make at the start I thought back to when I was 
a kid and what games I loved to make and remembered BomberMan and so decided
upon recreating that as best I can.

#Features
The game has a Main Menu with 
- Start Game page
-Instructions page
-Exit page
The game itself has three robot classes
-Kicker: can kick a bomb
-Blocker: can create a block of bricks
-Destroyer: can destroy a block of bricks
Three types of enemies, power ups and bombs with explosions.
There are three levels, victory screen and game over screen

#Controls
-In menu: w and s to navigate menu and enter to choose
-In class selection: a and d to navigate menu and enter to choose
-In game: w, a, s and d to move around, c to drop a bomb, e to exectue robot ability and g to exit to main menu
-In victory/game over screen: any key to exit to main menu

#Funcionality
Uses two switch statements to swap between main menu screens and in game screens
-pushMatrix and popMatrix are used extensively wherever there is a uniform shift in coordinates or rotations
-Classes for player robots, enemies, power ups, bricks and bombs and Arraylists for most of them
-A 15 * 15 boolean matrix for the grid layout of the levels with false indicating a wall, a brick or a bomb and therefore player or enemies cannot pass while true indicates they can
-boolean locks and millis() to time certain events, when they can or cannot happen
-Key bindings to navigate menus or levels or perfrom certain actions in the levels
-Loading of data from files for information on bricks, enemies and powerups


#Running of the Program
-Main menu
When the sketch is run the main menu comes up first where the user can look up instructions, exit the game and start the game
-Robot Selection
When the user starts the game they must choose between three different robot classes then proceed
-Levels
User moves around the levels, destroying bricks and destroying enemies for points, collecting powerups and trying to find the portal within 4 minutes to proceed to the next level until they have pass all three levels
-End Screen
Either a Victory screen for passing through the portal on Level 3 or a Game Over screen for losing all their lives, they then proceed back to the Main Menu

#Key Notes
-Program contains Inheritance and Polymorphism as some classes are variations on other and an Abstract Player Class which is built upon for the three Player Classes
-Sketch is mapped to all sizes
-2D Boolean Matrix is the basic for which all the game mechnics are built upon
-All visuals are proceedurally drawn


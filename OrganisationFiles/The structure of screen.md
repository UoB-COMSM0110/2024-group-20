#### The structure of screen:

##### Inside class:

- constructer: this is where you load image, add buttons.

- void display: use as draw() in the main.

- void mousePressed: use as mousePressed in the main.

-  void keyPressed(): similar as upon.

-  void mouseDragged(): similar as upon.

##### outside class:

ScreenManager.pde and screen.pde: provide a way to switch the screen.

#### How to add more Screens:

1. In ScreenType.pde, add the name of your screen.
2. In ScreenManager.pde, add code as before in setupScreen() function.
3. Create a new file of your screen and do whatever you like.

#### Note:

- If you what to create an object only in one screen,see what tutorial is called in game screen.
- If you what to create an object through different screens,see how screenmanager and userscore is called.
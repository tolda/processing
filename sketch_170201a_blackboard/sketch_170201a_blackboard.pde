/** blackboard with three spectacular features:
 ** - left button press --> draw
 ** - right button press --> reset to empty blackboard
 ** - mouse wheel --> change size of the pen
 **/

final int CIRCLE_SIZE_MIN = 10;
final int CIRCLE_SIZE_MAX = 500;
final int CIRCLE_SIZE_STEP = 10;
int circle_size_current = 80; 

void setup(){
height = 600;
width = 800;
size(800,600);
background(20,20,20);
}

void draw(){

// in order to draw circles continuously and not a single circle for every mouse click
// these commands must be put inside draw() and not in mousePressed()
if(mousePressed && (mouseButton == LEFT))
{
  // change drawing color depending on cursor position
  fill(mouseX*255/width);  
  
  ellipse(mouseX,mouseY,circle_size_current, circle_size_current);
}
else if (mousePressed && (mouseButton == RIGHT))
{
  background(20,20,20);
}

}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e>0 && circle_size_current > CIRCLE_SIZE_MIN)
  {
    // zoom out drawing pen
    circle_size_current = circle_size_current - CIRCLE_SIZE_STEP;
  }
  else if (e<0 && circle_size_current < CIRCLE_SIZE_MAX)
  {
    // zoom in drawing pen
    circle_size_current = circle_size_current + CIRCLE_SIZE_STEP;
  }
}
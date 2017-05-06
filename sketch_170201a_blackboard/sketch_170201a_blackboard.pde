/** blackboard with two spectacular features:
 ** - left button press --> draw
 ** - right button press --> reset to empty blackboard
 **/

final int CIRCLE_SIZE = 30;

void setup(){
height = 600;
width = 800;
size(800,600);
background(20,20,20);
}

void draw(){

if(mousePressed && (mouseButton == LEFT))
{
  // change drawing color depending on cursor position
  fill(mouseX*255/width);
  
  ellipse(mouseX,mouseY,CIRCLE_SIZE, CIRCLE_SIZE);
}
else if (mousePressed && (mouseButton == RIGHT))
{
  background(20,20,20);
}

}
// This project acquires the input audio signal from the soundcard and plots it.  //<>//
// The background color changes every time the chosen amplitude threshold is reached. 
// It is possible to listen to the soundcard stream by pressing the play/stop stream button 
// (be careful of the audio feedback effect while reproducing audio).
//
// 17/2/6 tolda

import processing.sound.*;

// audio globals
AudioIn sample;
Amplitude amp;

// graphic globals
final float AMPLITUDE_PLOT_GAIN = 1.2; // >1 to amplify graphical representation, optimal if <2
final float AUDIO_THRESHOLD = 0.2*AMPLITUDE_PLOT_GAIN;
float tmp_a;
int ii=0, a[];
int rect_x_start = 10, rect_y_start = 10;
boolean play = false;

void setup() {

  // environment setup
  size(640, 360);
  background(0);
  thresh_line();
  button();
  // sound file setup
  sample = new AudioIn(this, 0);
  sample.start();

  // amplitude setup
  a = new int[width];
  amp = new Amplitude(this);
  amp.input(sample);
  tmp_a = amp.analyze();
  a[ii] = round(-tmp_a*height+height);
  ii++;
}

void draw() {

  tmp_a = AMPLITUDE_PLOT_GAIN*amp.analyze();
  a[ii] = round(-tmp_a*height+height);
  if (tmp_a>AUDIO_THRESHOLD) {
    background(random(0, 255), random(0, 255), random(0, 255));
    redraw_line();
  }
  if (ii==width-1) {
    ii=0;
    background(0);
    thresh_line();
  } else {
       stroke(255,255,255);
    line(ii-1, a[ii-1], ii, a[ii]);
       stroke(255,255,255);
  }
  ii++;
}

void redraw_line() {
  for(int i=0;i<ii-1;i++){
    line(i,a[i],i+1, a[i+1]);
  }
  thresh_line();
}

void thresh_line(){
   stroke(255,0,0);
   line(0,-AUDIO_THRESHOLD*height+height,width,-AUDIO_THRESHOLD*height+height);
   stroke(0);
   button();
}

void button(){
  stroke(255,0,0);
  strokeWeight(4);
  fill(0);
  rect(rect_x_start,rect_y_start,width*0.1, width*0.1,7);
  stroke(0);
  strokeWeight(1);
}

void mousePressed() {
  if(mouseX>rect_x_start && mouseX<width*0.1 && mouseY>rect_y_start && mouseY<width*0.1){
    if(!play)
      sample.play();
    else{
      sample.stop();
      sample.start();
      amp.input(sample);
    }
    play = !play;
  }
}
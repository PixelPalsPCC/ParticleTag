//export PATH=".:$PATH:~"
/**
 * This sketch shows how to use the Waveform class to analyze a stream
 * of sound. Change the number of samples to extract and draw a longer/shorter
 * part of the waveform.
 */

import processing.sound.*;

// Declare the sound source and Waveform analyzer variables
SoundFile sample;
Waveform waveform;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;

//declare global variables
Bubble[] bubbles;
Bubble singleBubble;
int numBubbles = 20;//set the number of bubbles to make at 100
int counterBubbles;
boolean gameOver = false;
PImage realBubble;

void setup() {

    // Load and play a soundfile and loop it.
    sample = new SoundFile(this, "beat.aiff");
    sample.loop();


    // Create the Waveform analyzer and connect the playing soundfile to it.
    waveform = new Waveform(this, samples);
    waveform.input(sample);

    // frameRate(2);
    size(500, 500);
    bubbles = new Bubble[numBubbles];//instantiate the custom bubbles object that will hold all the bubbles
    realBubble = loadImage("image-from-rawpixel-id-12479974-png.png");
    for(int i = 0; i < numBubbles; i++) {
        bubbles[i] = new Bubble(250, 100);//create the bubbles and add them into the array
        bubbles[i].cc = color(random(0,255),random(0,255),random(0,255)); 
    }
    singleBubble = new Bubble(250, 100);//create one bubble
    singleBubble.cc = color(255,0,0);
    //create, move and display lots of bubbles colored white
}
void draw() {
    background(100);


    if(!gameOver){
        //move and display the one bubble
        //it will be colored red
        singleBubble.move();
        singleBubble.display("bubble");
        boolean result = singleBubble.capture();
        println(result);
        
        //move and display lots of bubbles colored white
        for(int i = 0; i < numBubbles; i++) {
            bubbles[i].move();
            bubbles[i].display("not circle");
        }
        if(counterBubbles==numBubbles){
            println("TRIGGER");
            gameOver = true;
        }
    } else {
        fill(255);
        textSize(128);
        text("You Won!",1,height/2);
        sample.stop();
    }

}
class Bubble  {
    public float x,y;
    float xOff,yOff;
    boolean tracking = false;
    color cc;

    Bubble(int x, int y) {
        xOff = random(0, 1000);
        yOff = random(0, 1000);
        cc = color(255,255,255);
    }

    void move() {
        xOff += 0.01;
        yOff += 0.01;
        x = noise(xOff) * width;
        y = noise(yOff) * height;
    }

    void draw(){
        move();
    }

    boolean capture(){
        boolean b = false;       
        
        // println(singleBubble.x,singleBubble.y);
        for (int i=0;i<numBubbles;i++){
            println(i + " " + bubbles[i].x + " " + bubbles[i].y);
            float collide = dist(bubbles[i].x, bubbles[i].y, singleBubble.x,singleBubble.y);
            println(collide);
            if(bubbles[i].tracking==false && collide<50){
                counterBubbles++;
                bubbles[i].tracking = true;
                b = true;
            }
        }
        return b;
    }



   void display(String polygon) {
        fill(cc);
        if(polygon=="circle"){
            circle(x, y, 50);
        } else if(polygon=="bubble") {
            image(realBubble,x,y,50,50);
        } else {
            if(tracking==true){
                square(singleBubble.x+50/2-15/2, singleBubble.y+50/2-15/2, 15);
            } else {   
                square(x, y, 15);
            }
        }
    }
}

/*
public void drawWaveForm() {
  //from the Processing Sound Library example
  //this code is not used but the setup function plays the sound
  
  // Set background color, noFill and stroke style
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();

  // Perform the analysis
  waveform.analyze();
  
  beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    vertex(
      map(i, 0, samples, 0, width),
      map(waveform.data[i], -1, 1, 0, height)
    );
  }
  endShape();
}
*/

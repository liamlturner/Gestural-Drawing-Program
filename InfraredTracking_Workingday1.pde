import gab.opencv.*;
import processing.video.*;
import java.awt.*;

//KINECT addtions
import org.openkinect.processing.*;
Kinect kinect;

//GITHUB TEST

//Capture video;
OpenCV opencv;

//int[] oldLoc = new int[2];

int oldX = 0;
int oldY = 0;

PGraphics doodoo;

void setup() {
  size(640, 480);
  // Capture opens up the image (/2) at half the size; tracking works faster
  // With the Kinect we might not be able to scale it by half
  // we can figure it out when working with it
  //don't need this line; just slot in the video import from Kinect
  
 // video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640, 480);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  // One concern from Matti is whether Kinect images get automatically converted to grayscale

  //KINECT ADDITIONS
  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.initVideo();
  kinect.enableIR(true);
  frameRate(10);

//  video.start();

//DRAWING
  doodoo = createGraphics(width,height, g.getClass().getName());
}

void draw() {
  //scale(2);
  
  // we should replace this line with the get Kinect video 
  //opencv.loadImage(kinect.getVideoImage()); perhaps
  opencv.loadImage(kinect.getVideoImage());

 // image(video, 0, 0 );
  
  image(opencv.getOutput(), 0, 0); 
  PVector loc = opencv.max();
  
  print("Current Location: ");
  print(int(loc.x));
  print(" , ");
  println(int(loc.y));
  
  //stroke(255, 0, 0);
  //strokeWeight(4);
  //noFill();
  //ellipse(loc.x, loc.y, 10, 10);
  
  doodoo.beginDraw();
  //doodoo.background(100);
  doodoo.stroke(0,255,0);
  doodoo.strokeWeight(4);
  doodoo.ellipse(loc.x, loc.y, 10, 10);
  doodoo.line(loc.x,loc.y,oldX,oldY);
  doodoo.endDraw();
  image(doodoo,0,0);
  print("Old location:     ");
  print(oldX);
  print(" , ");
  println(oldY);
  
  
  //SAVING OLD LOCATION
  //oldLoc[0] = int(loc.x);
  //oldLoc[1] = int(loc.y);
  
  oldX = int(loc.x);
  oldY = int(loc.y);
  

}

void captureEvent(Capture c) {
  c.read();
}
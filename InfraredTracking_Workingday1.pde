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
int irBright;

PGraphics artboard;

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
  frameRate(120);

  //  video.start();
 
  //DRAWING
  artboard = createGraphics(width, height, g.getClass().getName());
}

void draw() {
 
  opencv.loadImage(kinect.getVideoImage());
  opencv.threshold(70);
  filter(BLUR, 6);
  
  // image(video, 0, 0 );

  image(opencv.getOutput(), 0, 0); 
  PVector loc = opencv.max();
  
  
  //button
  fill(200);
  rect(40,height-80,100,40);
  

  
  

  print("Current Location: ");
  print(int(loc.x));
  print(" , ");
  println(int(loc.y));

  //stroke(255, 0, 0);
  //strokeWeight(4);
  //noFill();
  //ellipse(loc.x, loc.y, 10, 10);


//if (irBright > 100) {
  artboard.beginDraw();
    artboard.stroke(0, 255, 0);
    artboard.strokeWeight(2);
    //artboard.ellipse(loc.x, loc.y, 10, 10);
    artboard.line(loc.x, loc.y, oldX, oldY);
  artboard.endDraw(); 
//}
  image(artboard, 0, 0);


  print("Old location:     ");
  print(oldX);
  print(" , ");
  println(oldY);


  oldX = int(loc.x);
  oldY = int(loc.y);
}

void captureEvent(Capture c) {
  c.read();
}
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

//KINECT addtions
import org.openkinect.processing.*;
Kinect kinect;

//Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  // Capture opens up the image (/2) at half the size; tracking works faster
  // With the Kinect we might not be able to scale it by half
  // we can figure it out when working with it
  //don't need this line; just slot in the video import from Kinect
  
 // video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  // One concern from Matti is whether Kinect images get automatically converted to grayscale

  //KINECT ADDITIONS
  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.initVideo();
  kinect.enableIR(true);

//  video.start();
}

void draw() {
  scale(2);
  
  // we should replace this line with the get Kinect video 
  //opencv.loadImage(kinect.getVideoImage()); perhaps
  opencv.loadImage(kinect.getVideoImage());

 // image(video, 0, 0 );
  
  image(opencv.getOutput(), 0, 0); 
  PVector loc = opencv.max();
  
  stroke(255, 0, 0);
  strokeWeight(4);
  noFill();
  ellipse(loc.x, loc.y, 10, 10);

  /* noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  } */
}

void captureEvent(Capture c) {
  c.read();
}
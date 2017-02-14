import gab.opencv.*;
import processing.video.*;
import java.awt.*;
Capture cam;

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
  fullScreen(2);
  background(50);
  //size(1280, 960);
  
  String[] cameras = Capture.list();
  
  //video capture
  // The camera can be initialized directly using an element
  // from the array returned by list():
  cam = new Capture(this, cameras[0]);
  // Or, the settings can be defined based on the text in the list
  //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
  
  // Start capturing the images from the camera
  cam.start();
  
  
  opencv = new OpenCV(this, 640, 480);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  // One concern from Matti is whether Kinect images get automatically converted to grayscale

  //KINECT ADDITIONS
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableIR(true);
  kinect.enableMirror(true);

  //  video.start();
 
  //DRAWING
  artboard = createGraphics(width, height, g.getClass().getName());
}

void draw() {
  scale(2);
  opencv.loadImage(kinect.getVideoImage());
  opencv.brightness(22);
  //opencv.contrast(2);
  opencv.threshold(200);
  
  //old threshold 200 (for bright LED)

  //camera
  if (cam.available() == true) {
    cam.read();
  }


  image(opencv.getOutput(), 0, 0); 
  PVector loc = opencv.max();
  
  
  //button
  fill(200);
  rect(40,height-80,100,40);
  

  
  
/*
  print("Current Location: ");
  print(int(loc.x));
  print(" , ");
  println(int(loc.y));
*/

//if (irBright > 100) {
  artboard.beginDraw();
  
  if (loc.x != 0 && loc.y != 0) {
    //artboard.stroke(0, 255, 0);
    image(cam, loc.x, loc.y);
    artboard.strokeWeight(2);
    //artboard.ellipse(loc.x, loc.y, 10, 10);
    artboard.line(loc.x, loc.y, oldX, oldY);
  }
  artboard.endDraw(); 
//}
  image(artboard, 0, 0);

/*
  print("Old location:     ");
  print(oldX);
  print(" , ");
  println(oldY);
*/

  oldX = int(loc.x);
  oldY = int(loc.y);
}

void captureEvent(Capture c) {
  c.read();
}
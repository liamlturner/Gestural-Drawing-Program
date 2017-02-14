import gab.opencv.*;
import processing.video.*;
import java.awt.*;
Capture cam;

//KINECT addtions
import org.openkinect.processing.*;
Kinect kinect;


//Capture video;
OpenCV opencv;


int oldX = 0;
int oldY = 0;

PGraphics artboard;
PImage img;

void setup() {
  //size(1920, 1200);
  fullScreen(2);
  background(50);
 
  img = loadImage("spaceship copy.png");
  
  String[] cameras = Capture.list();
  printArray(cameras);
  //VIDEO CAPTURE
  // The camera can be initialized directly using an element
  // from the array returned by list():
  cam = new Capture(this, cameras[0]);
  // Or, the settings can be defined based on the text in the list
  //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
  
  // Start capturing the images from the camera
  cam.start();
  
  
  opencv = new OpenCV(this, 640, 480);


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
  //scale(0.5);
  opencv.loadImage(kinect.getVideoImage());
  //opencv.brightness(22);
  //opencv.contrast(2);
  opencv.threshold(250);
  
  //old threshold 200 (for bright LED)

  //camera
  if (cam.available() == true) {
    cam.read();
  }


  //image(opencv.getOutput(), 0, 0); 
  PVector loc = opencv.max();
  PVector locMapped = new PVector();
  locMapped.x = map(loc.x,91,550,0,width);
  locMapped.y = map(loc.y,20,308,0,height);
  //ellipse(locMapped.x,locMapped.y,10,10);
  //image(cam, locMapped.x, locMapped.y, 100, 45);
  //println("Coordinates: " + loc.x,loc.y);
  //Top left: 91,20
  //Top right: 550, 7
  //bottom right: 572, 293
  //bottom left: 86, 308
  
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
  
  if (locMapped.x != 0 && locMapped.y != 0) {
    //background(0);
    image(cam, locMapped.x, locMapped.y, 100, 45);
    //image(img, loc.x, loc.y, 100,100);    
    
 
    
    //artboard.stroke(0, 255, 0);
    //artboard.strokeWeight(2);
    //artboard.line(loc.x, loc.y, oldX, oldY);
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
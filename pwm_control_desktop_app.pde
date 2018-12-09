

import processing.serial.*;

Serial myPort;  // Create object from Serial class

String[] lines;

HScrollbar hs4, hs5;  // TWO scrollbars
boolean flag4, flag5, flagB = false;

int rectX, rectY;// Position of square button
int rectBx, rectBy;
int rectx4, rectx5,recty4, recty5;
int circleX, circleY;  // Position of circle button
int rectSize = 90;     // Diameter of rect
int rectsizeB = 75;
int rectsizexy = 25;
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver,Over4,Over5, OverB = false;
boolean circleOver = false;

void setup() {
  size(640, 650);
  
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  noStroke();
  
  hs4 = new HScrollbar(70, 400, width-140, 25, 1);
  hs5 = new HScrollbar(70, 500, width-140, 25, 1);
  
  rectColor = color(0);
  rectHighlight = color(100);
  circleColor = color(200);
  circleHighlight = color(150);
  baseColor = color(102);
  currentColor = 255;;
  circleX = width/2+circleSize/2+10;
  circleY = 575;
  rectX = width/2-rectSize-10;
  rectY = 530;
  rectBx = (width/2) - (rectsizeB/2);
  rectBy = 230;
  rectx4 = 20;
  recty4 = 387;
  rectx5 = 20;
  recty5 = 487;
  ellipseMode(CENTER);

}

void draw() {
  
    update(mouseX, mouseY);
  background(currentColor);
  
  if (OverB) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectBx, rectBy, rectsizeB, rectsizeB);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
 
  if (Over4) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectx4,recty4,rectsizexy,rectsizexy);
  if (Over5) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectx5,recty5,rectsizexy,rectsizexy);
  
  if (circleOver) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  ellipse(circleX, circleY, circleSize, circleSize);
  
  textSize(30);
  fill(255);
  
  float img4Pos = hs4.getPos();
  int value4 = (int(int(img4Pos)-73))/5;
  fill(255);
  
  float img5Pos = hs5.getPos();
  int value5 = (int(int(img5Pos)-73))/5;
  fill(255);
  
 
  text("MODE     -->  "+ value4 + " %", width/2-45, 375);
  text("THROTTLE -->  "+ value5 + " %", width/2-75, 475);
  text("|ON|",  231, height - 2);
  text("|OFF|",  339, height - 2);
  textSize(35);
  text("BRAIN CONTROLLED QUADCOPTER", 25, 50);
  text("INTERFACE (WIRELESS)", 120, 100);
  textSize(25);
  text("CHARACTER SELECTED", 5, 180);
  text("DIRECTION SELECTED", width/2+50, 180);
  text("|", (width/2)-2, 180);
  
  
  
 
 
  hs4.update(4);
  hs5.update(5);
 
   if(flag4){
     
  myPort.write(value4);

  }

  else if(flag5){
    
  myPort.write(value5);
 
  }else if(flagB){
    
    lines = loadStrings("Results.txt");
    String message = lines[0];
    char c = message.charAt(0);
    if(c == 'B' || c == 'C' || c == 'D' || c == 'E' || c == 'I' || c == 'J'){
    textSize(50);
    text("( " + c + " )", 100, 280);
    text("FORWARD", 375, 280);
    myPort.write('a');
    }else if(c == '1' || c == '2' || c == '6' || c == '7' || c == '8' || c == '9'){
      textSize(50);
    text("( " + c + " )", 100, 280);
    text("BACKWARD", 360, 280);
    myPort.write('b');
    
    }else if(c == 'F' || c == 'L' || c == 'R' || c == 'X' || c == '4' || c == '0'){
      textSize(50);
    text("( " + c + " )", 100, 280);
    text("RIGHT", 420, 280);
    myPort.write('d');
    
    }else if(c == 'A' || c == 'G' || c == 'M' || c == 'S' || c == 'Y' || c == '5'){
      textSize(50);
    text("( " + c + " )", 100, 280);
    text("LEFT", 430, 280);
    myPort.write('c');
    
    }else{
    textSize(50);
    text("( " + c + " )", 100, 280);
    text("NULL", 420, 280);
    myPort.write('e');
    }
    // myPort.write(c);
    println(c);
    
  }else{}
  

  hs4.display();
  hs5.display();
  
flag4 = flag5 = false;

  
  
  stroke(0);
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update(int num) {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
      
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
     
      if(num == 4){
      flag4 = true;
      }
      if(num == 5){
      flag5 = true;
      }
      
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }

  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(255);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(150, 50, 200);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
    rectOver = false;
    Over4 = false;
    Over5 = false;
    OverB = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver = false;
    Over4 = false;
    Over5 = false;
    OverB = false;
  } else if ( overRect(rectx4, recty4, rectsizexy, rectsizexy) ) {
    rectOver = false;
    circleOver = false;
    Over4 = true;
    Over5 = false;
    OverB = false;
  } else if ( overRect(rectx5, recty5, rectsizexy, rectsizexy) ) {
    rectOver = false;
    circleOver = false;
    Over4 = false;
    Over5 = true;
    OverB = false;
  }else if(overRect(rectBx, rectBy, rectsizeB, rectsizeB)){
    rectOver = false;
    circleOver = false;
    Over4 = false;
    Over5 = false;
    OverB = true;
  }else{
    circleOver = rectOver  = Over4 = Over5 = OverB = false;
  }
}

void mousePressed() {
  
 
  if (OverB){
    currentColor = rectColor;
    println("BRAIN");
    myPort.write('B');
   flagB = true;
  }
  if (Over4){
    currentColor = rectColor;
    println("MODE");
    myPort.write('v');
   flagB = false;
  }
  if (Over5){
    currentColor = rectColor;
    println("THROTTLE");
    myPort.write('w');
   flagB = false;
  }
  if (circleOver) {
    currentColor = circleColor;
    println("QUAD communication disabled");
    myPort.write('y'); 
   flagB = false;
  }
  if (rectOver) {
    currentColor = rectColor;
    println("QUAD communication enabled");
    myPort.write('x'); 
  flagB = false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
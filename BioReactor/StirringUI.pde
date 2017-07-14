import processing.serial.*;

Serial port;
boolean firstContact = false;

String currentRPM = "500";
int desiredRPM = 500;

int plusX, plusY;    // Position of + button
int minusX, minusY;  // Position of - button
int plusSize = 20;   // Diameter of rect
int minusSize = 20;
boolean plusOver = false;
boolean minusOver = false;

String readDataLine() {
  return port.readStringUntil('\n');
}

void decrementRPM() {
    desiredRPM = desiredRPM - 50;
    desiredRPM = constrain(desiredRPM, 500, 1500);
    port.write("1");
}

void incrementRPM() {
    desiredRPM = desiredRPM + 50;
    desiredRPM = constrain(desiredRPM, 500, 1500);
    port.write("2");
}

void buildBackground() {
  background(0);
  fill(255);
  textSize(26);
  text("Current RPM:", width/3 - 140, height/2 - 20);
  text("Desired RPM:", (2*width)/3 - 30, height/2 - 20);
  text(currentRPM, width/3 - 140, height/2 + 20);
  text(desiredRPM, (2*width)/3 - 30, height/2 + 20);
  
  minusX = (2*width)/3 + 40;
  minusY = height/2;
  plusX = (2*width)/3 + 62;
  plusY = height/2;
  
  rect(plusX, plusY, plusSize, plusSize);
  rect(minusX, minusY, minusSize, minusSize);
  fill(0);
  text("-", minusX + 3, minusY + 18);
  text("+", plusX, plusY + 18);
}

void setup() {
  size(600, 300);
  buildBackground();
  
  printArray(Serial.list());
  
  // change portName to match port used to connect LaunchPad
  //In PC the name will be something like "COM8"
  String portName = "COM3";
  port = new Serial(this, portName, 9600);
}

void draw() {
  buildBackground();
  if (port.available() > 0) {
    currentRPM = readDataLine();
    println(currentRPM);
  }
}

void mousePressed() {
  if (plusOver(plusX, plusY, plusSize, plusSize)) incrementRPM();
  if (minusOver(minusX, minusY, minusSize, minusSize)) decrementRPM();
}

boolean plusOver(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean minusOver(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
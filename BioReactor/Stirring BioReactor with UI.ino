// Written by Cesar Ferradas, 9 Dec 2015
// Program calculates stirring speed (in RPM) from sensors
// and reads desired speed (in RPM) from Processing UI.
// Program adjusts speed of motor as needed.

int motorPin = 14;    // Motor connected to digital pin 14 (P1.6)
int rpm = 500;
int inByte = 0;

float turn = 0;
boolean wasOn = false;

void setup()  { 
  Serial.begin(9600);
} 

void loop()  {
  if(Serial.available() > 0) {
    //Reading value from Processing. "1" is represented as 49 in integers and "2" as 50.
    inByte = Serial.read();
  
    if(inByte == 49 && rpm >= 550) rpm = rpm - 50;
    if(inByte == 50 && rpm <= 1450) rpm = rpm + 50;
  
    //Writing the current RPM to Processing.
    //Serial.println(calculateCurrentRPM());
    //If this Serial.println calculateCurrentRPM() does not work, comment it out and uncomment the next line:
    Serial.println(rpm);
  }
  analogWrite(motorPin, rpm / 30);
}

long unsigned int calculateCurrentRPM() {
  // Reading the value from pin A3 (P1.3) that reads data from phototransistor
  turn = 0;
  int lightValue = analogRead(P1_3); //P1_3 or A3
  //Serial.println(lightValue);
  
  int startTime = millis(); // millis gives the time in milliseconds since the program started
  int endTime = startTime;
  while(endTime - startTime < 1000) { // while less than a second
    if(lightValue > 400 && !wasOn) {
      wasOn = true;
      turn = turn + 0.5;
    }
    if(lightValue < 400 && wasOn) {
      wasOn = false;
      turn = turn + 0.5;
    }
    
    endTime = millis();
  }
  
  return turn*60;
}

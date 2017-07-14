// Written by Cesar Ferradas, 9 Dec 2015
// Program calculates stirring speed (in RPM) from sensors
// and reads desired speed (in RPM) from Processing UI.
// Program adjusts speed of motor as needed.

int motorPin = 14;    // Motor connected to digital pin 14 (P1.6)
int rpm = 0;
int inByte = 1;
float turn = 0;
boolean wasOn = false;

//Previous code below: works on Serial Monitor
void setup()  { 
  Serial.begin(9600);
} 

void loop()  {
  //Reading the desired RPM from Serial Monitor:
  int serial = Serial.parseInt();
  
  if(serial > 0) rpm = (int)(serial / 30); // sets the value (range from 0 to 255):
  
  analogWrite(motorPin, rpm);

  //Writing the current RPM to Procesing UI for display:
  Serial.println(calculateCurrentRPM());
  //If this Serial.println calculateCurrentRPM() does not work, comment it out and uncomment the next line:
  //Serial.println(rpm*30);
  
}

long unsigned int calculateCurrentRPM() {
  // Reading the value from pin A3 (P1.3) that reads data from phototransistor
  turn = 0;
  int lightValue = analogRead(A3);
  //Serial.println(lightValue);
  
  int startTime = millis();
  int endTime = startTime;
  while(endTime - startTime < 1000) {
    if(lightValue > 400 && !wasOn) {
      wasOn = true;
      turn = turn + 0.5; // change this
    }
    if(lightValue < 400 && wasOn) {
      wasOn = false;
      turn = turn + 0.5;
    }
    
    endTime = millis();
  }
  
  return turn*60;
}

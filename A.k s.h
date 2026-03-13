/*
PROJECT: Smart Helmet Safety System
CODE FOR: HELMET UNIT
FUNCTION:
Helmet sensor aur alcohol sensor check karega
Aur result bike unit ko bhejega
*/

int helmetSensor = 2;
int alcoholSensor = A0;

int alcoholLimit = 400;

void setup() {
  pinMode(helmetSensor, INPUT);
  Serial.begin(9600);
}

void loop() {

  int helmet = digitalRead(helmetSensor);
  int alcohol = analogRead(alcoholSensor);

  if (helmet == HIGH && alcohol < alcoholLimit) {
    Serial.println("SAFE");
  }

  else if (helmet == LOW) {
    Serial.println("NO_HELMET");
  }

  else if (alcohol >= alcoholLimit) {
    Serial.println("ALCOHOL");
  }

  delay(1000);
}
#define TDS_PIN A0

void setup() {
  Serial.begin(9600);
}

void loop() {
  int tdsValue = analogRead(TDS_PIN);
  
  float voltage = tdsValue * (5.0 / 1023.0);
  float tds = voltage * 500;

  Serial.print("TDS Value: ");
  Serial.println(tds);

  delay(1000);
}
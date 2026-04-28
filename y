#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <OneWire.h>
#include <DallasTemperature.h>

// 1. Agar 0x27 par kaam nahi kar raha, toh 0x3F try karein
LiquidCrystal_I2C lcd(0x27, 16, 2); 

#define ONE_WIRE_BUS 2
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

#define TDS_PIN A0
#define PUMP1 7
#define PUMP2 8

unsigned long startTime;
bool pump2On = false;

void setup() {
  Serial.begin(9600);
  
  // LCD Setup: Kuch LCDs ko init() ki jagah begin() chahiye hota hai
  lcd.init();           
  lcd.backlight();
  lcd.clear();
  lcd.print("System Starting...");

  sensors.begin();

  pinMode(PUMP1, OUTPUT);
  pinMode(PUMP2, OUTPUT);

  digitalWrite(PUMP1, LOW);
  digitalWrite(PUMP2, HIGH);

  startTime = millis();
  delay(2000); // Thoda waqt dein display ko setup hone ke liye
}

void loop() {
  sensors.requestTemperatures();
  float tempC = sensors.getTempCByIndex(0);

  int tdsValue = analogRead(TDS_PIN);
  float voltage = tdsValue * (5.0 / 1023.0);
  float tds = voltage * 500;

  if (!pump2On && (millis() - startTime > 5000)) {
    digitalWrite(PUMP2, LOW);
    pump2On = true;
  }

  // Display update
  lcd.setCursor(0, 0);
  lcd.print("Temp: ");
  lcd.print(tempC);
  lcd.print(" C  "); // Extra spaces purane digits hatane ke liye

  lcd.setCursor(0, 1);
  lcd.print("TDS: ");
  lcd.print((int)tds); // TDS ko integer mein dikhana behtar hai
  lcd.print(" PPM    ");

  // Serial Monitor check
  Serial.print("Temp: "); Serial.print(tempC);
  Serial.print(" C | TDS: "); Serial.println(tds);

  delay(1000);
}

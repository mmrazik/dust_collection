#define currentSensor A0
#define inputLED 2
#define outputLED 3
#define ssrPIN 4
#define buttonPIN 5

float resistor = 200.0;


float voltage;

float current;
float proudRMSPresRezistor;
float proudRMSmereny;
unsigned long lastChange = 0;

void setup() {
  
  Serial.begin(115200);
  Serial.println("Starting");
  
  pinMode(currentSensor, INPUT);
  pinMode(buttonPIN, INPUT);
  pinMode(inputLED, OUTPUT);
  pinMode(outputLED, OUTPUT);
  pinMode(ssrPIN, OUTPUT);
  

  digitalWrite(inputLED, HIGH);
}

bool enforceSocket = false;

void loop() {
    
  voltage = getVoltage() * 0.707;
  current = (voltage * 1000.0 /  resistor) * 1000;
  Serial.println(current, 3);
  enforceSocket = digitalRead(buttonPIN) == HIGH;
  Serial.print("EnforceSocket: ");
  Serial.println(enforceSocket);
  
  

  if ( enforceSocket || ((current > 20) && ((millis() - lastChange) > 2000))) {
      digitalWrite(outputLED, HIGH);
      digitalWrite(ssrPIN, HIGH);
      lastChange = millis();
  } else 
  if ((millis() - lastChange) > 2000) {
      digitalWrite(outputLED, LOW);
      digitalWrite(ssrPIN, LOW);
      lastChange = millis();
  }
  
  delay(100);
}


float getVoltage() {  
  float result;
  int value;
  int max_value = 0;
  int min_value = 1024;
  
  unsigned long startTime = millis();
  
  while ((millis() - startTime) < 1000) {
    
    value = analogRead(currentSensor);    
    if (value > max_value) {
      max_value = value;
    }
    if (value < min_value) {
      min_value = value;
    }
  }
  
  result = (((max_value - min_value) * 5.0) / 1024.0) / 2.0;
  //Serial.print("Max measured voltage: "); 
  //Serial.println(result);
  
  return result;
}

#define IN1  13
#define IN2  12 
#define ENA  11

#define IN4  6
#define IN3  7
#define ENB  10

void setup() {
  for (int i = 11; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }  

}

void loop() {
  Drive_Motor(200);
  delay(1000);
  Drive_Motor(-200);
  delay(1000);
  Drive_Motor(0);
  delay(1000);
}
int Drive_Motor(int torque)  {
  if (torque >= 5)  {
    digitalWrite(IN1, LOW);                        
    digitalWrite(IN2, HIGH);
  }
  else if (torque <= 5 )  {
    digitalWrite(IN1, HIGH);                       
    digitalWrite(IN2, LOW);
  } 
  else {
    digitalWrite(IN1, HIGH);                       
    digitalWrite(IN2, HIGH);
  }
  torque = abs(torque);
  analogWrite(ENA,torque);
}



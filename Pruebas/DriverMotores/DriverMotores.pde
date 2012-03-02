#define IN1  9 
#define IN2  8 
#define ENA  11

#define IN4  6
#define IN3  7
#define ENB  10

void setup() {
  for (int i = 8; i <= 13; i++) {
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
    digitalWrite(IN3, LOW);                     
    digitalWrite(IN4, HIGH);
  }
  else if (torque <= 5 )  {
    digitalWrite(IN1, HIGH);                       
    digitalWrite(IN2, LOW);
    digitalWrite(IN3, HIGH);                      
    digitalWrite(IN4, LOW);

  } 
  else {
    digitalWrite(IN1, HIGH);                       
    digitalWrite(IN2, HIGH);
    digitalWrite(IN3, HIGH);                      
    digitalWrite(IN4, HIGH);
  }
  torque = abs(torque);
  analogWrite(ENA,torque);
  analogWrite(ENB,torque);
}



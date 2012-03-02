int IN1 = 13;
int IN2 = 12;
int IN3 = 9;
int IN4 = 8;

int ENA = 11;
int ENB = 10;

void setup() {
  

}

void loop() {
  
  
}
int Drive_Motor(int torque)  {
  if (torque >= 0)  {                                    // drive motors forward
    digitalWrite(IN1, LOW);                        
    digitalWrite(IN2, HIGH);
    digitalWrite(IN3, LOW);                     
    digitalWrite(IN4, HIGH);
  }  else {                                              // drive motors backward
    digitalWrite(IN1, HIGH);                       
    digitalWrite(IN2, LOW);
    digitalWrite(IN3, HIGH);                      
    digitalWrite(IN4, LOW);
    torque = abs(torque);
  }
    analogWrite(ENA,torque);
    analogWrite(ENB,torque * .9);                      // motor are not built equal...
}

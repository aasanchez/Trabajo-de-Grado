#include <PID_v1.h>
double Setpoint, Input, Output;
PID myPID(&Input, &Output, &Setpoint,2,5,1, DIRECT);
void setup(){
  Input = analogRead(0);
  Setpoint = 100;
  myPID.SetMode(AUTOMATIC);
}

void loop(){
  Input = analogRead(0);
  myPID.Compute();
  analogWrite(3,Output);
}



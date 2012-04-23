/*
  Blink
 Turns on an LED on for one second, then off for one second, repeatedly.
 
 This example code is in the public domain.
 */
int i;
void setup() {                
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(11, OUTPUT);     
}

void loop() {
  for(i=0;i<=20;i++){
    digitalWrite(11, HIGH);   // set the LED on
    delay(100);              // wait for a second
    digitalWrite(11, LOW);    // set the LED off
    delay(100);       
  }
  digitalWrite(11, HIGH);   // set the LED on
  delay(1000);              // wait for a second
  digitalWrite(11, LOW);    // set the LED off
  delay(1000);              // wait for a second
}


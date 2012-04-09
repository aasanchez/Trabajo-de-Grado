#define IN1  13
#define IN2  12 
#define ENA  11

#define IN3  8
#define IN4  7 
#define ENB  9

void setup() {
  for (int i = 7; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }  
  analogWrite(ENA,255);
  analogWrite(ENB,255);  
}

void loop() {
  avance();
  delay(1000);
  retroceso();
  delay(1000);
  stoped();
  delay(1000);
}

void avance(){
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);    
}

void retroceso(){
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, HIGH);    
}

void stoped(){
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, HIGH);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, HIGH);    
}

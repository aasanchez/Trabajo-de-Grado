#define IN1  13
#define IN2  12 
#define ENA  11

#define IN3  8
#define IN4  7 
#define ENB  9

void setup() {
  Serial.begin(9600); 
  for (int i = 7; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }  
  analogWrite(ENA,255);
  analogWrite(ENB,255);  
}

void loop() {
  Serial.println("Mover Motores"); 
  avance();
  while(1){
    delay(1000);
    delay(1000);    
    Serial.println("Avance"); 
  }
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

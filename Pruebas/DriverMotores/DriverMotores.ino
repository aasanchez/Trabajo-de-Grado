#define IN1 13
#define IN2 12
#define ENA 5

#define IN3 8
#define IN4 7
#define ENB 6

int a=0;
void setup() {
  Serial.begin(9600);
  for (int i = 7; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }
}

void loop() {
  stoped();
  while(1){
    Serial.println("MOT1");
      for (a=0;a<255;a++) {
        analogWrite(ENA,a);
        delay(10);
      }  
    for (a=255;a>0;a--) {
      analogWrite(ENA,a);
      delay(10);
    }
    Serial.println("MOT2");
      for (a=0;a<255;a++) {
        analogWrite(ENB,a);
        delay(10);
      }  
    for (a=255;a>0;a--) {
      analogWrite(ENB,a);
      delay(10);
    }    
    
    
  }
  /*
  Serial.println("Stop");
   stoped();
   delay(1000);  
   Serial.println("Retroceso");
   retroceso();
   delay(1000);
   Serial.println("Stop");
   stoped();
   delay(1000);*/
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
  digitalWrite(IN1, LOW;
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, HIGH);  
}






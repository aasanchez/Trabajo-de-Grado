#define IN1 13
#define IN2 12
#define ENA 5

#define IN3 8
#define IN4 7
#define ENB 6

int a=2000;
int pwm = 100;
void setup() {
  Serial.begin(9600);
  for (int i = 7; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }
  analogWrite(ENA,pwm*0.80); //Derecha
  analogWrite(ENB,pwm); //Izquierda
}

void loop() {
  avance();
  delay(a);
  retroceso();
  delay(a);
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
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
  digitalWrite(IN3, LOW);
  digitalWrite(IN4, LOW);  
}










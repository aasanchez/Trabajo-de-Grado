/*
 Autor: Alexis Sanchez
 Funciones para el Control de Motores
 */

int Drive_Motor(int torque)  {
  torque = constrain(torque, -255, 255);
  if (torque > 0)  {       
    backward();
  }  
  else {                                           
    forward();
  }
  torque = abs(torque);
  analogWrite(ENA,torque);
  analogWrite(ENB,torque);
}


void forward(){
  digitalWrite(IN1, HIGH); //Amarillo  MOT1                      
  digitalWrite(IN2, LOW);  //Rojo      MOT1
  digitalWrite(IN3, HIGH); //Amarillo  MOT2          
  digitalWrite(IN4, LOW);  //Rojo      MOT2
}

void backward(){
  digitalWrite(IN1, LOW);  //Amarillo  MOT1                      
  digitalWrite(IN2, HIGH); //Rojo      MOT1
  digitalWrite(IN3, LOW);  //Amarillo  MOT2          
  digitalWrite(IN4, HIGH); //Rojo      MOT2
}

void left(){
  digitalWrite(IN1, HIGH); //Amarillo  MOT1                      
  digitalWrite(IN2, LOW);  //Rojo      MOT1
  digitalWrite(IN3, LOW);  //Amarillo  MOT2          
  digitalWrite(IN4, HIGH); //Rojo      MOT2  
}

void right(){
  digitalWrite(IN1, LOW);  //Amarillo  MOT1                      
  digitalWrite(IN2, HIGH); //Rojo      MOT1
  digitalWrite(IN3, HIGH); //Amarillo  MOT2          
  digitalWrite(IN4, LOW);  //Rojo      MOT2  
}

void stoped(){
  digitalWrite(IN1, HIGH); //Amarillo  MOT1                      
  digitalWrite(IN2, HIGH); //Rojo      MOT1
  digitalWrite(IN3, HIGH); //Amarillo  MOT2          
  digitalWrite(IN4, HIGH); //Rojo      MOT2 
}








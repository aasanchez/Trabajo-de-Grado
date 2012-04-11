/*
int Drive_Motor(int torque)  {
  if (torque >= 0)  {                                  
    digitalWrite(InA_R, HIGH);                        
    digitalWrite(InB_R, HIGH);
    digitalWrite(InA_L, HIGH);                     
    digitalWrite(InB_L, HIGH);
  }  
  else {                                           
    digitalWrite(InA_R, LOW);                       
    digitalWrite(InB_R, LOW);
    digitalWrite(InA_L, LOW);                      
    digitalWrite(InB_L, LOW);
    torque = abs(torque);
  }
  analogWrite(PWM_R,torque);
  analogWrite(PWM_L,torque);                      
}
*/

void forward(){
  digitalWrite(IN1, HIGH); //Amarillo  MOT1                      
  digitalWrite(IN2, LOW);  //Rojo      MOT1
  digitalWrite(IN3, HIGH); //Amarillo  MOT2          
  digitalWrite(IN4, LOW);  //Rojo      MOT2  
}

void backward(){
  digitalWrite(IN1, LOW);  //Amarillo  MOT1                      
  digitalWrite(IN2, LOW); //Rojo      MOT1
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


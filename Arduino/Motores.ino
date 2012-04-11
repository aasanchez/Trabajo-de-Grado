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

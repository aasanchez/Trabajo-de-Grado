/*
 Autor: Alexis Sanchez
 Comunicacion Serial para Debug
*/

void serialOut_sensor() {
  Serial.print(ACC_angle);
  Serial.print(",");
  Serial.println(GYRO_rate);  
}

void serialOut_labView() {
  Serial.print(actAngle);
  Serial.print(",");
  Serial.println(drive);
}


void serialOut_Motoresl() {
  Serial.print(actAngle);
  Serial.print(",");
  Serial.println(drive);
}

void SerialAll(){
  Serial.print("Ciclo-");
  Serial.print(cicle);
  Serial.print("\t");  
  Serial.print(ACC_angle);
  Serial.print("\t");  
  Serial.print(GYRO_rate);
  Serial.print("\t");
  Serial.println("");  
}

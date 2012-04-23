/*
 Autor: Alexis Sanchez
 Comunicacion Serial para Debug
 */
void serialOut_aceleraciones() {
  Serial.print(IMU[5]);
  Serial.print(",");
  Serial.print(IMU[3]);  
  Serial.print(",");
  Serial.print(ACC_angle);  
  Serial.print(",");
  Serial.println(actAngle);
}

void serialOut_sensor() {
  Serial.print(ACC_angle);
  Serial.print(",");
  Serial.println();  
}

void serialOut_labView() {
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
  Serial.print(actAngle);
  Serial.print("\t");
  Serial.println("");  
}


/*
 Autor: Alexis Sanchez
 Comunicacion Serial para Debug
*/

void serialOut_sensor() {
  
}

void serialOut_labView() {
  Serial.print(ACC_angle);
  Serial.print(",");
  Serial.println(actAngle);
}


void serialOut_Motoresl() {
  Serial.print(actAngle);
  Serial.print(",");
  Serial.println(drive);
}


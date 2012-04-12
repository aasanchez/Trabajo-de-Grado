/*
 Autor: Alexis Sanchez
 Comunicacion con IMU3000 Combo
*/

// Funcion para escribir un valor en una direccion en un dispositivo especifico
void writeTo(int device, byte address, byte val) {
  Wire.beginTransmission(device); // Comienza la transmision
  Wire.write(address); // Envia la direccion
  Wire.write(val); // Envia el valor
  Wire.endTransmission(); // Finaliza la transmision
}

void configIMU(){
  // Configuramos el Giroscopo
  // Velocidad de Muestreo 1kHz, Filtro de ancho de banda 42Hz, Rango del Girospoco 500 d/s
  writeTo(GYRO, 0x16, 0x0B);
  //Establecer la direccion del acelerometro
  writeTo(GYRO, 0x18, 0x32);
  //Setear el acelerometro como esclavo
  writeTo(GYRO, 0x14, ACCEL);

  // Ajuste el modo de paso a través de Accelerometro para que podamos encenderlo
  writeTo(GYRO, 0x3D, 0x08);
  // establecer el control de aceleración poder para 'medir'
  writeTo(ACCEL, ADXL345_POWER_CTL, 8);
  //cancelar el pasar a través del acelerometro, el Giroscopo ahora leerá aceleración para nosotros
  writeTo(GYRO, 0x3D, 0x28);
}

void getIMU(){
  for(int n=0;n<=5;n++){
    IMU[n] = 0; //Limpiamos el vector
  }

  Wire.beginTransmission(GYRO);
  Wire.write(REG_GYRO_X); 
  Wire.endTransmission();


  Wire.beginTransmission(GYRO);
  Wire.requestFrom(GYRO,12); 
  i = 0;
  while(Wire.available()){
    buffer[i] = Wire.read();
    i++;
  }
  Wire.endTransmission();


  IMU[0] = buffer[0] << 8 | buffer[1];
  IMU[1] = buffer[2] << 8 | buffer[3];
  IMU[2] = buffer[4] << 8 | buffer[5];

  IMU[3] = buffer[7] << 8 | buffer[6];
  IMU[4] = buffer[9] << 8 | buffer[8];
  IMU[5] = buffer[11] << 8 | buffer[10];
}

void calibrarIMU(){
  //Numero de Muestras para calibracin
  int muestras = 500;
  //Limpiamos el Vector
  for(int n=0;n<=5;n++){
    zeroIMU[n] = 0;
  }
  for(int n=0;n<=5;n++){
    tempIMU[n] = 0;
  }
  //Sumamos para para el Promedio
  for(int n=0;n<muestras;n++){
    getIMU();
    for(int n=0;n<5;n++){
      tempIMU[n] = tempIMU[n] + IMU[n];
    }
  }
  //Dividimos y obtenemos el promdio
  for(int n=0;n<5;n++){
    zeroIMU[n] = tempIMU[n] / muestras;
  }
  zeroIMU[5] = 0; //Correccion segun datasheet
}

void updateSensors(){
  //Numero de Muestras para lectura
  int muestras = 2;
  //Limpiamos el Vector
  for(int n=0;n<=5;n++){
    tempIMU[n] = 0;
  }
  //Sumamos para para el Promedio
  for(int n=0;n<muestras;n++){
    getIMU();
    for(int n=0;n<=5;n++){
      tempIMU[n] = tempIMU[n] + IMU[n];
    }
  }
  //Dividimos y obtenemos el promdio y restamos el valor de Calibracion
  for(int n=0;n<=5;n++){
    IMU[n] = (tempIMU[n] / muestras)-zeroIMU[n];
  }
}

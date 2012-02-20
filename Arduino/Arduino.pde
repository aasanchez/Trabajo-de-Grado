/* 
 Institucion: UNIVERSIDAD YACAMBU
 Titulo: VEHÍCULO PARA PERSONAS CON COMPROMISOS MOTRICES BAJO EL MODELO DE PÉNDULO INVERTIDO.
 Autor: Alexis Sanchez
 Creative Commons
 */

#define GYRO 0x68         // Direccion del Giroscopo para I2C
#define REG_GYRO_X 0x1D   // Direccion para GYRO_XOUT_H en el IMU-3000 
#define ACCEL 0x53        // Direccion del Acelerometro para I2C
#define ADXL345_POWER_CTL 0x2D

byte buffer[12];   // Array para almacenar los valdores del ADC
int IMU[6];
int gyro_x;
int gyro_y;
int gyro_z;
int accel_x;
int accel_y;
int accel_z;
int i;


#include <Wire.h>

void setup(){
  Serial.begin(9600); 

  Wire.begin();
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

// Funcion para escribir un valor en una direccion en un dispositivo especifico
void writeTo(int device, byte address, byte val) {
  Wire.beginTransmission(device); // Comienza la transmision
  Wire.send(address);             // Envia la direccion
  Wire.send(val);                 // Envia el valor
  Wire.endTransmission();         // Finaliza la transmision
}

void getIMU(){
  int IMUtemp[6];
  // Read the Gyro X, Y and Z and Accel X, Y and Z all through the gyro
  // First set the register start address for X on Gyro  
  Wire.beginTransmission(GYRO);
  Wire.send(REG_GYRO_X); //Register Address GYRO_XOUT_H
  Wire.endTransmission();

  // New read the 12 data bytes
  Wire.beginTransmission(GYRO);
  Wire.requestFrom(GYRO,12); // Read 12 bytes
  i = 0;
  while(Wire.available()){
    buffer[i] = Wire.receive();
    i++;
  }
  Wire.endTransmission();

  //Combine bytes into integers
  // Gyro format is MSB first
  IMUtemp[0] = buffer[0] << 8 | buffer[1];
  IMUtemp[1] = buffer[2] << 8 | buffer[3];
  IMUtemp[2] = buffer[4] << 8 | buffer[5];
  // Accel is LSB first. Also because of orientation of chips
  // accel y output is in same orientation as gyro x
  // and accel x is gyro -y
  IMUtemp[3] = buffer[7] << 8 | buffer[6];
  IMUtemp[4] = buffer[9] << 8 | buffer[8];
  IMUtemp[5] = buffer[11] << 8 | buffer[10];
  return IMU;
}

void loop(){
  dataIMU = getIMU();
}



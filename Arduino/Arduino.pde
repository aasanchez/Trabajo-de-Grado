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
int gyro_x;
int gyro_y;
int gyro_z;
int accel_x;
int accel_y;
int accel_z;
long cal_gyro_x;
long cal_gyro_y;
long cal_gyro_z;
long cal_accel_x;
long cal_accel_y;
long cal_accel_z;

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
  gyro_x = buffer[0] << 8 | buffer[1];
  gyro_y = buffer[2] << 8 | buffer[3];
  gyro_z = buffer[4] << 8 | buffer[5];
  // Accel is LSB first. Also because of orientation of chips
  // accel y output is in same orientation as gyro x
  // and accel x is gyro -y
  accel_x = buffer[7] << 8 | buffer[6];
  accel_y = buffer[9] << 8 | buffer[8];
  accel_z = buffer[11] << 8 | buffer[10];
}
void printIMU(){
  Serial.print(gyro_x);  // echo the number received to screen
  Serial.print(",");
  Serial.print(gyro_y);  // echo the number received to screen
  Serial.print(",");    
  Serial.print(gyro_z);  // echo the number received to screen 
  Serial.print(",");     
  Serial.print(accel_x);  // echo the number received to screen
  Serial.print(",");
  Serial.print(accel_y);  // echo the number received to screen
  Serial.print(",");    
  Serial.print(accel_z);  // echo the number received to screen
  Serial.println("");     // prints carriage return  
}
void calibrarIMU(){
  int limite = 100;
  for(int n=0;n<limite;n++){
    getIMU();
    cal_gyro_x = cal_gyro_x + gyro_x;
    cal_gyro_y = cal_gyro_y + gyro_y;
    cal_gyro_z = cal_gyro_z + gyro_z;
    cal_accel_x = cal_accel_x + accel_x;
    cal_accel_y = cal_accel_y + accel_y;
    cal_accel_z = cal_accel_z + accel_z;
  }
  cal_gyro_x = cal_gyro_x / limite;
  cal_gyro_y = cal_gyro_y / limite;
  cal_gyro_z = cal_gyro_z / limite;
  cal_accel_x = cal_accel_x / limite;
  cal_accel_y = cal_accel_y / limite;
  cal_accel_z = cal_accel_z / limite;
  
  /*
  Serial.print(cal_gyro_x);  // echo the number received to screen
  Serial.print(",");
  Serial.print(cal_gyro_y);  // echo the number received to screen
  Serial.print(",");    
  Serial.print(cal_gyro_z);  // echo the number received to screen 
  Serial.print(",");     
  Serial.print(cal_accel_x);  // echo the number received to screen
  Serial.print(",");
  Serial.print(cal_accel_y);  // echo the number received to screen
  Serial.print(",");    
  Serial.print(cal_accel_z);  // echo the number received to screen
  Serial.println("");     // prints carriage return    
  */
}

void loop(){
  getIMU();
  calibrarIMU();
  delay(1000);
  delay(1000);  
}




/* 
 Institucion: UNIVERSIDAD YACAMBU
 Titulo: VEHÍCULO PARA PERSONAS CON COMPROMISOS MOTRICES BAJO EL MODELO DE PÉNDULO INVERTIDO.
 Autor: Alexis Sanchez
 Creative Commons
 */
#include <math.h>
#include <Wire.h>

#define GYRO 0x68         // Direccion del Giroscopo para I2C
#define REG_GYRO_X 0x1D   // Direccion para GYRO_XOUT_H en el IMU-3000 
#define ACCEL 0x53        // Direccion del Acelerometro para I2C
#define ADXL345_POWER_CTL 0x2D

//
//  Variables para el Control de IMU
//
byte buffer[12];           // Array para almacenar los valdores del I2C
int  IMU[6];               // Valores del IMU 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ
int  zeroIMU[6];           // Resultado de Calibracion IMU, para puesta a 0; 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ
long tempIMU[6];           // valores temporales de Calibracion del IMU 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ

//  Calculos de Estabilizacion
int  ACC_angle;            // Angulo de Retorno de Arctan2
int  GYRO_rate;

//  Variables de Tiempo
int  STD_LOOP_TIME  = 9; 
int  lastLoopTime = STD_LOOP_TIME;
int  lastLoopUsefulTime = STD_LOOP_TIME;
unsigned long loopStartTime = 0;

//Variables Operativas
int i;                    // Variable de iteracion General

//Alias a Pines
int RunLed = 13;          // Led de inicio codigo

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

// Funcion para escribir un valor en una direccion en un dispositivo especifico
void writeTo(int device, byte address, byte val) {
  Wire.beginTransmission(device);   // Comienza la transmision
  Wire.send(address);               // Envia la direccion
  Wire.send(val);                   // Envia el valor
  Wire.endTransmission();           // Finaliza la transmision
}

void getIMU(){
  for(int n=0;n<=5;n++){
    IMU[n] = 0;                    //Limpiamos el vector
  }
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
  IMU[0] = buffer[0] << 8 | buffer[1];
  IMU[1] = buffer[2] << 8 | buffer[3];
  IMU[2] = buffer[4] << 8 | buffer[5];
  // Accel is LSB first. Also because of orientation of chips
  // accel y output is in same orientation as gyro x
  // and accel x is gyro -y
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

void leerIMU(){
  //Numero de Muestras para lectura
  int muestras = 3;
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

int getAccAngle() {
  return arctan2(-IMU[5], -IMU[3]) + 256;    // En Quids
}

int getGyroRate() {
  return int(IMU[1] / 4.583333333);
}

int arctan2(int y, int x) {
  int coeff_1 = 128;
  int coeff_2 = 3*coeff_1;
  float abs_y = abs(y)+1e-10;
  float r, angle;

  if (x >= 0) {
    r = (x - abs_y) / (x + abs_y);
    angle = coeff_1 - coeff_1 * r;
  }  
  else {
    r = (x + abs_y) / (abs_y - x);
    angle = coeff_2 - coeff_1 * r;
  }
  if (y < 0)      return int(-angle);
  else            return int(angle);
}

void serialOut_sensor() {
static int skip=0;
  if(skip++==20) {
    skip = 0;
    Serial.print(ACC_angle);
    Serial.print(",");
    Serial.print(GYRO_rate);
    Serial.print("\\n");
  }
}

void setup(){
  pinMode(RunLed, OUTPUT);
  digitalWrite(RunLed, LOW);
  Serial.begin(115200);           //Declaramos la comunicacion Serial
  Wire.begin();                   //Iniciamos la comunicacion I2C
  configIMU();                    //Configuramos el IMU3000
  calibrarIMU();                  //Calibramos el sensor con los valores actuales
  digitalWrite(RunLed, HIGH);  
}


void loop(){
  // ********************* Adquisicion de Sensor y Filtrado *******************
  leerIMU();
  ACC_angle = getAccAngle();
  GYRO_rate = getGyroRate();
  // ****************************+* print Debug  ******************************
  serialOut_sensor();
  
  
  
  
}





















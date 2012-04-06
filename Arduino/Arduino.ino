
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
int ACC_angle;            // Angulo de Retorno de Arctan2
int GYRO_rate;
int actAngle;

//  Variables de Tiempo
int  STD_LOOP_TIME  = 9; 
int  lastLoopTime = STD_LOOP_TIME;
int  lastLoopUsefulTime = STD_LOOP_TIME;
unsigned long loopStartTime = 0;

//Variables Operativas
int i;                    // Variable de iteracion General

//Alias a Pines


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
  Wire.write(address);               // Envia la direccion
  Wire.write(val);                   // Envia el valor
  Wire.endTransmission();           // Finaliza la transmision
}

void getIMU(){
  for(int n=0;n<=5;n++){
    IMU[n] = 0;                    //Limpiamos el vector
  }
  // Read the Gyro X, Y and Z and Accel X, Y and Z all through the gyro
  // First set the register start address for X on Gyro  
  Wire.beginTransmission(GYRO);
  Wire.write(REG_GYRO_X); //Register Address GYRO_XOUT_H
  Wire.endTransmission();

  // New read the 12 data bytes
  Wire.beginTransmission(GYRO);
  Wire.requestFrom(GYRO,12); // Read 12 bytes
  i = 0;
  while(Wire.available()){
    buffer[i] = Wire.read();
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
    Serial.print(",");
    Serial.println(0);
  }
}

void serialOut_labView() {
  Serial.print(actAngle);
  Serial.print(",");
  Serial.print(ACC_angle);
  Serial.print(",");
  Serial.println(0);  
}

// --- Kalman filter module  ----------------------------------------------------------------------------

float Q_angle  =  0.001;   //0.001
float Q_gyro   =  0.003;   //0.003
float R_angle  =  0.03;    //0.03

float x_angle = 0;
float x_bias = 0;
float P_00 = 0, P_01 = 0, P_10 = 0, P_11 = 0;
float dt, y, S;
float K_0, K_1;

float kalmanCalculate(float newAngle, float newRate,int looptime) {
  dt = float(looptime)/1000;
  x_angle += dt * (newRate - x_bias);
  P_00 +=  - dt * (P_10 + P_01) + Q_angle * dt;
  P_01 +=  - dt * P_11;
  P_10 +=  - dt * P_11;
  P_11 +=  + Q_gyro * dt;

  y = newAngle - x_angle;
  S = P_00 + R_angle;
  K_0 = P_00 / S;
  K_1 = P_10 / S;

  x_angle +=  K_0 * y;
  x_bias  +=  K_1 * y;
  P_00 -= K_0 * P_00;
  P_01 -= K_0 * P_01;
  P_10 -= K_1 * P_00;
  P_11 -= K_1 * P_01;

  return x_angle;
}


void setup(){
  Serial.begin(9600);           //Declaramos la comunicacion Serial
  Wire.begin();                   //Iniciamos la comunicacion I2C
  configIMU();                    //Configuramos el IMU3000
  calibrarIMU();                  //Calibramos el sensor con los valores actuales
}


void loop(){
  // ********************* Adquisicion de Sensor y Filtrado *******************
  updateSensors();
  ACC_angle = getAccAngle();
  GYRO_rate = getGyroRate();
  actAngle = kalmanCalculate(ACC_angle, GYRO_rate, lastLoopTime);
  // *************************** print Debug  *********************************
  serialOut_sensor();
  // *********************** loop timing control ******************************
  lastLoopUsefulTime = millis()-loopStartTime;
  if(lastLoopUsefulTime<STD_LOOP_TIME)         delay(STD_LOOP_TIME-lastLoopUsefulTime);
  lastLoopTime = millis() - loopStartTime;
  loopStartTime = millis();
}



















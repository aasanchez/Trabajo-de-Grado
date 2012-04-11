/*
Institucion: UNIVERSIDAD YACAMBU
 Titulo: VEHÍCULO PARA PERSONAS CON COMPROMISOS MOTRICES BAJO EL MODELO DE PÉNDULO INVERTIDO.
 Autor: Alexis Sanchez
 Creative Commons
 */
#include <math.h>
#include <Wire.h>

#define GYRO 0x68 // Direccion del Giroscopo para I2C
#define REG_GYRO_X 0x1D // Direccion para GYRO_XOUT_H en el IMU-3000
#define ACCEL 0x53 // Direccion del Acelerometro para I2C
#define ADXL345_POWER_CTL 0x2D

//Alias a Pines
#define IN1 13
#define IN2 12
#define ENA 5

#define IN3 8
#define IN4 7
#define ENB 6

//
// Variables para el Control de IMU
//
byte buffer[12]; // Array para almacenar los valdores del I2C
int IMU[6]; // Valores del IMU 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ
int zeroIMU[6]; // Resultado de Calibracion IMU, para puesta a 0; 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ
long tempIMU[6]; // valores temporales de Calibracion del IMU 0:GiroX;1:GiroY;2:GiroX;3:AccelX;4:AccelY;5:AccelZ
int ACC_angle; // Angulo de Retorno de Arctan2
int GYRO_rate;
int actAngle;


// Variables de Tiempo
int STD_LOOP_TIME = 5;
int lastLoopTime = STD_LOOP_TIME;
int lastLoopUsefulTime = STD_LOOP_TIME;
unsigned long loopStartTime = 0;

//Variables Operativas
int i; // Variable de iteracion General

// --- PID ----------------------------------------------------------------------------
float K = 0.5;
float Kp = 7;                           
float Ki = 1;                        
float Kd = -6;       
float Kp_Wheel = -0.025;   
float Kd_Wheel = -8;

int last_error = 0;
int integrated_error = 0;
float pTerm=0, iTerm=0, dTerm=0, pTerm_Wheel=0, dTerm_Wheel=0;
int GUARD_GAIN = 10;
int setPoint = 0;
int drive = 0;

// --- Kalman iltro ----------------------------------------------------------------------------
float Q_angle = 0.001;
float Q_gyro = 0.003;
float R_angle = 0.03;

float x_angle = 0;
float x_bias = 0;
float P_00 = 0, P_01 = 0, P_10 = 0, P_11 = 0;
float dt, y, S;
float K_0, K_1;


int getAccAngle() {
  return arctan2(-IMU[5], -IMU[3]) +256; // En Quids
}

int getGyroRate() {
  return int(IMU[1] / 4.583333333);
}

int arctan2(int y, int x) {     //http://dspguru.com/dsp/tricks/fixed-point-atan2-with-self-normalization
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
  if (y < 0) return int(-angle);
  else return int(angle);
}




void setup(){
  Serial.begin(9600); //Declaramos la comunicacion Serial
  Wire.begin(); //Iniciamos la comunicacion I2C
  configIMU(); //Configuramos el IMU3000
  calibrarIMU(); //Calibramos el sensor con los valores actuales
  for (int i = 7; i <= 13; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i,LOW);
  }
  i=0;
}

void loop(){
  // ********************* Adquisicion de Sensor y Filtrado *******************
  i=i+5;
  analogWrite(ENA,i);
  analogWrite(ENB,i);  
  backward
  ();
  delay(500);
  if(i>=240)  i=0;
  Serial.println(i);
  /*
  backward();
  delay(500);
  left();
  delay(500);
  right();
  delay(500); 
  stoped();
  delay(500);   
  /*
  
  updateSensors();
   ACC_angle = getAccAngle();
   GYRO_rate = getGyroRate();
   actAngle = kalmanCalculate(ACC_angle, GYRO_rate, lastLoopTime);
   
   // *********************** PID  y motor *****************
   
   drive = updatePid(setPoint, actAngle);                                     // 
   if(abs(actAngle-setPoint) < 100)                   Drive_Motor(drive); 
   else                                               Drive_Motor(0);         // 
   
   serialOut_Motoresl();
   
   // *********************** loop timing control ******************************
   lastLoopUsefulTime = millis()-loopStartTime;
   if(lastLoopUsefulTime<STD_LOOP_TIME) delay(STD_LOOP_TIME-lastLoopUsefulTime);
   lastLoopTime = millis() - loopStartTime;
   loopStartTime = millis();
   */
}





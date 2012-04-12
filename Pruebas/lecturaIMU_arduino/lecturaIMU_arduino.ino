#define GYRO 0x68         // gyro I2C address
#define REG_GYRO_X 0x1D   // IMU-3000 Register address for GYRO_XOUT_H
#define ACCEL 0x53        // Accel I2c Address
#define ADXL345_POWER_CTL 0x2D

byte buffer[12];
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
  writeTo(GYRO, 0x16, 0x0B);       
  writeTo(GYRO, 0x18, 0x32);     
  writeTo(GYRO, 0x14, ACCEL);     
  writeTo(GYRO, 0x3D, 0x08);     
  writeTo(ACCEL, ADXL345_POWER_CTL, 8);     
  writeTo(GYRO, 0x3D, 0x28);    

}

// Write a value to address register on device
void writeTo(int device, byte address, byte val) {
  Wire.beginTransmission(device);
  Wire.write(address);           
  Wire.write(val);               
  Wire.endTransmission();        
}

void loop(){
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
  gyro_x = buffer[0] << 8 | buffer[1];
  gyro_y = buffer[2] << 8 | buffer[3];
  gyro_z = buffer[4] << 8 | buffer[5];
  accel_y = buffer[7] << 8 | buffer[6];
  accel_x = buffer[9] << 8 | buffer[8];
  accel_z = buffer[11] << 8 | buffer[10];

  Serial.print(gyro_x);
  Serial.print("\t");
  Serial.print(gyro_y);
  Serial.print("\t");   
  Serial.print(gyro_z);
  Serial.print("\t");
  Serial.print(accel_x);
  Serial.print("\t");
  Serial.print(accel_y);
  Serial.print("\t");   
  Serial.println(accel_z);
}



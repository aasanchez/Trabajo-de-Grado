#!/usr/bin/env python
import serial
ser = serial.Serial("/dev/ttyACM0")
while 1:
	s = ser.readline()
	print s

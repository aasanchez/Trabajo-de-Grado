import processing.serial.*;

Serial myPort;

void setupSerial()
{
  // List all the available serial ports:
  println(Serial.list());
  // I know that the port 7 in the serial list on my pc
  // is always my  Arduino or Wiring module, so I open Serial.list()[7].
  // Open whatever port is the one you're using.
  String portName = Serial.list()[7];
  myPort = new Serial(this, portName, 19200);
  myPort.clear();
  // don't generate a serialEvent() until you get a newline (\n) byte:
  myPort.bufferUntil('\n');
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  
  //Dont update the controls when dragged and released event are active..
  if(!dragged && !released && !pressed){
   
    // if it's not empty:
    if (inString != null) {
      // trim off any whitespace:
      inString = trim(inString);
      
      if(skip > 5){
      
        if(split(inString, ",").length >= 21){  //The nr off expected values
        
          // convert to an array of floats:
          float[] temp = float(split(inString, ","));
          
          //Create temp variabels for each graph
          float[] f_roll = new float[2];
          float[] f_sensors = new float[3];
          float[] f_pid = new float[3];
          float[] f_drive = new float[1];
          float[] f_pid_par = new float[5];
          float[] f_loop = new float[4];
          float[] f_updateRate = new float[1];
          float[] f_motorOffsets = new float[2];
          
          //Getting the values for the roll control if any
          if(temp.length >= 2){
            arrayCopy(temp,0,f_roll,0,2);    //Moves the values for the graph to the graph temp value
            roll.setValues(f_roll);          //Add the values to the graph
          }
          
          //Getting the values for the sensors control if any
          if(temp.length >= 5){
            arrayCopy(temp,2,f_sensors,0,3);
            sensors.setValues(f_sensors);
          }
          
          //Getting the values for the pid control if any
          if(temp.length >= 8){
            arrayCopy(temp,5,f_pid,0,3);
            pid.setValues(f_pid);
          }
          
          //Getting the values for the drive control if any
          if(temp.length >= 9){
            arrayCopy(temp,8,f_drive,0,1);
            drive.setValues(f_drive);
          }
          
          //Getting the values for the PID control if any
          if(temp.length >= 15){
            arrayCopy(temp,10,f_pid_par,0,5);
            PID.setValues(f_pid_par);
          }
          
          //Getting the values for the loopTime control if any
          if(temp.length >= 18){
            arrayCopy(temp,15,f_loop,0,3);
            arrayCopy(temp,9,f_loop,3,1);
            loopTime.setValues(f_loop);
          }
          
          //Getting values for the updateRate control if any
          if(temp.length >= 19){
            arrayCopy(temp,18,f_updateRate,0,1);
            updateRate.setValues(f_updateRate);
          }
          
          //Getting values for the updateRate control if any
          if(temp.length >= 20){
            arrayCopy(temp,19,f_motorOffsets,0,2);
            motorOffsets.setValues(f_motorOffsets);
          }
        }
      }else{
        skip++;
      }
    }
  }
}


import processing.opengl.*;

/*
  Sets the scrren size
*/
void setupScreen(int type){
  switch(type){
    case 0:
      size(1024,580);
      break;
    case 1:
      size(1024,580, OPENGL);
      break;
    default:
      size(1024,580);
  }
  
  // set inital background:
  background(0);
  // turn on antialiasing:
  smooth();
}


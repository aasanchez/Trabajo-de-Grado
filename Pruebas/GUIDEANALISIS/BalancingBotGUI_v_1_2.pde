/*
  Balancing Bot GUI v1.2 beta
  
  Description:
  This is a sketch for getting and receiving information from a 
  balancing bot and also to control it..
  
  Version log:
  
  v1.2  Added the possibility to change the PID parameters setPoint, K, P, I, D;    
        A new controll called valueBox has partly bean developed to this version
        to be able to show and change values. It's not in use fully yet..  
        Added the possibility to change the update rate of the Gui..(The nr of loops to skip)
        Added the possibility to change the motor offsets
        Changed the serial speed to 115200 kb/s
  
  v1.1  Added support for maximazing graphs
        Be able to move around the controls
        Added a graph showing the value of drive
        Added a graph showing the value of pTerm, iTerm, dTerm

  Instructions:
  Dont forget to change the com port to the one on your computer
  in the setupSerial function in the serial_screen tab.
  
  Reads values throw serial communication from a arduino
  the message from the arduino should be like below.
  
  | ACC_angle, actAngle, ACC_X, ACC_Z, GYR_Y, pTerm, iTerm, dTerms, drive, error, setPoint, K, Kp, Ki, Kd, STD_LOOP_TIME, lastLoopUsefulTime, lastLoopTime, updateRate, motorOffsetL, motorOffsetR \n |
*/

controlManager controls;

graph roll;
graph sensors;
graph pid;
graph drive;

numericUpDown PID;
numericUpDown updateRate;
numericUpDown motorOffsets;

valueBox loopTime;

int skip = 0; //Skip the first five messages from the Arduino

boolean dragged = false;
boolean released = false;
boolean pressed = false;

void setup(){
  //Set the size and rendering mode
  // 0: 1024 x 580
  // 1: 1024 x 580 openGL
  setupScreen(0);
  
  // A graph showing the acc. values
  sensors = new graph(10, 10, 300, 200, -200, 200, "ACC_X, _Y, GYR_Y");     //Create a new graph
  sensors.labels[0] = "ACC_X";                                              //Sets the label for the values
  sensors.labels[1] = "ACC_Z";
  sensors.labels[2] = "GYR_Y";
  sensors.update();                                                         //Shows the graph with the new settings
  
  // A graph showing the gyr. values
  pid = new graph(10, 220, 300, 200, -300, 300, "pTerm, iTerm, dTerms");    //Create a new graph
  pid.labels[0] = "pTerm";                                                  //Sets the label for the values
  pid.labels[1] = "iTerm";
  pid.labels[2] = "dTerms";
  pid.update();                                                             //Shows the graph with the new settings
  
  // A graph showing the roll angle 
  // of the bot bot unfilterd and filterd
  roll = new graph(320, 10, 690, 200, -256, 256, "actAngle, ACC_angle");    //Create a new graph
  roll.labels[0] = "ACC_angle";                                             //Sets the label for the values
  roll.labels[1] = "actAngle";
  roll.update();                                                    //Shows the graph with the new settings
  
  drive = new graph(320, 220, 380, 200, -255, 255, "drives");       //Create a new graph
  drive.labels[0] = "drive";                                        //Sets the label for the values
  drive.update();                                                   //Shows the graph with the new settings
  
  
  PID = new numericUpDown(10, 430, 500, 90, 5, "PID values");       //Creats a new numericUpDoen
  PID.labels[0] = "setPoint";
  PID.labels[1] = "K";                                              //Sets the label and the parameter
  PID.labels[2] = "P";                                              //name for the serial print
  PID.labels[3] = "I";
  PID.labels[4] = "D";
  PID.inc[0] = 1;            
  PID.inc[1] = 0.1;  
  PID.inc[2] = 0.1;  
  PID.inc[3] = 0.1;  
  PID.inc[4] = 0.1;  
  PID.param_name[0] = 's';                                           //Sets the parameter name for the value to be sent to the bot
  PID.param_name[1] = 'k'; 
  PID.param_name[2] = 'p'; 
  PID.param_name[3] = 'i';
  PID.param_name[4] = 'd';                       
  PID.update();                  //Shows the numericUpDown with the new settings
  
  
  updateRate = new numericUpDown(520, 430, 180, 90, 1, "Update rate of GUI");       //Creats a new numericUpDoen
  updateRate.labels[0] = "updateRate";
  updateRate.inc[0] = 1;            
  updateRate.param_name[0] = 'u';                                           //Sets the parameter name for the value to be sent to the bot                    
  updateRate.update(); 
  
  motorOffsets = new numericUpDown(710, 430, 300, 90, 2, "Motor offsets");
  motorOffsets.labels[0] = "motorOffsetL";
  motorOffsets.labels[1] = "motorOffsetR";
  motorOffsets.inc[0] = 0.1;
  motorOffsets.inc[1] = 0.1;
  motorOffsets.param_name[0] = 'l';
  motorOffsets.param_name[1] = 'r';
  motorOffsets.update();
  
  loopTime = new valueBox(710, 220, 300, 200, 4, "Loop time & error");
  loopTime.labels[0] = "STD_LOOP_TIME";
  loopTime.labels[1] = "lastLoopUsefulTime";
  loopTime.labels[2] = "lastLoopTime";
  loopTime.labels[3] = "error";
  loopTime.update();
  
 
  controls = new controlManager();   //Create a new Control manager
  controls.graphs.add(roll);         //Add the graph roll
  controls.graphs.add(sensors);      //Add the graph sensors
  controls.graphs.add(pid);          //Add the graph pid
  controls.graphs.add(drive);        //Add the graph drive
  
  controls.numericUpDowns.add(PID);         //Add the numericUpDown PID
  controls.numericUpDowns.add(updateRate);  //Add the numericUpDown updateRate
  controls.numericUpDowns.add(motorOffsets);//Add the numericUpDown motorOffsets
  
  controls.valueBoxes.add(loopTime); //Add the value box loopTime
  
  setupSerial();  //Setting up the serial communication
}


void draw(){
  
}

void mouseDragged(){
  dragged = true;
  controls.MouseDragged();     //Send the mouseDragged event to the control manager
  dragged = false;
}

void mousePressed(){
  pressed = true;
  controls.MousePressed();
  pressed = false;
} 

void mouseReleased() {
  released = true;
  controls.MouseReleased();    //Send the mouseReleased event to the control manager
  released = false;
}




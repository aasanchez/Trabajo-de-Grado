/*
 Autor: Alexis Sanchez
 Pid
*/

int updatePid(int targetPosition, int currentPosition)   {
  int error = targetPosition - currentPosition; 
  pTerm = Kp * error;
  integrated_error += error;                                       
  iTerm = Ki * constrain(integrated_error, -GUARD_GAIN, GUARD_GAIN);
  dTerm = Kd * (error - last_error);
  return -constrain((K*(pTerm + iTerm + dTerm + Kp_Wheel + Kd_Wheel))+PwmTerm, -255, 255);
  //  return -constrain(K*(pTerm + iTerm + dTerm + pTerm_Wheel + dTerm_Wheel), -255, 255);  
}

#include <main.h>
#define BUZZER PIN_B3

long ret;
void alarma(){
   FOR (ret = 0;ret <= 250; ret++){
      output_low (BUZZER);
      delay_us (2000);
      output_high (BUZZER);
      delay_us (2000);
   }
}

void main(){
   WHILE (true){
      //FOR (i = 0; i <= 4; i++){
         alarma();
         delay_ms (1000);
      //}
   }
}


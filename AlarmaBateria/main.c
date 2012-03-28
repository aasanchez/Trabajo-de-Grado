#include <16F88.h>

#FUSES NOWDT                    //No Watch Dog Timer
#FUSES NOPUT                    //No Power Up Timer
#FUSES INTRC                    //Internal RC Osc
#FUSES NOMCLR                   //Master Clear pin used for I/O
#FUSES NOBROWNOUT               //No brownout reset
#FUSES NOLVP                    //No low voltage prgming, B3(PIC16) or B5(PIC18) used for I/O
#FUSES NOCPD                    //No EE protection
#FUSES NOWRT                    //Program memory not write protected
#FUSES NODEBUG                  //No Debug mode for ICD
#FUSES NOPROTECT                //Code not protected from reading
#FUSES FCMEN                    //Fail-safe clock monitor enabled
#FUSES IESO                     //Internal External Switch Over mode enabled

#use delay(int=8000000)

#define BUZZER PIN_B3
#define LED1 PIN_B0
#define LED2 PIN_B1
#define LED3 PIN_B2

long ret;
void alarma(){
   FOR (ret = 0;ret <= 250; ret++){
      output_low (BUZZER);
      delay_us (2000);
      output_high (BUZZER);
      delay_us (2000);
   }
}
void limpiar(){
   output_high(LED1);
   output_high(LED2);
   output_high(LED3);
}
void main(){
   limpiar();
   WHILE (true){
      output_low (LED1);
      delay_ms(1000);     
      output_low (LED2);
      delay_ms(1000);        
      output_low (LED3);
      delay_ms(1000);
      limpiar();
      delay_ms(1000);
   }
}


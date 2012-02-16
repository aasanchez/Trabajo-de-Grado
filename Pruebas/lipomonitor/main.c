#include <16F88.H> 
#device adc=8
#FUSES INTRC, NOWDT, NOLVP, NOCPD, NOWRT, NODEBUG, NOPROTECT, NOFCMEN, NOIESO 
#FUSES NOMCLR, NOBROWNOUT, CCPB3
#use delay(clock=8000000) 
#use fast_io(a) 
#use fast_io(b) 
#use rs232 (baud =9600,XMIT =PIN_b5,RCV =PIN_b2,BITS =8,PARITY =N) 
#byte porta=0x05 
#define CELDA1_PIN PIN_B0
#define CELDA2_PIN PIN_B1
#define CELDA3_PIN PIN_B4

   INT celda1;
   INT celda2;
   INT celda3;

void main(){
   porta = 0;
   set_tris_a (0xff);
   set_tris_b (0x00); //
   setup_adc_ports (ALL_ANALOG) ;
   setup_adc (adc_clock_div_8);
   
   setup_ccp1(ccp_pwm); 
   setup_timer_2(t2_div_by_1,124,1); 
   WHILE (1){
      // inicio bucle infinito
      set_adc_channel (0);
      delay_ms (10) ;
      celda1 = read_adc ();
      set_adc_channel (1);
      delay_ms (10) ;
      celda2 = read_adc ();
      set_adc_channel (2);
      delay_ms (10) ;
      celda3 = read_adc ();
      printf ("a --- > %03u %03u %03u\n\r", celda1, celda2, celda3);
      if (celda1 <= 168){
          output_low(CELDA1_PIN);
      }else{
          output_high(CELDA1_PIN);
      }
      if (celda2 <= 168){
          output_low(CELDA2_PIN);
      }else{
          output_high(CELDA2_PIN);
      }
      if (celda3 <= 168){
          output_low(CELDA3_PIN);
      }else{
          output_high(CELDA3_PIN);
          set_pwm1_duty(512);
      }
      delay_ms (1000);
   }
}
/*
Inserted into .h file:

#define LED PIN_B0
#define DELAY 1000


Inserted into .c file in main():


    //Example blinking LED program
    while(true){
      output_low(LED);
      delay_ms(DELAY);
      output_high(LED);
      delay_ms(DELAY);
    }
*/

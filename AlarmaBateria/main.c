#include <16F88.H> 
//#device adc=8
#FUSES INTRC, NOWDT, NOLVP, NOCPD, NOWRT, NODEBUG, NOPROTECT, NOFCMEN, NOIESO 
#FUSES NOMCLR, NOBROWNOUT, CCPB3
#use delay(clock=8000000) 
//#use fast_io(a) 
#use fast_io(b)
#byte porta=0x05 /*
#define CELDA1_LED PIN_B0
#define CELDA2_LED PIN_B1
#define CELDA3_LED PIN_B2

   INT celda1;
   INT celda2;
   INT celda3;*/

void main(){
   //porta = 0;
   //set_tris_a (0xff);
   set_tris_b (0x00); //
   //setup_adc_ports (ALL_ANALOG) ;
   //setup_adc (adc_clock_div_8);
   
   setup_ccp1(ccp_pwm); 
   setup_timer_2(t2_div_by_1,124,1); 
   set_pwm1_duty(0);
   WHILE (1){
      // inicio bucle infinito   
      /*set_adc_channel (0);
      delay_ms (10) ;
      celda1 = read_adc ();
      set_adc_channel (1);
      delay_ms (10) ;
      celda2 = read_adc ();
      set_adc_channel (2);
      delay_ms (10) ;
      celda3 = read_adc ();
      if (celda1 <= 168){
          output_low(CELDA1_LED);
      }else{
          output_high(CELDA1_LED);
      }
      if (celda2 <= 168){
          output_low(CELDA2_LED);
      }else{
          output_high(CELDA2_LED);
      }
      if (celda3 <= 168){
          output_low(CELDA3_LED);
          set_pwm1_duty(512);
      }else{
          output_high(CELDA3_LED);
          set_pwm1_duty(0);
      }
      if ((celda1 <= 168)||(celda2 <= 168)||(celda3 <= 168)){*/
          set_pwm1_duty(512);
      /*}else{
          set_pwm1_duty(0);
      }*/      
      delay_ms (10);
   }
}

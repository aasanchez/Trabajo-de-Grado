#include <16F88.H> 
#device adc=8
#FUSES INTRC, NOWDT, NOLVP, NOCPD, NOWRT, NODEBUG, NOPROTECT, NOFCMEN, NOIESO 
#FUSES NOMCLR, NOBROWNOUT, CCPB3
#use delay(clock=8000000) 
#use fast_io(a) 
#use fast_io(b) 
#use rs232 (baud =9600,XMIT =PIN_b5,RCV =PIN_b2,BITS =8,PARITY =N) 
#byte porta=0x05 

   INT celda1;
   INT celda2;
   INT celda3;

void main(){
   porta = 0;
   set_tris_a (0xff);
   set_tris_b (0x00); //
   setup_adc_ports (ALL_ANALOG) ;
   setup_adc (adc_clock_div_8);
   
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
      delay_ms (1000);
   }
}


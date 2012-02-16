#include <16F88.H> 
#device adc=8
#FUSES INTRC, NOWDT, NOLVP, NOCPD, NOWRT, NODEBUG, NOPROTECT, NOFCMEN, NOIESO 
#FUSES NOMCLR, NOBROWNOUT, CCPB3
#use delay(clock=8000000) 
#use fast_io(a) 
#use fast_io(b) 
#use rs232 (baud =9600,XMIT =PIN_b5,RCV =PIN_b2,BITS =8,PARITY =N) 
#byte porta=0x05 

int canal0=0; 
void main(){
   porta = 0;
   set_tris_a (0xff) ;
   set_tris_b (0x00); //
   setup_adc_ports (san0) ;
   setup_adc (adc_clock_div_8) ;
   set_adc_channel (0) ;

   WHILE (1){
      // inicio bucle infinito
      canal0 = read_adc () ;
      printf("a --->%03u\n\r",canal0);
      delay_ms(100) ;
   }
}


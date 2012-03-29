//*PURPOSE Monitor de Baterias Lipo de 3 Celdas
//*AUTHOR Alexis Sánchez
#include <16F88.h>
#device adc=8 
#FUSES NOWDT                    //No Watch Dog Timer
#FUSES NOPUT                    //No Power Up Timer
#FUSES INTRC                    //Internal RC Osc
#FUSES NOMCLR                   //Master Clear pin used FOR I/O
#FUSES NOBROWNOUT               //No brownout reset
#FUSES NOLVP                    //No low voltage prgming, B3(PIC16) or B5(PIC18) used FOR I/O
#FUSES NOCPD                    //No EE protection
#FUSES NOWRT                    //Program memory not write protected
#FUSES NODEBUG                  //No Debug mode FOR ICD
#FUSES NOPROTECT                //Code not protected from reading
#FUSES FCMEN                    //Fail-safe clock monitor enabled
#FUSES IESO                     //Internal External SWITCH Over mode enabled
#use delay(INT=8000000)
//#use rs232(baud=9600,PARITY=N,XMIT=PIN_b5,RCV=PIN_b2,BITS =8) 
#use fast_io(a)
#use fast_io(b)
#byte porta=0x05 
#use fast_io (B) 
#byte portb =0x06 

//Alias a Pines
#define BUZZER PIN_B4
#define LED1 PIN_B0
#define LED2 PIN_B1
#define LED3 PIN_B3

//Definimos Aleas a algunas funciones basicas
#define LED1ON output_low (LED1)
#define LED1OFF output_high (LED1)
#define LED2ON output_low (LED2)
#define LED2OFF output_high (LED2)
#define LED3ON output_low (LED3)
#define LED3OFF output_high (LED3)
#define BUZZEROFF output_low (BUZZER)
#define BUZZERON output_high (BUZZER)

//Variables
int i;
long ret;
int Bateria1;
int Bateria2;
int Bateria3;

//*Alarma sonora
void alarma(){
   FOR(ret=0;ret<=250;ret++){
      output_low(BUZZER);
      delay_us(2000);
      output_high(BUZZER);
      delay_us(2000);
   }
}

//*Apagar todod los led
void ALLOFF(){
   LED1OFF;
   LED2OFF;
   LED3OFF;
}

//*Encender todos los leds
void ALLON(){
   LED1ON;
   LED2ON;
   LED3ON;
}

//*Probar leds al encender
void iniciarleds(){
   INT tempo=100;
   FOR(i=0;i<=4;i++){
      ALLON();
      delay_ms(tempo);
      ALLOFF();
      delay_ms(tempo);
   }
}

void main(){
   //*Configurar Analog
   set_tris_a(0xff);
   set_tris_b(0x00);
   setup_adc_ports(ALL_ANALOG);
   setup_adc(adc_clock_div_8);
   ALLOFF();
   iniciarleds();

   WHILE(true){
      set_adc_channel(0);
      delay_ms(10);
      Bateria1=read_adc();

      IF(Bateria1<=211){
         LED1ON;
         }ELSE{
         LED1OFF;
      }

      set_adc_channel(1);
      delay_ms(10);
      Bateria2=read_adc();

      IF(Bateria2<=211){
         LED2ON;
         }ELSE{
         LED2OFF;
      }

      set_adc_channel(2);
      delay_ms(10);
      Bateria3=read_adc();

      IF(Bateria3<=211){
         LED3ON;
         }ELSE{
         LED3OFF;
      }
      
      IF((Bateria1<=197)||(Bateria2<=197)||(Bateria3<=197)){
         BUZZERON;
         }ELSE{
         BUZZEROFF;
      }
   }
}


#include <main.h>
#define LED PIN_B3
#define DELAY 250
void main(){
    while(true){
      output_low(LED);
      delay_us(DELAY);
      output_high(LED);
      delay_us(DELAY);
    }
}

#include <16F88.h>

#FUSES NOWDT                 	//No Watch Dog Timer
#FUSES NOPUT                 	//No Power Up Timer
#FUSES INTRC_IO              	//Internal RC Osc, no CLKOUT
#FUSES MCLR                  	//Master Clear pin enabled
#FUSES NOBROWNOUT            	//No brownout reset
#FUSES NOLVP                 	//No low voltage prgming, B3(PIC16) or B5(PIC18) used for I/O
#FUSES NOCPD                 	//No EE protection
#FUSES NOWRT                 	//Program memory not write protected
#FUSES NODEBUG               	//No Debug mode for ICD
#FUSES NOPROTECT             	//Code not protected from reading
#FUSES FCMEN                 	//Fail-safe clock monitor enabled
#FUSES IESO                  	//Internal External Switch Over mode enabled

#use delay(int=4000000)


/*
	Pruebas de Comunicación CDC usando Pinguino
	
*/
u16 n=0;

void setup(){
}

void loop(){
	CDC.printf("%u\n", n++);
	delay(100);
}
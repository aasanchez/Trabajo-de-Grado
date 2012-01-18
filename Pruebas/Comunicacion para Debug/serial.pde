u8 n=0;

void setup(){
}

void loop(){
	CDC.printf("%u\n", n++);
	delay(1000);
}
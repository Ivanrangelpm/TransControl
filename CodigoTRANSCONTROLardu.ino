// Definição da porta logica
int pinoSensor = 7;

//Inicialização do programa e do sensor
void setup() {
  pinMode(pinoSensor, INPUT);
  Serial.begin(9600);
}

//Inicialização do loop
void loop() {
  if(digitalRead(pinoSensor) == LOW){
  Serial.println(1);
  }
  else {
  Serial.println(0);
  }
//definição do delay em milisegundos, 1000ms = 1 segundo
  delay(1000);
}

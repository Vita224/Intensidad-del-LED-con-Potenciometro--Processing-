import processing.serial.*;
Serial MiSerial;
int Valor = 0;
int Xpos;
int Ypos;
int lastXpos;
int lastYpos;

void setup() {
  size (1300, 600);
  String NombrePuerto = Serial.list()[0]; //Puerto en el que se conecta Arduino
  MiSerial = new Serial(this, NombrePuerto, 9600);

  println(Serial.list()[0]);
  MiSerial.bufferUntil('\n');
  background (0);
  Xpos = width + 1;
}

void draw() {
  fill(255);
  textSize(20);
  line(100, 598, 100, 578); // Lineas de medida
  line(200, 598, 200, 578);
  line(300, 598, 300, 578);
  line(400, 598, 400, 578);
  line(500, 598, 500, 578);
  line(600, 598, 600, 578);
  line(700, 598, 700, 578);
  line(800, 598, 800, 578);
  line(900, 598, 900, 578);
  line(1000, 598, 1000, 578);
  line(1100, 598, 1100, 578);
  line(1200, 598, 1200, 578);

  line(5, 598, 1298, 598); // Lineas de medida
  line(5, 548, 1298, 548);
  line(5, 498, 1298, 498);
  line(5, 448, 1298, 448);
  line(5, 398, 1298, 398);
  line(5, 348, 1298, 348);
  line(5, 298, 1298, 298);
  line(5, 248, 1298, 248);
  line(5, 198, 1298, 198);
  line(5, 148, 1298, 148);
  line(5, 98, 1298, 98);
  line(5, 48, 1298, 48);

  stroke(255);
  line(2, 2, 2, 598);

  stroke(255);
  text("10", 10, 540); //Medidas
  text("20", 10, 490);
  text("30", 10, 440);
  text("40", 10, 390);
  text("50", 10, 340);
  text("60", 10, 290);
  text("70", 10, 240);
  text("80", 10, 190);
  text("90", 10, 140);
  text("100", 10, 90);
  text("110", 10, 40);

  text("1S", 110, 590); //Medidas
  text("2S", 210, 590);
  text("3S", 310, 590);
  text("4S", 410, 590);
  text("5S", 510, 590);
  text("6S", 610, 590);
  text("7S", 710, 590);
  text("8S", 810, 590);
  text("9S", 910, 590);
  text("10s", 1010, 590);
  text("11S", 1110, 590);

  if (MiSerial.available() > 0) {
    String Texto = MiSerial.readStringUntil('\n');
    if (Texto != null) {
      Valor = int(trim(Texto));
    }
    println(Valor);
  }
}

void serialEvent (Serial MiSerial) {
  String inString = MiSerial.readStringUntil('\n');

  if (inString != null) {
    inString = trim(inString);
    float inData = float (inString);
    inData = int(map(inData, 0, 1023, 0, height));
    Ypos= int(height-inData);

    if (Xpos > width) {
      Xpos = 0;
      lastXpos = Xpos;
      lastYpos = Ypos;
    }

    stroke(255);
    strokeWeight(4);
    line(lastXpos, lastYpos, Xpos, Ypos); //Grafica la intensidad del LED

    lastXpos = Xpos;
    lastYpos = Ypos;
    Xpos++;
  }
}

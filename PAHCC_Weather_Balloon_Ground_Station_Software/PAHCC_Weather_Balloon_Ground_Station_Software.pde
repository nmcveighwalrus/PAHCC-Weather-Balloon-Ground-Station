import processing.serial.*;
Serial myPort;
String val;
String time = "01:23:45";
String lat = "4401.19135N";
String lon = "07309.81563W";
String alt = "160M";
String temp = "22 °C";
String press = "99.734 kPa";

void setup(){
 //String portName = Serial.list()[0];
 //myPort = new Serial(this, portName, 115200);
 size(1920, 1080);
 background(0);
}

void draw()
{
  /*if ( myPort.available() > 0) 
  {  
  val = myPort.readStringUntil('\n');         
  } 
println(val);*/ 
  drawPack(1600,80);
}

void drawPack(int x, int y){
  noFill();
  strokeWeight(5);
  stroke(255);
  rect(x-10,y+10,280,250);
  fill(255);
  textSize(30);
  text("Packet", x, y);
  textSize(20);
  text("Time: "+ time, x, y+40);
  text("Latitude: "+ lat, x, y+80);
  text("Longitude: "+ lon, x, y+120);
  text("Altitude: "+ alt, x, y+160);
  text("Temperature: "+ temp, x, y+200);
  text("Pressure: "+ press, x, y+240);
}

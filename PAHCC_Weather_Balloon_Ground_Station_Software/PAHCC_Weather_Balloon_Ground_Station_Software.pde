import processing.serial.*;
Serial myPort;
String val;
String time = "01:23:45";
String lat = "72,100,34N";
String lon = "42,37,92W";
String alt = "164M";
String temp = "22 °C";
String press = "99.734 kPa";
int packXPos = 1600;
int packYPos = 80;
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
  noFill();
  strokeWeight(5);
  stroke(255);
  rect(packXPos-10,packYPos+10,250,250);
  
  fill(255);
  textSize(30);
  text("Packet", packXPos, packYPos);
  textSize(20);
  
  
  text("Time: "+ time, packXPos, packYPos+40);
  text("Latitude: "+ lat, packXPos, packYPos+80);
  text("Longitude: "+ lon, packXPos, packYPos+120);
  text("Altitude: "+ alt, packXPos, packYPos+160);
  text("Temperature: "+ temp, packXPos, packYPos+200);
  text("Pressure: "+ press, packXPos, packYPos+240);
}

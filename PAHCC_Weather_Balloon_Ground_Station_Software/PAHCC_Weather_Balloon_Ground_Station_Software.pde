import processing.serial.*;
Serial myPort;
String val;

void setup(){
 String portName = Serial.list()[0];
 myPort = new Serial(this, portName, 115200);
 //size(1920, 1080);
 //background(0);
}

void draw()
{
  if ( myPort.available() > 0) 
  {  
  val = myPort.readStringUntil('\n');         
  } 
println(val); 
}

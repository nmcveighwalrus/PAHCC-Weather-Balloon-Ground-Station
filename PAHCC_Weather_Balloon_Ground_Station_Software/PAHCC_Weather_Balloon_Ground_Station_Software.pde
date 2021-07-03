import processing.serial.*;
Serial myPort;
String val;
String time = "01:23:45";
String lat = "4401.19135N";
String lon = "07309.81563W";
String alt = "160M";
String temp = "22 °C";
String press = "99.734 kPa";
int hour = hour();
int min = minute();
int sec = second();
String zHour;
String zMin;
String zSec;
String stat = "Standby";
String tStamp = "00:00:00";
int butVal;
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
  
  background(0);
  getTime();
  drawTime(1600,40);
  drawPack(1600,130);
  drawStat(1600, 430);
  boolean armBut = button("Arm", 20, 1590, 500, 50, 30);
  boolean disarmBut = button("Disarm", 20, 1660, 500, 80, 30);
  int textInt = textEnt(1,1,1,1);
  if(armBut){
    stat = "Armed";
  }
  if(disarmBut){
    stat = "Standby";
  }
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


void getTime(){
  hour = hour();
  min = minute();
  sec = second();
  if(hour < 10){
    zHour = "0";
  }
  else{
    zHour = "";
  }
  if(min < 10){
    zMin = "0";
  }
  else{
    zMin = "";
  }
  if(sec < 10){
    zSec = "0";
  }
  else{
    zSec = "";
  }
  
  tStamp = zHour + hour + ":" + zMin + min + ":"+ zSec + sec;
}


void drawTime(int x, int y){
  noFill();
  strokeWeight(5);
  stroke(255);
  rect(x-10,y+10,280,40);
  fill(255);
  textSize(30);
  text("Time", x, y);
  textSize(20);
  text(tStamp, x, y + 40);
}

void drawStat(int x, int y){
  noFill();
  strokeWeight(5);
  stroke(255);
  rect(x-10,y+10,280,40);
  textSize(30);
  text("Status", x, y);
  if(stat == "Standby"){
   fill(255); 
  }
  else if(stat == "Armed"){
    fill(255, 170, 0);
  }
  else if(stat == "Triggered"){
    fill(255, 0, 0);
  }
  textSize(20);
  text(stat, x, y + 40);
}


boolean button(String name, int size, int x, int y, int w, int h){
 boolean pressed;
 noFill();
 strokeWeight(3);
 if(mousePressed && mouseButton == LEFT && x < mouseX && mouseX < x + w && y < mouseY && mouseY < y + h){
   stroke(170);
   pressed = true;
 }
 else{
   stroke(255);
   pressed = false;
 }
 textSize(size);
 rect(x, y, w, h);
 if(pressed){
   fill(170);
 }
 else{
   fill(255);
 }
 text(name, x + 5, y + 22);
 return pressed;
}


int textEnt(int x, int y, int w, int h){
  String display = "";
  String cursor = "";
  int entry = 12345;
  int state = 1;
  int blinkTime = millis();
  boolean blinkOn = true;
  if(blinkOn){
    cursor = "|";
  }
  else{
    cursor = "";
  }
  if (millis() - 500 > blinkTime) {
    blinkTime = millis();
    blinkOn = !blinkOn;
  }
  switch(state){
    case 0:
      display = "Enter Release Height Here";
      break;
    case 1:
      display = str(entry) + cursor; 
  }
  fill(255);
  textSize(20);
  text(display, 500, 500);
  text(millis(), 500, 550);
  return entry;
  
}

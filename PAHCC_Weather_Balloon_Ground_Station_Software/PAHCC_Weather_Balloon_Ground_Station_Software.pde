import processing.serial.*;
Serial myPort;
String val;
String time = "01:23:45";
String lat = "4401.19135N";
String lon = "07309.81563W";
String alt = "160M";
String temp = "22 °C";
String press = "99.734 kPa";
int hour;
int min;
int sec;
String zHour;
String zMin;
String zSec;
String stat = "Standby";
String tStamp = "00:00:00";
//int butVal;
drawTargAlt targAlt = new drawTargAlt(1600,570);
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
  drawTime(1600, 40);
  drawPack(1600, 130);
  drawStat(1600, 430);
  targAlt.update();
  
  
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
  boolean armBut = button("Arm", 20, x - 10, y + 70, 50, 30);
  boolean disarmBut = button("Disarm", 20, x + 60, y + 70, 80, 30);
  if(armBut){
    stat = "Armed";
  }
  if(disarmBut){
    stat = "Standby";
  }
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


class drawTargAlt{
  int x, y;
  String targAlt = "No target altitude set";
  boolean enterBut;
  boolean clearBut;
  boolean resetBut;
  drawTargAlt(int xPos, int yPos){
    x = xPos;
    y = yPos;
  }
  TextEnt trigAlt = new TextEnt("Enter Release Height", x, y + 50);
  
  void update(){
    enterBut = button("Enter", 20, x - 10, y + 110, 60, 30);
    clearBut = button("Clear", 20, x + 60, y + 110, 60, 30);
    resetBut = button("Reset", 20, x + 130, y + 110, 60, 30);
    if(trigAlt.update(0) == 0||trigAlt.update(1) == 0){
    targAlt = "No target altitude set";
    }
    if(enterBut){
     targAlt = str(trigAlt.update(0)); 
    }
    if(clearBut){
      trigAlt.update(0);
    }
    if(resetBut){
      trigAlt.update(0);
    }
    textSize(30);
    fill(255);
    text("Target Altitude", x, y);
    textSize(20);
    text(targAlt, x, y + 40);
    noFill();
    strokeWeight(5);
    rect(x - 10, y + 10, 280, 40);
  }
}


class TextEnt{
  String defMsg;
  int x, y;
  //boolean enterBut = button("Enter", 20, x - 10, y + 110, 60, 30);
  //boolean clearBut = button("Clear", 20, x + 60, y + 110, 60, 30);
  //boolean resetBut = button("Reset", 20, x + 130, y + 110, 60, 30);
  TextEnt(String msg, int xPos, int yPos){
    defMsg = msg;
    x = xPos;
    y = yPos;
    
  }
  String display = "";
  String cursor = "";
  int entry = 0;
  int state = 0;
  String entryStr = "";
  boolean latch = true;
  
  int update(int updState){
    state = updState;
    if(mousePressed && mouseButton == LEFT && x < mouseX && mouseX < x + 280 && y < mouseY && mouseY < y + 40){
    state = 1;
    }
    if(mousePressed && mouseButton == LEFT && x > mouseX || mousePressed && mouseButton == LEFT && mouseX > x + 280 
    || mousePressed && mouseButton == LEFT && y > mouseY || mousePressed && mouseButton == LEFT && mouseY > y + 40){
      state = 0;
    }
    if(millis()%1000 >= 500){
      cursor = "|";
    }
    else{
      cursor = "";
    }
    
    switch(state){
      case 0:
        display = defMsg;
        entryStr = "";
        break;
      case 1:
        if(keyPressed && latch){
         if(key == '0'){
           entryStr += "0";
         }
         if(key == '1'){
           entryStr += "1";
         }
         if(key == '2'){
           entryStr += "2";
         }
         if(key == '3'){
           entryStr += "3";
         }
         if(key == '4'){
           entryStr += "4";
         }
         if(key == '5'){
           entryStr += "5";
         }
         if(key == '6'){
           entryStr += "6";
         }
         if(key == '7'){
           entryStr += "7";
         }
         if(key == '8'){
           entryStr += "8";
         }
         if(key == '9'){
           entryStr += "9";
         }
        }
        latch = !keyPressed;
        entry = int(entryStr);
        if(entry == 0){
          display = cursor;
        }
        else{
          display = str(entry) + cursor; 
        }
  }
  noFill();
  stroke(255);
  strokeWeight(3);
  rect(x-10,y+10,280,40);
  fill(255);
  textSize(20);
  text(display, x, y + 40);
  return entry;
  }
}

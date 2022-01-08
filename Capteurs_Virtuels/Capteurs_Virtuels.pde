// This example sketch connects to the public shiftr.io instance and sends a message on every keystroke.
// After starting the sketch you can find the client here: https://www.shiftr.io/try.
//
// Note: If you're running the sketch via the Android Mode you need to set the INTERNET permission
// in Android > Sketch Permissions.
//
// by Joël Gähwiler
// https://github.com/256dpi/processing-mqtt

import mqtt.*;

MQTTClient ag1_Salon;
MQTTClient ag2_Cuisine;
MQTTClient ag4_Jardin;
MQTTClient ag5_Terasse;

void setup() {
  ag1_Salon = new MQTTClient(this);
  ag1_Salon.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "ag1-Salon");
  
  ag2_Cuisine = new MQTTClient(this);
  ag2_Cuisine.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "ag2-Cuisine");
  
  ag4_Jardin = new MQTTClient(this);
  ag4_Jardin.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "ag4-Jardin");
  
  ag5_Terasse = new MQTTClient(this);
  ag5_Terasse.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "ag5-Terasse");
}

void draw() {
  int temp1 = int(random(15,25));
  int temp2 = int(random(15,30));
  int temp3 = int(random(-10,30));
  int temp4 = int(random(-10,30));
  
  int humi1 = int(random(0,100));
  int humi2 = int(random(0,100));
  int humi3 = int(random(0,100));
  int humi4 = int(random(0,100));
  
  ag1_Salon.publish("/ag1-temp", str(temp1));
  ag1_Salon.publish("/ag1-humi", str(humi1));
  ag2_Cuisine.publish("/ag2-temp", str(temp2));
  ag2_Cuisine.publish("/ag2-humi", str(humi2));
  ag4_Jardin.publish("/ag4-temp", str(temp3));
  ag4_Jardin.publish("/ag4-humi", str(humi3));
  ag5_Terasse.publish("/ag5-temp", str(temp4));
  ag5_Terasse.publish("/ag5-humi", str(humi4));
  delay(2000);
}

void keyPressed() {
}

void clientConnected() {
  println("client connected");
  //ag1_Salon.subscribe("/ag1-temp");
  //ag1_Salon.subscribe("/ag1-humi");
  //ag2_Cuisine.subscribe("/ag2-temp");
  //ag2_Cuisine.subscribe("/ag2-humi");
  //ag4_Jardin.subscribe("/ag4-temp");
  //ag4_Jardin.subscribe("/ag4-humi");
  //ag5_Terasse.subscribe("/ag5-temp");
  //ag5_Terasse.subscribe("/ag5-humi");
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));
}

void connectionLost() {
  println("connection lost");
}

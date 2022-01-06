import mqtt.*;

MQTTClient moyenne;
float ag1_temp;
float ag2_temp;
float ag3_temp;
float ag4_temp;
float ag5_temp;
int limit;

float meanTempInt;
float meanTempExt;
Boolean flag=false;

ArrayList<Float> ag1_temp_list = new ArrayList<Float>();
ArrayList<Float> ag2_temp_list = new ArrayList<Float>();
ArrayList<Float> ag3_temp_list = new ArrayList<Float>();
ArrayList<Float> ag4_temp_list = new ArrayList<Float>();
ArrayList<Float> ag5_temp_list = new ArrayList<Float>();

ArrayList<Float> meanTempInt_list = new ArrayList<Float>();
ArrayList<Float> meanTempExt_list = new ArrayList<Float>();



void setup() {
  moyenne = new MQTTClient(this);
  moyenne.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "Slot-ag1234-Temperature");
  
  size(800, 1400);
}

void draw() {
  background(255);
  
  stroke(128);
  strokeWeight(1);
  line(0, 100, width, 100);
  line(0, 300, width, 300);
  line(0, 500, width, 500);
  line(0, 700, width, 700);
  line(0, 900, width, 900);
  line(0, 1100, width, 1100);
  line(0, 1300, width, 1300);

 
                         //Increments each frame
  if (limit > width) limit = 0;  
  
  strokeWeight(3);
  stroke(255, 0, 0);
  for(int i = 0; i< ag1_temp_list.size(); i++)
    {
    point(i,(-ag1_temp_list.get(i))*3 + 100);
    }
  for(int i = 0; i< ag2_temp_list.size(); i++)
    {
    point(i,(-ag2_temp_list.get(i))*3 + 300);
    }
  for(int i = 0; i< ag3_temp_list.size(); i++)
    {
    point(i,(-ag3_temp_list.get(i))*3 + 500);
    }
  for(int i = 0; i< ag4_temp_list.size(); i++)
    {
    point(i,(-ag4_temp_list.get(i))*3 + 700);
    }
  for(int i = 0; i< ag5_temp_list.size(); i++)
    {
    point(i,(-ag5_temp_list.get(i))*3 + 900);
    }
  stroke(0, 0, 255);
  for(int i = 0; i< meanTempInt_list.size(); i++)
    {
    point(i,(-meanTempInt_list.get(i))*3 + 1100);
    }
  for(int i = 0; i< meanTempExt_list.size(); i++)
    {
    point(i,(-meanTempExt_list.get(i))*3 + 1300);
    }
  
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(24);
  text(ag1_temp, limit+10, (-ag1_temp)*3 + 100);
  text(ag2_temp, limit+10, (-ag2_temp)*3 + 300);
  text(ag3_temp, limit+10, (-ag3_temp)*3 + 500);
  text(ag4_temp, limit+10, (-ag4_temp)*3 + 700);
  text(ag5_temp, limit+10, (-ag4_temp)*3 + 900);
  text(meanTempInt, limit+10, (-meanTempInt)*3 + 1100);
  text(meanTempExt, limit+10, (-meanTempExt)*3 + 1300);
  textSize(15);
  text("ag1_temp-Salon", width-130, 90);
  text("ag2_temp-Cuisine", width-150, 290);
  text("ag3_temp-Chambre(réelle)", width-200, 490);
  text("ag4_temp-Jardin", width-150, 690);
  text("ag5_temp-Terasse", width-150, 890);
  text("Moyenne temperature Interieur", width-240, 1090);
  text("Moyenne temperature Exterieur", width-240, 1290);
  
  float sumag1 = 0;
  float sumag2 = 0;
  float sumag3 = 0;
  float sumag4 = 0;
  float sumag5 = 0;
  
  for (float f : ag1_temp_list) // foreach kind of loop, with automatic unboxing
  {
    sumag1 += f;
  }
  sumag1=sumag1/ag1_temp_list.size();
    for (float f : ag2_temp_list) // foreach kind of loop, with automatic unboxing
  {
    sumag2 += f;
  }
  sumag2=sumag2/ag2_temp_list.size();
    for (float f : ag3_temp_list) // foreach kind of loop, with automatic unboxing
  {
    sumag3 += f;
  }
  sumag3=sumag3/ag3_temp_list.size();
  for (float f : ag4_temp_list) // foreach kind of loop, with automatic unboxing
  {
    sumag4 += f;
  }
  sumag4=sumag4/ag4_temp_list.size();
  for (float f : ag5_temp_list) // foreach kind of loop, with automatic unboxing
  {
    sumag5 += f;
  }
  sumag5=sumag5/ag5_temp_list.size();
  meanTempInt=(sumag1+sumag2+sumag3)/3;  
  meanTempExt=(sumag4+sumag5)/2;
  if (flag){
    meanTempInt_list.add(meanTempInt);
    moyenne.publish("slot-ag12345-moyenneTempInt",str(meanTempInt));
    meanTempExt_list.add(meanTempExt);
    moyenne.publish("slot-ag12345-moyenneTempExt",str(meanTempExt));
    flag=false;
  }

}

void clientConnected() {
  println("client connected");
  moyenne.subscribe("/ag1-temp");
  moyenne.subscribe("/ag2-temp");
  moyenne.subscribe("/ag3-temp");
  moyenne.subscribe("/ag4-temp");
  moyenne.subscribe("/ag5-temp");
}

float get4bytesFloat(byte[] data, int offset) {
  String hexint=hex(data[offset+3])+hex(data[offset+2])+hex(data[offset+1])+hex(data[offset]);
  return Float.intBitsToFloat(unhex(hexint));
}

void messageReceived(String topic, byte[] payload) {
  //println("moyenne: " + topic + " - " + new String(payload));
  if(topic.equals("/ag1-temp")){
    ag1_temp = float(new String(payload));
    ag1_temp_list.add(ag1_temp);
  }
  if(topic.equals("/ag2-temp")){ 
    ag2_temp = float(new String(payload));
    ag2_temp_list.add(ag2_temp);
  }
  if(topic.equals("/ag3-temp")){
    ag3_temp = float(new String(payload));
    ag3_temp_list.add(ag3_temp);
  }
  if(topic.equals("/ag4-temp")){
    limit++; 
    ag4_temp = float(new String(payload));
    ag4_temp_list.add(ag4_temp);
    flag=true;
  }
  if(topic.equals("/ag5-temp")){
    ag5_temp = float(new String(payload));
    ag5_temp_list.add(ag5_temp);
  }
  
}

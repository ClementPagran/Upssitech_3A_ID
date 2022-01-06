import mqtt.*;

MQTTClient moyenne;
float ag1_humi;
float ag2_humi;
float ag3_humi;
float ag4_humi;
float ag5_humi;
int limit;

float meanhumiInt;
float meanhumiExt;
Boolean flag=false;

ArrayList<Float> ag1_humi_list = new ArrayList<Float>();
ArrayList<Float> ag2_humi_list = new ArrayList<Float>();
ArrayList<Float> ag3_humi_list = new ArrayList<Float>();
ArrayList<Float> ag4_humi_list = new ArrayList<Float>();
ArrayList<Float> ag5_humi_list = new ArrayList<Float>();

ArrayList<Float> meanhumiInt_list = new ArrayList<Float>();
ArrayList<Float> meanhumiExt_list = new ArrayList<Float>();



void setup() {
  moyenne = new MQTTClient(this);
  moyenne.connect("mqtt://id-ups:18gGuosBo0q8HqJK@id-ups.cloud.shiftr.io", "Slot-ag1234-Humidité");
  
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
  for(int i = 0; i< ag1_humi_list.size(); i++)
    {
    point(i,(-ag1_humi_list.get(i)) + 100);
    }
  for(int i = 0; i< ag2_humi_list.size(); i++)
    {
    point(i,(-ag2_humi_list.get(i)) + 300);
    }
  for(int i = 0; i< ag3_humi_list.size(); i++)
    {
    point(i,(-ag3_humi_list.get(i)) + 500);
    }
  for(int i = 0; i< ag4_humi_list.size(); i++)
    {
    point(i,(-ag4_humi_list.get(i)) + 700);
    }
  for(int i = 0; i< ag5_humi_list.size(); i++)
    {
    point(i,(-ag5_humi_list.get(i)) + 900);
    }
  stroke(0, 0, 255);
  for(int i = 0; i< meanhumiInt_list.size(); i++)
    {
    point(i,(-meanhumiInt_list.get(i)) + 1100);
    }
  for(int i = 0; i< meanhumiExt_list.size(); i++)
    {
    point(i,(-meanhumiExt_list.get(i)) + 1300);
    }
  
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(24);
  text(ag1_humi, limit+10, (-ag1_humi) + 100);
  text(ag2_humi, limit+10, (-ag2_humi) + 300);
  text(ag3_humi, limit+10, (-ag3_humi) + 500);
  text(ag4_humi, limit+10, (-ag4_humi) + 700);
  text(ag5_humi, limit+10, (-ag4_humi) + 900);
  text(meanhumiInt, limit+10, (-meanhumiInt) + 1100);
  text(meanhumiExt, limit+10, (-meanhumiExt) + 1300);
  textSize(15);
  text("ag1_humi-Salon", width-130, 90);
  text("ag2_humi-Cuisine", width-150, 290);
  text("ag3_humi-Chambre(réelle)", width-200, 490);
  text("ag4_humi-Jardin", width-150, 690);
  text("ag5_humi-Terasse", width-150, 890);
  text("Moyenne humierature Interieur", width-240, 1090);
  text("Moyenne humierature Exterieur", width-240, 1290);
  
  float sumag1 = 0;
  float sumag2 = 0;
  float sumag3 = 0;
  float sumag4 = 0;
  float sumag5 = 0;
  
  for (float f : ag1_humi_list) // foreach kind of loop, with automatic unboxing
  {
    sumag1 += f;
  }
  sumag1=sumag1/ag1_humi_list.size();
    for (float f : ag2_humi_list) // foreach kind of loop, with automatic unboxing
  {
    sumag2 += f;
  }
  sumag2=sumag2/ag2_humi_list.size();
    for (float f : ag3_humi_list) // foreach kind of loop, with automatic unboxing
  {
    sumag3 += f;
  }
  sumag3=sumag3/ag3_humi_list.size();
  for (float f : ag4_humi_list) // foreach kind of loop, with automatic unboxing
  {
    sumag4 += f;
  }
  sumag4=sumag4/ag4_humi_list.size();
  for (float f : ag5_humi_list) // foreach kind of loop, with automatic unboxing
  {
    sumag5 += f;
  }
  sumag5=sumag5/ag5_humi_list.size();
  meanhumiInt=(sumag1+sumag2+sumag3)/3;  
  meanhumiExt=(sumag4+sumag5)/2;
  if (flag){
    meanhumiInt_list.add(meanhumiInt);
    moyenne.publish("slot-ag12345-moyenneHumiInt",str(meanhumiInt));
    meanhumiExt_list.add(meanhumiExt);
    moyenne.publish("slot-ag12345-moyenneHumiExt",str(meanhumiExt));
    flag=false;
  }

}

void clientConnected() {
  println("client connected");
  moyenne.subscribe("/ag1-humi");
  moyenne.subscribe("/ag2-humi");
  moyenne.subscribe("/ag3-humi");
  moyenne.subscribe("/ag4-humi");
  moyenne.subscribe("/ag5-humi");
}

float get4bytesFloat(byte[] data, int offset) {
  String hexint=hex(data[offset+3])+hex(data[offset+2])+hex(data[offset+1])+hex(data[offset]);
  return Float.intBitsToFloat(unhex(hexint));
}

void messageReceived(String topic, byte[] payload) {
  //println("moyenne: " + topic + " - " + new String(payload));
  if(topic.equals("/ag1-humi")){
    ag1_humi = float(new String(payload));
    ag1_humi_list.add(ag1_humi);
  }
  if(topic.equals("/ag2-humi")){ 
    ag2_humi = float(new String(payload));
    ag2_humi_list.add(ag2_humi);
  }
  if(topic.equals("/ag3-humi")){
    ag3_humi = float(new String(payload));
    ag3_humi_list.add(ag3_humi);
  }
  if(topic.equals("/ag4-humi")){
    limit++; 
    ag4_humi = float(new String(payload));
    ag4_humi_list.add(ag4_humi);
    flag=true;
  }
  if(topic.equals("/ag5-humi")){
    ag5_humi = float(new String(payload));
    ag5_humi_list.add(ag5_humi);
  }
  
}

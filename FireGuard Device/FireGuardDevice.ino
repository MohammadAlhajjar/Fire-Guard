#include <Arduino.h>
#include "GasSensor.h"
#include "SleepManager.h"
#include "dht_sensor.h"
#include <painlessMesh.h>
#include <Arduino_JSON.h>

// Mesh network parameters
#define   MESH_PREFIX     "whateverYouLike"
#define   MESH_PASSWORD   "somethingSneaky"
#define   MESH_PORT       5555




//Number for this node
int nodeNumber = 2;


//String to send to other nodes with sensor readings
String readings;
String getReadings(); // Prototype for sending sensor readings


Scheduler userScheduler; // to control your personal task
painlessMesh mesh;

// User stub
void sendMessage() ; // Prototype so PlatformIO doesn't complain


Task taskSendMessage( TASK_SECOND * 4 , TASK_FOREVER, &sendMessage );

// Create a GasSensor instance for the MQ-9 sensor on pin 34
GasSensor gasSensor;

DhtSensor dhtSensor(32, DHT11);
// Create a SleepManager instance
SleepManager sleepManager;



const int readDuration = 10000; // Duration to read sensor values in milliseconds
const int sleepDuration = 20; // Duration to sleep in minutes



String getReadings () {
 // JSONVar jsonReadings;
  double temp,hum,gas;
  if (dhtSensor.readValues()) {
   temp =  dhtSensor.getTemperature();
   hum = dhtSensor.getHumidity();
  }
  else {
    Serial.println("Failed to read from DHT sensor!");
  }
   if (gasSensor.readValues()) {
   gas =gasSensor.getCOConcentration();
   }


    // Create JSON object
    StaticJsonDocument<200> doc;
    doc["status"] =  "Normal";
    doc["valueHeat"] = temp;
    doc["valueMoisture"] =  hum;
    doc["valueGas"] =gas;
    doc["date"] = "04/04/2024 04:44:44"; 
    doc["device"] = "1";
    
    // Convert JSON object to string
    String jsonData;
    serializeJson(doc, jsonData);

  
 
  return jsonData;
}

void sendMessage() {
  String msg = getReadings();
  Serial.println(msg);
 
  mesh.sendBroadcast(msg);
  //taskSendMessage.setInterval( random( TASK_SECOND * 1, TASK_SECOND * 5 ));
  
}


// Needed for painless library
void receivedCallback( uint32_t from, String &msg ) {
  Serial.printf("Received from %u msg=%s\n", from, msg.c_str());
  JSONVar myObject = JSON.parse(msg.c_str());
  int node = myObject["node"];
  double temp = myObject["Temp"];
  double hum = myObject["Hum"];
  double gas = myObject["co"];
  Serial.print("Node: ");
  Serial.println(node);
  Serial.print("Temperature: ");
  Serial.print(dhtSensor.getTemperature());
  Serial.println(" C");
  Serial.print("Humidity: ");
  Serial.print( dhtSensor.getHumidity());
  Serial.println(" %");
  Serial.print("co gas: ");
  Serial.print(gasSensor.getCOConcentration());
  Serial.println(" ppm");
}

void newConnectionCallback(uint32_t nodeId) {
    Serial.printf("--> startHere: New Connection, nodeId = %u\n", nodeId);
}

void changedConnectionCallback() {
  Serial.printf("Changed connections\n");
}

void nodeTimeAdjustedCallback(int32_t offset) {
    Serial.printf("Adjusted time %u. Offset = %d\n", mesh.getNodeTime(),offset);
}


void setup() {
  Serial.begin(115200);
  // Additional setup code

   // Initialize the mesh
  
  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);

    
  userScheduler.addTask( taskSendMessage );
  taskSendMessage.enable();

  
}

void loop() {

mesh.update();
 
}

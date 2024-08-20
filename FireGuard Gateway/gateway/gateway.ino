#include <Arduino.h>
#include <painlessMesh.h>
#include <Arduino_JSON.h>
#include "HttpClient.h"
#include "WiFiManager.h"
#include "FireDetection.h"



// Replace with your network credentials
const char* ssid = "Izzat";
const char* password = "12345678";

// Replace with your server URL
const char* serverUrl = "http://firegard.cupcoding.com/backend/public/api/esp32/device-values";


#define   MESH_PREFIX     "whateverYouLike"
#define   MESH_PASSWORD   "somethingSneaky"
#define   MESH_PORT       5555

Scheduler userScheduler; // to control your personal task
painlessMesh mesh;


HttpClient httpClient(serverUrl);
WiFiManager wifiManager(ssid, password);

// Fire detection thresholds
FireDetection fireDetection(50.0, 20.0, 10.0);


// Needed for painless library
void receivedCallback( uint32_t from, String &msg ) {
  Serial.printf("Received from %u msg=%s\n", from, msg.c_str());
  
   // Connect to WiFi
    wifiManager.connect();

  // Parse the received message to extract sensor data
    float temperature = 0.0;
    float humidity = 0.0;
    float coConcentration = 0.0;

    // Assuming msg is JSON formatted
    JSONVar myObject = JSON.parse(msg.c_str());
    if (JSON.typeof(myObject) == "undefined") {
        Serial.println("Parsing input failed!");
        return;
    }

    // Extract values from JSON
    temperature = (double)myObject["valueHeat"];
    humidity = (double)myObject["valueMoisture"];
    coConcentration = (double)myObject["valueGas"];

    // Fire detection logic
    if (fireDetection.isFireDetected(temperature, humidity, coConcentration)) {
        Serial.println("Fire detected!");
    // Prepare JSON payload for server
    // Create JSON object
    StaticJsonDocument<200> doc;
    doc["status"] =  "Dangerous";
    doc["valueHeat"] = temperature;
    doc["valueMoisture"] =  humidity;
    doc["valueGas"] =coConcentration;
    doc["date"] = "04/04/2024 04:44:44"; 
    doc["device"] = "1";
    
    // Convert JSON object to string
    String jsonPayload;
    serializeJson(doc, jsonPayload);

        // Send the JSON data to the server
        if (wifiManager.isConnected()) {
            httpClient.sendData(jsonPayload);
        } else {
            Serial.println("WiFi not connected, can't send data!");
        }
    } else {
        Serial.println("No fire detected.");
    }
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
   Serial.println("Receiver node setup");
 

  // Initialize the mesh
  mesh.setDebugMsgTypes(ERROR | STARTUP );  // Set debug message types
  
  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);
}

void loop() {
  mesh.update();
}

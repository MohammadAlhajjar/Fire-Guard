#include "dht_sensor.h"

DhtSensor::DhtSensor(int pin, int type) : dht_(pin, type), temperature_(0), humidity_(0) {
  dht_.begin();
}

bool DhtSensor::readValues() {
  temperature_ = dht_.readTemperature();
  humidity_ = dht_.readHumidity();
  return true;
  
}

float DhtSensor::getTemperature() {
  return temperature_;
}

float DhtSensor::getHumidity() {
  return humidity_;
}

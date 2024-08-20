#ifndef DHT_SENSOR_H
#define DHT_SENSOR_H

#include <DHT.h>

class DhtSensor {
public:
  DhtSensor(int pin, int type);
  bool readValues();
  float getTemperature();
  float getHumidity();
private:
  DHT dht_;
  float temperature_;
  float humidity_;
};

#endif

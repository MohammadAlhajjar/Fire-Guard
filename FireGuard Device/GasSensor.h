#ifndef GAS_SENSOR_H
#define GAS_SENSOR_H

#include <MQUnifiedsensor.h>

class GasSensor {
public:
  GasSensor();


  bool readValues();
  float getCOConcentration();

private:
  MQUnifiedsensor mq9_;
  float co_concentration_;
};

#endif

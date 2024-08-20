#ifndef FIRE_DETECTION_H
#define FIRE_DETECTION_H

class FireDetection {
public:
    FireDetection(float tempThreshold, float humidityThreshold, float coThreshold);
    bool isFireDetected(float temperature, float humidity, float coConcentration);

private:
    float tempThreshold;
    float humidityThreshold;
    float coThreshold;
};

#endif

#include "FireDetection.h"

FireDetection::FireDetection(float tempThreshold, float humidityThreshold, float coThreshold)
    : tempThreshold(tempThreshold), humidityThreshold(humidityThreshold), coThreshold(coThreshold) {}

bool FireDetection::isFireDetected(float temperature, float humidity, float coConcentration) {
    if (temperature > tempThreshold && humidity < humidityThreshold && coConcentration > coThreshold) {
        return true;
    }
    return false;
}

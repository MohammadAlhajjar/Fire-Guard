#include "SleepManager.h"
#include <esp_sleep.h>

SleepManager::SleepManager() {
  // Constructor can be used to initialize any specific settings if needed
}

void SleepManager::sleepForMinutes(int minutes) {
  // Calculate sleep time in microseconds
  uint64_t sleepTimeUs = minutes * 60 * 1000000;
  // Configure the ESP32 to wake up after the specified time
  esp_sleep_enable_timer_wakeup(sleepTimeUs);
  // Go to deep sleep
  esp_deep_sleep_start();
}

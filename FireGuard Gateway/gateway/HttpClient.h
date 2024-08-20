#ifndef HTTP_CLIENT_H
#define HTTP_CLIENT_H

#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

class HttpClient {
public:
    HttpClient(const char* serverUrl);
    void sendData(const String jsonPayload);

private:
    const char* serverUrl;
};

#endif

#include "Arduino.h"
#include "BLE.h"

#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

#include "tft.h"

BLECharacteristic *txC;
BLEService *pService;
BLEServer *pServer;
bool deviceConnected = false;
char BLEbuf[32] = {0};
uint32_t cnt = 0;

#define SERVICE_UUID "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

const char *command1 = "a1:";
const char *command2 = "a2:";
const char *command3 = "a3:";
const char *command4 = "a4:";
const char *command5 = "a5:";

bool BLEsend = false;

void go();

class MyServerCallbacks : public BLEServerCallbacks
{
    void onConnect(BLEServer *pServer)
    {
        pServer->getAdvertising()->stop();
        Serial.println("deviceConnected");
        deviceConnected = true;
    };

    void onDisconnect(BLEServer *pServer)
    {
        Serial.println("deviceDisconnected");
        deviceConnected = false;
        pServer->getAdvertising()->start();
    }
};

class MyCallbacks : public BLECharacteristicCallbacks
{
    void onWrite(BLECharacteristic *pCharacteristic)
    {
        std::string rxValue = pCharacteristic->getValue();

        if (rxValue.length() > 0)
        {
            Serial.printf("Received Value: %s\n", rxValue.c_str());
        }
    }
};

void testtask(void *arg)
{
    for (;;)
    {
        if (deviceConnected)
            BLEsend = true;
        delay(2000);
    }
}

void setupBLE()
{
    // Create the BLE Device
    BLEDevice::init("角度测试仪");

    // Create the BLE Server
    pServer = BLEDevice::createServer();
    pServer->setCallbacks(new MyServerCallbacks());

    // Create the BLE Service
    pService = pServer->createService(SERVICE_UUID);

    // Create a BLE Characteristic
    txC = pService->createCharacteristic(CHARACTERISTIC_UUID_TX, BLECharacteristic::PROPERTY_NOTIFY);
    txC->addDescriptor(new BLE2902());

    BLECharacteristic *rxC = pService->createCharacteristic(CHARACTERISTIC_UUID_RX, BLECharacteristic::PROPERTY_WRITE);
    rxC->setCallbacks(new MyCallbacks());

    // Start the service
    pService->start();

    // Start advertising
    pServer->getAdvertising()->start();
    Serial.println("Waiting a client connection to notify...");

    xTaskCreate(testtask, "testtask", 8192, NULL, 3, NULL);
}

void go()
{
    float res = (float)random(36000) / 10;
    show(1, res);
    String temp1 = command1 + String(res, 2);
    txC->setValue(temp1.c_str());
    txC->notify();

    res = (float)random(36000) / 10;
    show(2, res);
    temp1 = command2 + String(res, 2);
    txC->setValue(temp1.c_str());
    txC->notify();

    res = (float)random(36000) / 10;
    show(3, res);
    temp1 = command3 + String(res, 2);
    txC->setValue(temp1.c_str());
    txC->notify();

    res = (float)random(36000) / 10;
    show(4, res);
    temp1 = command4 + String(res, 2);
    txC->setValue(temp1.c_str());
    txC->notify();

    res = (float)random(36000) / 10;
    show(5, res);
    temp1 = command5 + String(res, 2);
    txC->setValue(temp1.c_str());
    txC->notify();
}

void loopBLE()
{
    if (BLEsend)
    {
        Serial.println("send");
        go();
        BLEsend = false;
    }
}
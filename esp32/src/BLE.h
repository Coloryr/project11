#ifndef BLE_H
#define BLE_H
#include "Arduino.h"
#include <BLEDevice.h> // 引入相关库

void setupBLE();
void loopBLE();

extern bool BLEsend;

#endif 

#ifndef BLE_H
#define BLE_H
#include "Arduino.h"
#include <BLEDevice.h> // 引入相关库

void setupBLE();

extern bool BLEsend;
extern float a1, a2, a3, a4, a5, a6;

#endif 


#include <Arduino.h>
#include "test.h"
#include "BLE.h"

void setup()
{
    Serial.begin(115200);

    setup_lcd();
    setupBLE();
}

void loop()
{
    loopBLE();
    loop_lcd();
}
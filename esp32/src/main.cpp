
#include <Arduino.h>
#include "test.h"

void setup()
{
    Serial.begin(115200);

    setup_lcd();
}

void loop()
{
    loop_lcd();
}
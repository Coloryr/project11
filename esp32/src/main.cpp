
#include <Arduino.h>
#include <BluetoothSerial.h>
#include <spi.h>
#include <TFT_eSPI.h>                 // Include the graphics library (this includes the sprite functions)
#include <User_Setup.h>    
#include <Adafruit_ADS1X15.h>
// #define TFT_eSPI tft
TFT_eSPI tft=TFT_eSPI();

BluetoothSerial SerialBT;

void setup()
{
    Serial.begin(115200);
    // TFT_eSPI.init(); //初始化
    tft.init(); //初始化
    SerialBT.begin("421"); // 如果没有参数传入则默认是蓝牙名称是: "ESP32"
    SerialBT.setPin("1234");   // 蓝牙连接的配对码
    // Serial.printf("BT initial ok and ready to pair. \r\n");
    tft.fillScreen(TFT_BLACK);
    tft.setTextColor(TFT_BLUE);
    tft.setCursor(10,10,4);
    tft.println("");
    tft.setTextColor(TFT_BLUE);
    tft.setCursor(10,60,4);
    tft.setTextSize(1);
    tft.println("角度1：");


}

void loop()
{
    // tft.print("Hello World!");
    // if (Serial.available())
    // {
    //     SerialBT.write(Serial.read());
  tft.setCursor(10,80,4);
  Serial.println("Getting differential reading from AIN0 (P) and AIN1 (N)");
  Serial.println("ADC Range: +/- 6.144V (1 bit = 3mV/ADS1015, 0.1875mV/ADS1115)");
  tft.setCursor(10,80,4);
//    tft.println("角度1：");
    // }
    // if (SerialBT.available())
    // {
    //     Serial.write(SerialBT.read());
    // }
    // delay(1);
}
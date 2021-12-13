
#include <Arduino.h>
#include "tft.h"
#include "BLE.h"
#include "lvgl.h"

#define LV_TICK_PERIOD_MS 1

uint8_t a1,a2,a3,a4,a5;
SemaphoreHandle_t xGuiSemaphore;

static void lv_tick_task(void *arg)
{
    lv_tick_inc(LV_TICK_PERIOD_MS);
}

const esp_timer_create_args_t periodic_timer_args = {
    .callback = &lv_tick_task,
    .arg = NULL,
    .dispatch_method = ESP_TIMER_TASK,
    .name = "periodic_gui"};

void setup()
{
    Serial.begin(115200);
    xGuiSemaphore = xSemaphoreCreateMutex();

    esp_timer_handle_t periodic_timer;
    esp_timer_create(&periodic_timer_args, &periodic_timer);
    esp_timer_start_periodic(periodic_timer, LV_TICK_PERIOD_MS * 1000);

    drvice_init();
    show_init();

    setupBLE();
}

void loop()
{

    // a1=3000*analogRead(0)/4096/360;
    // a2=3000*analogRead(13)/4096/360;
    // a3=3000*analogRead(35)/4096/360;
    // tft.setCursor(10,10,2);
    // Serial.println("Range1:5000*(a1/4096/360");
    // tft.setCursor(10,25,2);
    // Serial.println("Range2:5000*(a2/4096)/360");
    // Serial.println(a2);
    // tft.setCursor(10,50,2);
    // Serial.println("Range3:5000*(a3/4096)/360");
    // Serial.println(a3);
    // delay(500);
    /* Try to take the semaphore, call lvgl related function on success */
    if (pdTRUE == xSemaphoreTake(xGuiSemaphore, portMAX_DELAY))
    {
        lv_task_handler();
        xSemaphoreGive(xGuiSemaphore);
    }
}
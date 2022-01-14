
#include <Arduino.h>
#include "tft.h"
#include "BLE.h"
#include "lvgl.h"

#define LV_TICK_PERIOD_MS 1

SemaphoreHandle_t xGuiSemaphore;

#define ADC1 22
#define ADC2 34
#define ADC3 32
#define ADC4 13
#define ADC5 12
#define ADC6 14

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



    // setupBLE();
}

void loop()
{
    /* Try to take the semaphore, call lvgl related function on success */
    if (pdTRUE == xSemaphoreTake(xGuiSemaphore, portMAX_DELAY))
    {
        lv_task_handler();
        xSemaphoreGive(xGuiSemaphore);
    }
}
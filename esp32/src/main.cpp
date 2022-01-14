
#include <Arduino.h>
#include "tft.h"
#include "BLE.h"
#include "lvgl.h"

#define LV_TICK_PERIOD_MS 1

SemaphoreHandle_t xGuiSemaphore;

#define ADC1 35
#define ADC2 34
#define ADC3 32
#define ADC4 13
#define ADC5 12
#define ADC6 14

float a1 = 0.0f, a2 = 0.0f, a3 = 0.0f, a4 = 0.0f, a5 = 0.0f, a6 = 0.0f;

static void lv_tick_task(void *arg)
{
    lv_tick_inc(LV_TICK_PERIOD_MS);
}

const esp_timer_create_args_t periodic_timer_args = {
    .callback = &lv_tick_task,
    .arg = NULL,
    .dispatch_method = ESP_TIMER_TASK,
    .name = "periodic_gui"};

void task_adc(void *arg)
{
    for (;;)
    {
        delay(50);
        a1 = (float)analogRead(ADC1) * 3300 / (4096 * 360);
        show(1, a1);
        delay(50);
        a2 = (float)analogRead(ADC2) * 3300 / (4096 * 360);
        show(2, a2);
        delay(50);
        a3 = (float)analogRead(ADC3) * 3300 / (4096 * 360);
        show(3, a3);
        delay(50);
        a4 = (float)analogRead(ADC4) * 3300 / (4096 * 360);
        show(4, a4);
        delay(50);
        a5 = (float)analogRead(ADC5) * 3300 / (4096 * 360);
        show(5, a5);
        delay(50);
        a6 = (float)analogRead(ADC6) * 3300 / (4096 * 360);
        show(6, a6);
    }
}

void setup()
{
    Serial.begin(115200);
    xGuiSemaphore = xSemaphoreCreateMutex();

    esp_timer_handle_t periodic_timer;
    esp_timer_create(&periodic_timer_args, &periodic_timer);
    esp_timer_start_periodic(periodic_timer, LV_TICK_PERIOD_MS * 1000);

    drvice_init();
    show_init();

    pinMode(ADC1, ANALOG);
    pinMode(ADC2, ANALOG);
    pinMode(ADC3, ANALOG);
    pinMode(ADC4, ANALOG);
    pinMode(ADC5, ANALOG);
    pinMode(ADC6, ANALOG);

    setupBLE();

    xTaskCreate(task_adc, "task_adc", 4096, NULL, 3, NULL);
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
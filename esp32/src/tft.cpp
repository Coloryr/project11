#include "Arduino.h"
#include "lvgl.h"
#include "tft.h"
#include <User_Setup.h>
#include <TFT_eSPI.h> // Graphics and font library for ST7735 driver chip

lv_obj_t *t1;
lv_obj_t *t2;
lv_obj_t *t3;
lv_obj_t *t4;
lv_obj_t *t5;
lv_obj_t *t6;

/*Change to your screen resolution*/
static const uint16_t screenWidth = 130;
static const uint16_t screenHeight = 162;

static lv_disp_draw_buf_t draw_buf;
static lv_color_t buf[screenWidth * 10];

TFT_eSPI tft = TFT_eSPI(screenWidth, screenHeight); /* TFT instance */

/* Display flushing */
void my_disp_flush(lv_disp_drv_t *disp, const lv_area_t *area, lv_color_t *color_p)
{
    uint32_t w = (area->x2 - area->x1 + 1);
    uint32_t h = (area->y2 - area->y1 + 1);

    tft.startWrite();
    tft.setAddrWindow(area->x1, area->y1, w, h);
    tft.pushColors((uint16_t *)&color_p->full, w * h, true);
    tft.endWrite();

    lv_disp_flush_ready(disp);
}

void drvice_init()
{
    lv_init();

    tft.begin(); /* TFT init */

    lv_disp_draw_buf_init(&draw_buf, buf, NULL, screenWidth * 10);

    /*Initialize the display*/
    static lv_disp_drv_t disp_drv;
    lv_disp_drv_init(&disp_drv);
    /*Change the following line to your display resolution*/
    disp_drv.hor_res = screenWidth;
    disp_drv.ver_res = screenHeight;
    disp_drv.flush_cb = my_disp_flush;
    disp_drv.draw_buf = &draw_buf;
    lv_disp_drv_register(&disp_drv);
}

void show_init()
{

    lv_obj_t *label1 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label1, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Break the long lines*/
    lv_label_set_text(label1, "a1:");
    lv_obj_set_width(label1, 120);
    lv_obj_align(label1, LV_ALIGN_TOP_LEFT, 2, 0);

    lv_obj_t *label2 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label2, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Circular scroll*/
    lv_obj_set_width(label2, 120);
    lv_label_set_text(label2, "a2:");
    lv_obj_align(label2, LV_ALIGN_TOP_LEFT, 2, 20);

    lv_obj_t *label3 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label3, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Circular scroll*/
    lv_obj_set_width(label3, 120);
    lv_label_set_text(label3, "a3:");
    lv_obj_align(label3, LV_ALIGN_TOP_LEFT, 2, 40);

    lv_obj_t *label4 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label4, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Circular scroll*/
    lv_obj_set_width(label4, 120);
    lv_label_set_text(label4, "a4:");
    lv_obj_align(label4, LV_ALIGN_TOP_LEFT, 2, 60);

    lv_obj_t *label5 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label5, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Circular scroll*/
    lv_obj_set_width(label5, 120);
    lv_label_set_text(label5, "a5:");
    lv_obj_align(label5, LV_ALIGN_TOP_LEFT, 2, 80);

    lv_obj_t *label6 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label6, LV_LABEL_LONG_SCROLL_CIRCULAR); /*Circular scroll*/
    lv_obj_set_width(label6, 120);
    lv_label_set_text(label6, "a6:");
    lv_obj_align(label6, LV_ALIGN_TOP_LEFT, 2, 100);

    t1 = lv_label_create(lv_scr_act());
    t2 = lv_label_create(lv_scr_act());
    t3 = lv_label_create(lv_scr_act());
    t4 = lv_label_create(lv_scr_act());
    t5 = lv_label_create(lv_scr_act());
    t6 = lv_label_create(lv_scr_act());

    lv_label_set_long_mode(t1, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t2, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t3, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t4, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t5, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t6, LV_LABEL_LONG_SCROLL_CIRCULAR);

    lv_obj_set_width(t1, 128);
    lv_obj_set_width(t2, 128);
    lv_obj_set_width(t3, 128);
    lv_obj_set_width(t4, 128);
    lv_obj_set_width(t5, 128);
    lv_obj_set_width(t6, 128);

    String temp = "0.00°";

    lv_label_set_text(t1, temp.c_str());
    lv_label_set_text(t2, temp.c_str());
    lv_label_set_text(t3, temp.c_str());
    lv_label_set_text(t4, temp.c_str());
    lv_label_set_text(t5, temp.c_str());
    lv_label_set_text(t6, temp.c_str());

    lv_obj_align(t1, LV_ALIGN_TOP_LEFT, 26, 0);
    lv_obj_align(t2, LV_ALIGN_TOP_LEFT, 26, 20);
    lv_obj_align(t3, LV_ALIGN_TOP_LEFT, 26, 40);
    lv_obj_align(t4, LV_ALIGN_TOP_LEFT, 26, 60);
    lv_obj_align(t5, LV_ALIGN_TOP_LEFT, 26, 80);
    lv_obj_align(t6, LV_ALIGN_TOP_LEFT, 26, 100);

    Serial.println("Setup done");
}

void show(uint8_t index, float value)
{
    String temp = String(value, 2) + "°";
    switch (index)
    {
    case 1:
        lv_label_set_text(t1, temp.c_str());
        break;
    case 2:
        lv_label_set_text(t2, temp.c_str());
        break;
    case 3:
        lv_label_set_text(t3, temp.c_str());
        break;
    case 4:
        lv_label_set_text(t4, temp.c_str());
        break;
    case 5:
        lv_label_set_text(t5, temp.c_str());
        break;
    case 6:
        lv_label_set_text(t6, temp.c_str());
        break;
    }
}
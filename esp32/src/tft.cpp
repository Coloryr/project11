#include "Arduino.h"
#include "lvgl.h"
#include "tft.h"

lv_obj_t *t1;
lv_obj_t *t2;
lv_obj_t *t3;
lv_obj_t *t4;
lv_obj_t *t5;

float a1, a2, a3, a4, a5;

void show_init()
{
    a1 = a2 = a3 = a4 = a5 = 0;
    t1 = lv_label_create(lv_scr_act());
    t2 = lv_label_create(lv_scr_act());
    t3 = lv_label_create(lv_scr_act());
    t4 = lv_label_create(lv_scr_act());
    t5 = lv_label_create(lv_scr_act());

    lv_label_set_long_mode(t1, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t2, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t3, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t4, LV_LABEL_LONG_SCROLL_CIRCULAR);
    lv_label_set_long_mode(t5, LV_LABEL_LONG_SCROLL_CIRCULAR);

    lv_obj_set_width(t1, 128);
    lv_obj_set_width(t2, 128);
    lv_obj_set_width(t3, 128);
    lv_obj_set_width(t4, 128);
    lv_obj_set_width(t5, 128);

    String temp = String(a1, 2) + "°";

    lv_label_set_text(t1, temp.c_str());
    lv_label_set_text(t2, temp.c_str());
    lv_label_set_text(t3, temp.c_str());
    lv_label_set_text(t4, temp.c_str());
    lv_label_set_text(t5, temp.c_str());

    lv_obj_align(t1, LV_ALIGN_TOP_LEFT, 26, 0);
    lv_obj_align(t2, LV_ALIGN_TOP_LEFT, 26, 20);
    lv_obj_align(t3, LV_ALIGN_TOP_LEFT, 26, 40);
    lv_obj_align(t4, LV_ALIGN_TOP_LEFT, 26, 60);
    lv_obj_align(t5, LV_ALIGN_TOP_LEFT, 26, 80);
}

void show(uint8_t index, float value)
{
    switch (index)
    {
    case 1:
    {
        a1 = value;
        String temp = String(a1, 2) + "°";
        lv_label_set_text(t1, temp.c_str());
        break;
    }
    case 2:
    {
        a2 = value;
        String temp = String(a2, 2) + "°";
        lv_label_set_text(t2, temp.c_str());
        break;
    }
    case 3:
    {
        a3 = value;
        String temp = String(a3, 2) + "°";
        lv_label_set_text(t3, temp.c_str());
        break;
    }
    case 4:
    {
        a4 = value;
        String temp = String(a4, 2) + "°";
        lv_label_set_text(t4, temp.c_str());
        break;
    }
    case 5:
    {
        a5 = value;
        String temp = String(a5, 2) + "°";
        lv_label_set_text(t5, temp.c_str());
        break;
    }
    }
}
/*
 An example analogue clock using a TFT LCD screen to show the time
 use of some of the drawing commands with the ST7735 library.
 For a more accurate clock, it would be better to use the RTClib library.
 But this is just a demo. 
 Uses compile time to set the time so a reset will start with the compile time again
 
 Gilchrist 6/2/2014 1.0
 Updated by Bodmer
 */

#include <User_Setup.h>
#include <TFT_eSPI.h> // Graphics and font library for ST7735 driver chip
#include <SPI.h>
#include "test.h"

#include <lvgl.h>
#include <TFT_eSPI.h>

#include "tft.h"

/*Change to your screen resolution*/
static const uint16_t screenWidth  = 130;
static const uint16_t screenHeight = 162;

static lv_disp_draw_buf_t draw_buf;
static lv_color_t buf[ screenWidth * 10 ];

TFT_eSPI tft = TFT_eSPI(screenWidth, screenHeight); /* TFT instance */

/* Display flushing */
void my_disp_flush( lv_disp_drv_t *disp, const lv_area_t *area, lv_color_t *color_p )
{
    uint32_t w = ( area->x2 - area->x1 + 1 );
    uint32_t h = ( area->y2 - area->y1 + 1 );

    tft.startWrite();
    tft.setAddrWindow( area->x1, area->y1, w, h );
    tft.pushColors( ( uint16_t * )&color_p->full, w * h, true );
    tft.endWrite();

    lv_disp_flush_ready( disp );
}

void setup_lcd()
{
    String LVGL_Arduino = "Hello Arduino! ";
    LVGL_Arduino += String('V') + lv_version_major() + "." + lv_version_minor() + "." + lv_version_patch();

    Serial.println( LVGL_Arduino );
    Serial.println( "I am LVGL_Arduino" );

    lv_init();

    tft.begin();          /* TFT init */

    lv_disp_draw_buf_init( &draw_buf, buf, NULL, screenWidth * 10 );

    /*Initialize the display*/
    static lv_disp_drv_t disp_drv;
    lv_disp_drv_init( &disp_drv );
    /*Change the following line to your display resolution*/
    disp_drv.hor_res = screenWidth;
    disp_drv.ver_res = screenHeight;
    disp_drv.flush_cb = my_disp_flush;
    disp_drv.draw_buf = &draw_buf;
    lv_disp_drv_register( &disp_drv );

    lv_obj_t * label1 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label1, LV_LABEL_LONG_SCROLL_CIRCULAR);     /*Break the long lines*/
    lv_label_set_text(label1, "a1:");
    lv_obj_set_width(label1, 120); 
    lv_obj_align(label1, LV_ALIGN_TOP_LEFT, 2, 0);

    lv_obj_t * label2 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label2, LV_LABEL_LONG_SCROLL_CIRCULAR);     /*Circular scroll*/
    lv_obj_set_width(label2, 120);
    lv_label_set_text(label2, "a2:");
    lv_obj_align(label2, LV_ALIGN_TOP_LEFT, 2, 20);

    lv_obj_t * label3 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label3, LV_LABEL_LONG_SCROLL_CIRCULAR);     /*Circular scroll*/
    lv_obj_set_width(label3, 120);
    lv_label_set_text(label3, "a3:");
    lv_obj_align(label3, LV_ALIGN_TOP_LEFT, 2, 40);

    lv_obj_t * label4 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label4, LV_LABEL_LONG_SCROLL_CIRCULAR);     /*Circular scroll*/
    lv_obj_set_width(label4, 120);
    lv_label_set_text(label4, "a4:");
    lv_obj_align(label4, LV_ALIGN_TOP_LEFT, 2, 60);

    lv_obj_t * label5 = lv_label_create(lv_scr_act());
    lv_label_set_long_mode(label5, LV_LABEL_LONG_SCROLL_CIRCULAR);     /*Circular scroll*/
    lv_obj_set_width(label5, 120);
    lv_label_set_text(label5, "a5:");
    lv_obj_align(label5, LV_ALIGN_TOP_LEFT, 2, 80);

    show_init();

    Serial.println( "Setup done" );
}

void loop_lcd()
{
    lv_timer_handler(); /* let the GUI do its work */
    delay( 5 );
}
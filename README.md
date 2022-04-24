# Alchitry Cu Utils

collection of utilities I am using to develop on the Alchitry Cu

## Contents
* decoder_4_7_seg.v
  * Decoder for the 4 * 7 seg LED on Io Shield
* alchitry_cu.pcf
  * Constraint file for Alchitry Cu and Alchitry Io
* button_debounce.v
  * Button debouncer
* emulate_pull_down.v
  * Pull down emulator for Alchitry Io (due to hardware bug that was never addressed)
* clock_divider.v
  * Clock divider (very basic and inaccurate one)
* test.v
  * Test design ready to be used in apio. (Button 2 counter LED + 7 Seg)
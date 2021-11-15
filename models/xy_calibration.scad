//------------------------------------------------------
// XY calibration test
// Simple Calibration X & Y Axis
// 5@xes 15/11/2021
//------------------------------------------------------

$fn=50;
font = "Arial:style=Bold";

// 15cm x 15cm ; 1cm steps
cm_x = 15;
cm_y = 15;

height = 0.6;
letter_height =1.;
letter_size =8;

translate([-70,-70,0]) union() {
Ruler();
translate([5,5,0]) letter("0");
translate([cm_x*10-5,5,0]) letter("X");
translate([5,cm_x*10-5,0]) letter("Y");
}

module Ruler() {
minkowski()
{

union() {
// X
for (i = [0 : 2 : cm_x-1]) { 
    translate([10*i+1,1,0])
        cube([8,8,height]);
}
//Y
for (j = [0 : 2 : cm_y-1]) { 
    translate([1,10*j+1,0])
        cube([8,8,height]);
}

translate([1,5,0]) cube([cm_x*10-2,4,height]);
translate([5,1,0]) cube([4, cm_y*10-2,height]);

}

  cylinder(r=1,h=0.1);
}
}

module letter(Txt) {
  color("Red")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}                
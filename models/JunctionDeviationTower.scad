//-------------------------------------------------------------------------------------------
// Deviation Junction Tower
//---------------------------
// Nozzle 0.4
//---------------------------
// SpeedTower Script
// 
// The increment with which junction deviation will be increased every 27 layers (range 0.025 - 0.25)
//---------------------------
// startValue      : 0.025 
// valueChange     : 0.025
//---------------------------
// Layer = 0.16 (First layer 0.2)
// Layer Change         : 27
// Offset Layer         : 4
//-------------------------------------------------------------------------------------------

$fn=30;
font = "Arial:style=Bold";

Hc=0.16; // Layer Height
Line_Width = 0.4; // line Width

cube_size = 50*Hc;
letter_size = 0.35*cube_size;
letter_height = 0.05*letter_size;

o = cube_size / 2;

translate([-19.75, -19.75, Hc]) difference() {
  nz=3*Hc;
  step=27*Hc;
    union() {
        Base();
        Center();
        translate([2, 2, nz]) OneStep("0.025");
        translate([2, 2, nz+step*1]) OneStep("0.05");
        translate([2, 2, nz+step*2]) OneStep("0.075");
        translate([2, 2, nz+step*3]) OneStep("0.1");
        translate([2, 2, nz+step*4]) OneStep("0.125");
        translate([2, 2, nz+step*5]) OneStep("0.15");
        translate([2, 2, nz+step*6]) OneStep("0.175");
        translate([2, 2, nz+step*7]) OneStep("0.2");
        translate([2, 2, nz+step*8]) OneStep("0.225");
        translate([2, 2, nz+step*9]) OneStep("0.25");
    }
}


module Base() {
    translate([0, 0, -Hc]) cube([245*Hc,245*Hc,4*Hc], center = false);
}

module Center() {
    translate([34*Hc, 34*Hc, 0]) cube([175*Hc,175*Hc, 10*27*Hc+3*Hc], center = false);
}

module letter(Txt) {
  color("Yellow")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

module OneStep(Txt){
difference() {
  color("gray")
    union(){
      Etage();
      }
      color("blue")
      translate([40*Hc, letter_height-0.01, o-12*Hc]) rotate([90, 0, 0]) letter(Txt);
}
}


module Etage() {
            translate([0, 0, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([2*Hc, 2*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
            translate([120*Hc, 0, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([122*Hc, 2*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
            translate([0, 120*Hc, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([2*Hc, 122*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
            translate([120*Hc, 120*Hc, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([122*Hc, 122*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
}

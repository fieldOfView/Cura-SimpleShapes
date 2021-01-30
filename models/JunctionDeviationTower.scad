//-------------------------------------------------------------------------------------------
// Deviation Junction Tower
//---------------------------
// Nozzle 0.4
//---------------------------
// SpeedTower Script
// The value for junction deviation of 0.02 is the Marlin default value (range 0.01 - 0.10, default 0.02)
// The increment with which junction deviation will be increased every 20 layers (range 0.005 - 0.100, default 0.010)
//---------------------------
// startValue      : 0.01 
// valueChange     : 0.01
//---------------------------
// Layer = 0.16 (First layer 0.2)
// Layer Change         : 28
// Offset Layer         : 5
//-------------------------------------------------------------------------------------------

$fn=30;
font = "Arial:style=Bold";

Hc=0.16; // Layer Height
Line_Width = 0.4; // line Width

cube_size = 50*Hc;
letter_size = 0.35*cube_size;
letter_height = 0.05*letter_size;

o = cube_size / 2;

rotate(90,[-1, 0, 0]) translate([-19.75, -19.75, 0.2986]) difference() {
  nz=3*Hc;
  step=27*Hc;
    union() {
        Base();
        Center();
        translate([2, 2, nz]) OneStep("0.01");
        translate([2, 2, nz+step*1]) OneStep("0.02");
        translate([2, 2, nz+step*2]) OneStep("0.03");
        translate([2, 2, nz+step*3]) OneStep("0.04");
        translate([2, 2, nz+step*4]) OneStep("0.05");
        translate([2, 2, nz+step*5]) OneStep("0.06");
        translate([2, 2, nz+step*6]) OneStep("0.07");
        translate([2, 2, nz+step*7]) OneStep("0.08");
        translate([2, 2, nz+step*8]) OneStep("0.09");
        translate([2, 2, nz+step*9]) OneStep("0.10");
    }
}


module Base() {
    minkowski() {
    translate([0, 0, -Hc]) cube([245*Hc,245*Hc,3*Hc], center = false);
    //cylinder(r=1,h=Hc, center = false);
        sphere(Hc,$fn=5);
    }
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
            translate([122*Hc, 0, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
            translate([0, 120*Hc, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([0, 122*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
            translate([120*Hc, 120*Hc, 0]) cube([100*Hc,100*Hc,25*Hc], center = false);
            translate([122*Hc, 122*Hc, 0]) cube([96*Hc,96*Hc,27*Hc], center = false);
}
//-------------------------------------------------------------------------------------------
// Temp Tower
//---------------------------
// Nozzle 0.4
//---------------------------
// TempTower Script
//---------------------------
// StartTempTower       : 220 
// Incremental Temp     : -5
//---------------------------
// Layer = 0.2
// Layer Change         : 38
// Offset Layer         : 4
//---------------------------
// Layer = 0.16 (First layer 0.2)
// Layer Change         : 48
// Offset Layer         : 5
//---------------------------
// Based on a design proposed by stoempie https://www.thingiverse.com/thing:2493504
// Freely adapted by 5@xes  2020
//-------------------------------------------------------------------------------------------

$fn=30;
font = "Arial:style=Bold";

letter_size = 1;
letter_height = 0.8;


rotate(90,[-1, 0, 0]) translate([0, 0, 0]) union() {
  translate([0, 0, 10]) OneStep("0.1");
  translate([0, 0, 20]) OneStep("0.3");
  translate([0, 0, 30]) OneStep("0.5");
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
      Etage();
      color("blue") translate([20, letter_height-0.01, 5]) rotate([90, 0, 0]) letter(Txt);
}
}


module Etage() {
    minkowski() {
    translate([0, 0, 0]) cube([10,10,3], center = true);
    cylinder(r=0.1,h=1, center = true);
    }
}

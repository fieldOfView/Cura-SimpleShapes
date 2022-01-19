//===========================================================
// OpenSCAD  test object for dimensional Accuracy Test
// Author : 5@xes
// - D = 30 mm h= 5 mm
// - D = 25 mm h= 10 mm
// - D = 20 mm h= 15 mm
// - D = 15 mm h= 20 mm
// - D = 10 mm h= 25 mm
// - D =  5 mm h= 30 mm
//===========================================================

$fn = 200;

union () {
    translate([0,0,0]) cylinder(0.6,14.5,15);
    color("red",1.0) {
    difference() {
        translate([0,0,0.6]) cylinder(4.4,15,15);
        translate([12.5,0,5]) rotate([0,0,45]) cube([2.5,2.5,2],true);
    }
    translate([11.5,0,4]) cube([2,5,2],true);
    }

translate([0,0,5]) cylinder(5,12.5,12.5);
translate([0,0,10]) cylinder(5,10,10);
translate([0,0,15]) cylinder(5,7.5,7.5);
translate([0,0,20]) cylinder(5,5,5);
translate([0,0,25]) cylinder(5,2.5,2.5);
}
// OpenSCAD  test object for dimensional Accuracy Test
// Author : 5@xes

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
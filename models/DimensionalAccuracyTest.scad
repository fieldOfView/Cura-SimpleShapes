// OpenSCAD  test object for dimensional Accuracy Test
// Author : 5@xes

$fn = 200;

union () {
translate([0,0,0]) cylinder(0.6,9,10);
translate([0,0,0.6]) cylinder(4.4,10,10);
translate([0,0,5]) cylinder(5,8,8);
translate([0,0,10]) cylinder(5,6,6);
translate([0,0,15]) cylinder(5,4,4);
translate([0,0,20]) cylinder(5,2,2);
translate([0,0,25]) cylinder(5,1,1);
}
// 5@xes Thin Part Test 2020
// Modification for Cura 5.0 test 2022
// Thichness 
//   - 0.35
//   - 0.5
//   - 0.8
//   - 1

$fn=200;

union () {
    translate([11,0,0]) cube([14,0.35,5], center = false);
    translate([0,11,0]) rotate(90, [0,0,1]) cube([14,0.5,5], center = false);
    translate([-11,0,0]) rotate(180, [0,0,1]) cube([14,0.8,5], center = false);
    translate([0,-11,0]) rotate(-90, [0,0,1]) cube([14,1,5], center = false);
    difference() {
        cylinder(r=12, h=5);
        translate([0.4,0,-1]) cylinder(r=10, h=10);
    }
}

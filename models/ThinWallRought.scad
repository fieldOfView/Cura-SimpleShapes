// 5@xes Thin Part Test for Cura 5.0 test 2022 Rought
// Thichness 
//   - 0.35
//   - 0.5
//   - 0.8
//   - 1

$fn=20;

union () {
    translate([11,0,0]) cube([15,0.35,5], center = false);
    translate([0,11,0]) rotate(90, [0,0,1]) cube([15,0.5,5], center = false);
    translate([-11,0,0]) rotate(180, [0,0,1]) cube([15,0.8,5], center = false);
    translate([0,-11,0]) rotate(-90, [0,0,1]) cube([15,1,5], center = false);
    difference() {
        rotate([0,0,10]) cylinder(r=12, h=5);
        translate([0.4,0,-1]) cylinder(r=10, h=10);
    }
}

union () {
    rotate([0,0,45]) difference() {
        cylinder(r=26.5, h=5);
        translate([12,0,-1]) cylinder(r=15, h=10);
        translate([0,12,-1]) cylinder(r=15, h=10);
        translate([-12,0,-1]) cylinder(r=15, h=10);
        translate([0,-12,-1]) cylinder(r=15, h=10);
    }
}
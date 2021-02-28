//-------------------------------------------------------------------------------------------
// CubeBicolorRed
//-------------------------------------------------------------------------------------------
$fn=10;

translate([-5, -5, 5]) 
difference(){
union() {
  color("White") translate([0, 0, 0]) cube([10,10,10], center = true);
  // color("red") translate([10, 0, 0]) cube([10,10,10], center = true);
  // color("red") translate([0, 10, 0]) cube([10,10,10], center = true);
  color("White") translate([10, 10, 0]) cube([10,10,10], center = true);
}
translate([5, 5, 0]) cylinder(r=0.001,h=20, center = true);
}



//-------------------------------------------------------------------------------------------
// Tolerance
//---------------------------
//-------------------------------------------------------------------------------------------

$fn=80;
font = "Arial:style=Bold";

cube_size = 12;
letter_size = 0.35*cube_size;
letter_height = 0.05*letter_size;

o = cube_size / 2;

translate([5*o, o, 0]) rotate(180,[0, 0, 1]) difference() {
    union() {
      translate([o, o, 0]) Pin(4,1);
      translate([3*o, o, 0]) Pin(4,1);
      translate([5*o, o, 0]) Pin(4,1);
      translate([7*o, o, 0]) Pin(4,1);
      translate([9*o, o, 0]) Pin(4,1);
        
    difference() {
      color("gray")
        difference(){
          cube([cube_size*5,cube_size,cube_size], center = false);
          translate([o, o,0]) DiamChanf(4+0.1,0.8);
          translate([3*o, o,0]) DiamChanf(4+0.15,0.8);
          translate([5*o, o,0]) DiamChanf(4+0.2,0.8);
          translate([7*o, o,0]) DiamChanf(4+0.25,0.8);
          translate([9*o, o,0]) DiamChanf(4+0.3,0.8);
          }

          translate([o, letter_height-0.01, o]) rotate([90, 0, 0]) letter("0.2");
          translate([3*o, letter_height-0.01, o]) rotate([90, 0, 0]) letter("0.3");
          translate([5*o, letter_height-0.01, o]) rotate([90, 0, 0]) letter("0.4");
          translate([7*o, letter_height-0.01, o]) rotate([90, 0, 0]) letter("0.5");
          translate([9*o, letter_height-0.01, o]) rotate([90, 0, 0]) letter("0.6");
    }
    }
}

module DiamChanf(Sz,Cf) {
 union() {
    
    cylinder(h = Cf, r1 = Sz+Cf, r2 = Sz, center = false);
    cylinder(h = cube_size, r1 = Sz, r2 = Sz, center = false);
    translate([0, 0, cube_size-Cf]) cylinder(h = Cf, r1 = Sz, r2 = Sz+Cf, center = false);
 }
}   

module Pin(Sz,Cf) {
 union() {
    translate([0, 0,Cf]) cylinder(h = cube_size*1.4, r1 = Sz, r2 = Sz, center = false);
    cylinder(h = Cf, r1 = Sz-Cf*0.5, r2 = Sz, center = false);
 }
}  

module letter(Txt) {
  color("blue")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}







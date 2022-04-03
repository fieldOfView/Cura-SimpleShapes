//-------------------------------------------------------------------------------------------
// Lithophane  Test Part
//---------------------------
// Nozzle 0.4
// Layer Height 0.12
//---------------------------
// Based on a design proposed by Litho3D https://www.thingiverse.com/thing:4511472
// Freely adapted by 5@xes  2022
//-------------------------------------------------------------------------------------------

$fn=40;
font = "Arial:style=Bold";

Hc=0.12; // Layer Height

cube_size = 40*Hc;
letter_size = 0.85*cube_size;
letter_depth = 0.1*cube_size;
nz=Hc*(2+cos(30));
step=cube_size;
  
translate([cube_size*-4, -cube_size*0.5, Hc*(1+cos(30))]) union() {
  Base();
  difference() {
  union() {
  translate([1.5, 0.5, nz]) OneStep(4.0);
  translate([1.5, 0.5, nz+step*1]) OneStep(3.6);
  translate([1.5, 0.5, nz+step*2]) OneStep(3.2);
  translate([1.5, 0.5, nz+step*3]) OneStep(3.0);
  translate([1.5, 0.5, nz+step*4]) OneStep(2.8);
  translate([1.5, 0.5, nz+step*5]) OneStep(2.6);
  translate([1.5, 0.5, nz+step*6]) OneStep(2.4);
  translate([1.5, 0.5, nz+step*7]) OneStep(2.2);
  translate([1.5, 0.5, nz+step*8]) OneStep(2.0);
  translate([1.5, 0.5, nz+step*9]) OneStep(1.8);
  translate([1.5, 0.5, nz+step*10]) OneStep(1.6);
  translate([1.5, 0.5, nz+step*11]) OneStep(1.2);
  translate([1.5, 0.5, nz+step*12]) OneStep(1.0);
  translate([1.5, 0.5, nz+step*13]) OneStep(0.8);
  translate([1.5, 0.5, nz+step*14]) OneStep(0.6);
  translate([1.5, 0.5, nz+step*15]) OneStep(0.4);
  }
    color("red")  translate([cube_size*3.5, cube_size*2.1, cube_size*8+nz]) rotate([0,0,180]) linear_extrude(height = cube_size*17, center = true, convexity = 10, scale = 1.8, $fn = 16) {square(size = [cube_size*3.2, cube_size], center = false);}
  }
}


module Base() {
    minkowski() {
        translate([0, -cube_size*0.4, -Hc]) cube([cube_size*7.6,cube_size*2,3*Hc], center = false);
        sphere(Hc,$fn=5);
    }
}

module letter(Txt) {
  color("Yellow")
  linear_extrude(height = letter_depth) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}


module OneStep(Txt){
difference() {
  color("gray")
    union(){
      Etage(Txt);
      }
      color("blue")
      translate([cube_size, letter_depth-0.01, (cube_size / 2)]) rotate([90, 0, 0]) letter(str(Txt));
}
}


module Etage(ThickNess) {
        union() {
            cube([cube_size*3,cube_size,cube_size], center = false);
            translate([cube_size*3, 0, 0])  cube([(4*cube_size),ThickNess,cube_size], center = false);
            

        }
}

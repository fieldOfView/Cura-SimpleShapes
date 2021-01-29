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

$fn=40;
font = "Arial:style=Bold";

Hc=0.16; // Layer Height
Line_Width = 0.4; // line Width

cube_size = 50*Hc;
letter_size = 0.35*cube_size;
letter_height = 0.05*letter_size;

o = cube_size / 2;

rotate(90,[-1, 0, 0]) translate([-15, 0, 0]) difference() {
  nz=3*Hc;
  step=48*Hc;
union() {
  Base();
  translate([2, 1, nz]) OneStep("250");
  translate([2, 1, nz+step*1]) OneStep("245");
  translate([2, 1, nz+step*2]) OneStep("240");
  translate([2, 1, nz+step*3]) OneStep("235");
  translate([2, 1, nz+step*4]) OneStep("230");
  translate([2, 1, nz+step*5]) OneStep("225");
  translate([2, 1, nz+step*6]) OneStep("220");
  translate([2, 1, nz+step*7]) OneStep("215");
  translate([2, 1, nz+step*8]) OneStep("210");
}
translate([2, 1, nz]) Mat("ABS");
}


module Base() {
    minkowski() {
    translate([0, 0, -Hc]) cube([273*Hc,60*Hc,3*Hc], center = false);
    //cylinder(r=1,h=Hc, center = false);
        sphere(Hc,$fn=5);
    }
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
      translate([o, letter_height-0.01, o]) rotate([90, 0, 0]) letter(Txt);
}
}

module Mat(Txt){
      color("Red")
      translate([4*cube_size+o, letter_height-0.01, o]) rotate([90, 0, 0]) letter(Txt);
}

module Chanfrein(Chf) {
    color("blue")
    translate([50*Hc, 50*Hc, 40*Hc-Chf])
    rotate([90, 0, 0]) linear_extrude(height = cube_size, center = false)
    polygon(points=[[0,0],[0,Chf],[Chf,Chf]]);
}

module ChanfreinRayon(rd) {
    color("blue")
    difference() {
        translate([50*Hc, 50*Hc, 40*Hc-rd])
        rotate([90, 0, 0]) linear_extrude(height = cube_size, center = false)
        polygon(points=[[0,0],[0,rd],[rd,rd]]);
        translate([50*Hc+rd, 50*Hc+0.1, 40*Hc-rd]) rotate([90, 0, 0])cylinder(r=rd,h=53*Hc, center = false);        
        
    }
}

module Etage() {
    difference() {
        union() {
    
            translate([Hc, Hc, 0]) cube(48*Hc, center = false);
            cube([cube_size,cube_size,cube_size*0.8], center = false);
            translate([4*cube_size, 0, 0])  cube([cube_size,cube_size,cube_size*0.8], center = false);
            translate([4*cube_size+Hc,  Hc, 0])  cube(48*Hc, center = false);
            
            translate([0, 0, cube_size*0.8])  cube([5*cube_size,cube_size,3*Hc], center = false);
            
            Chanfrein(4);
            translate([5*cube_size, 0, 0]) mirror([1,0,0]) ChanfreinRayon(5);
        }
        translate([(2*Line_Width), (2*Line_Width), -0.1]) cube([cube_size-(4*Line_Width),cube_size-(4*Line_Width),52*Hc], center = false);
        translate([4*cube_size+Hc*5, Hc*5, -0.1]) cube([cube_size-(4*Line_Width),cube_size-(4*Line_Width),52*Hc], center = false);
    }
}

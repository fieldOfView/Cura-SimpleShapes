//-------------------------------------------------------------------------------------------
// Temp Tower PLA limited to 190°C
//---------------------------
// Nozzle 0.4
//---------------------------
// TempTower Script
//---------------------------
// StartTempTower       : 220 
// Incremental Temp     : -5
//---------------------------
// Layer = 0.16 (First layer 0.2)
// Layer Change         : 52
// Offset Layer         : 5
//---------------------------
// Based on a design proposed by stoempie https://www.thingiverse.com/thing:2493504
// Freely adapted by 5@xes  2020
//-------------------------------------------------------------------------------------------
// Modification 01/2022 increase the wall thickness to 4 Line_Width
//-------------------------------------------------------------------------------------------

$fn=30;
font = "Arial:style=Bold";

Hc=0.16; // Layer Height
Line_Width = 0.4; // line Width

cube_size = 52*Hc;
letter_size = 0.30*cube_size;
letter_height = Line_Width;

o = cube_size / 2;

translate([Hc*(-136-cos(60)), -30*Hc, Hc*(1+cos(30))]) difference() {
  nz=Hc*(2+cos(30));
  step=cube_size;
union() {
  Base();
  translate([1.5, 0.5, nz]) OneStep("220");
  translate([1.5, 0.5, nz+step*1]) OneStep("215");
  translate([1.5, 0.5, nz+step*2]) OneStep("210");
  translate([1.5, 0.5, nz+step*3]) OneStep("205");
  translate([1.5, 0.5, nz+step*4]) OneStep("200");
  translate([1.5, 0.5, nz+step*5]) OneStep("195");
  translate([1.5, 0.5, nz+step*6]) OneStep("190");
}
translate([1.5, 0.5, nz]) Mat("PLA");
}


module Base() {
    minkowski() {
    translate([0, 0, -Hc]) cube([278*Hc,60*Hc,3*Hc], center = false);
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

module letterMat(Txt) {
  color("Yellow")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size*1.1, font = font, halign = "center", valign = "center");
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
      translate([4*cube_size+o, letter_height-0.01, o]) rotate([90, 0, 0]) letterMat(Txt);
}

module Chanfrein(Chf) {
    color("blue")
    translate([cube_size, cube_size, 44*Hc-Chf])
    rotate([90, 0, 0]) linear_extrude(height = cube_size, center = false)
    polygon(points=[[0,0],[0,Chf],[Chf,Chf]]);
}

module ChanfreinRayon(rd) {
    color("blue")
    difference() {
        translate([cube_size, cube_size, 44*Hc-rd])
        rotate([90, 0, 0]) linear_extrude(height = cube_size, center = false)
        polygon(points=[[0,0],[0,rd],[rd,rd]]);
        translate([51*Hc+rd, 51*Hc+0.55, 44*Hc-rd]) rotate([90, 0, 0])cylinder(r=rd,h=55*Hc, center = false);        
        
    }
}

module Colonne() {
    difference() {
        union() {
        cube([cube_size,cube_size,cube_size*0.9], center = false);
        translate([0.5*Line_Width, 0.5*Line_Width, 0]) cube([cube_size-(Line_Width),cube_size-(Line_Width),cube_size], center = false);  
        }
           translate([(4*Line_Width), (4*Line_Width), -0.5]) cube([cube_size-(8*Line_Width),cube_size-(8*Line_Width),cube_size+1], center = false); 
    }
    }
module Etage() {
        union() {
            // First Colonne
            Colonne();
            // Second Colonne
            translate([4*cube_size, 0, 0])  Colonne();
            
            // Traverse
            translate([cube_size, 0, (cube_size*0.9-4*Hc)])  cube([((3*cube_size)+Line_Width),cube_size,4*Hc], center = false);
            
            // Chanfrein
            Chanfrein(4);
            translate([5*cube_size, 0, 0]) mirror([1,0,0]) ChanfreinRayon(5);
        }
}

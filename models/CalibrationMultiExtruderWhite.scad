//-------------------------------------------------------------------------------------------
// MultiExtruderWhite
//-------------------------------------------------------------------------------------------

$fn=50;
font = "Arial:style=Bold";

letter_size = 3;
letter_height = 0.8;


rotate(90,[-1, 0, 0]) translate([0, 0, 2.5])

  difference(){
  
  union() {
  color("white")
  difference() {
      cube([15,15,5], center = true);
      color("white") translate([0, -8+1.5*letter_height, 0]) rotate([90, 0, 0]) letter("Y+");
      color("white") rotate([0, 0, 90]) translate([0, -8+1.5*letter_height, 0]) rotate([90, 0, 0]) letter("X+");
      color("white") rotate([0, 0, -90]) translate([0, -8+1.5*letter_height, 0]) rotate([90, 0, 0]) letter("X-");
      color("white") rotate([0, 0, 180]) translate([0, -8+1.5*letter_height, 0]) rotate([90, 0, 0]) letter("Y-");
      }
  //color("red") translate([0, 0, 5]) OneStep(0.1,-0.1);
  color("white") translate([0, 0, 10]) OneStep(0.3,0.2);    
  //color("red") translate([0, 0, 15]) OneStep(0.6,-0.3);
  color("white") translate([0, 0, 20]) OneStep(1,0.4);
  //color("red") translate([0, 0, 25]) OneStep(1.5,-0.5);

    }
  cylinder(r=3,h=60, center = true);  
}



module letter(Txt) {
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

module OneStep(Offs,Valoff){
difference() {
      Etage(Offs);

      

    if(Valoff>0) {
      color("white") translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str("+",Valoff));
      color("white") rotate([0, 0, -90]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str("+",Valoff));
      color("white") rotate([0, 0, 90]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str(-Valoff));
      color("white") rotate([0, 0, 180]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str(-Valoff));
    }
    else
    {
      color("white") translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str(Valoff));
      color("white") rotate([0, 0, -90]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str(Valoff));
      color("white") rotate([0, 0, 90]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str("+",-Valoff));
      color("white") rotate([0, 0, 180]) translate([0, -8+Offs+letter_height, 0]) rotate([90, 0, 0]) letter(str("+",-Valoff));
    }
}
}

module Etage(Offset) {
    minkowski() {
    translate([0, 0, 0]) cube([15-(4*Offset),15-(4*Offset),3], center = true);
    cylinder(r=Offset,h=2, center = true);
    }
}

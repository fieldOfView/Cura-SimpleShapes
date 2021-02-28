//---------------------------
// Flow Test  by 5@axes
//---------------------------

font = "Arial:style=Bold";
$fn=100;

cylinder_height = 2.3;
cylinder_size=23.2*0.5;
letter_size = cylinder_size*1.3;
letter_height = 0.3*cylinder_height;


translate([0, 0, 0]) Model();

module Model() {
    difference() {
      Corps();
      letter("€");
    } 
}

module letter(Txt) {
  color("red")
  translate([ 0, 0, cylinder_height-letter_height]) linear_extrude(height = letter_height) {
    translate([ -1, 0,0]) text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

module Corps() {
    difference() {
        difference() {
        union() {
            // First pilar
            cylinder(cylinder_height,cylinder_size,cylinder_size, center = false);
            translate([cylinder_size , 0, 0]) cylinder(cylinder_height*0.8,cylinder_size*0.7,cylinder_size*0.7, center = false);
        }
        translate([cylinder_size , 0, -1]) cylinder(cylinder_height*2,2.5,2.5, center = false);
        }
    }
}

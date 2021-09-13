//---------------------------
// Flow Test % by 5@axes
//---------------------------

font = "Arial:style=Bold";
$fn=100;

nz = 0.4;
height = 1.6;
long = 20;
width = 8;
diam_ext = width*0.8;
lh = 0.25;
long2 =15;
width2=8;
letter_size = width2*0.7;
letter_height = height;


translate([0, 0, 0]) Model();

module Model() {
    difference() {
      Corps();
      translate([0 , (width+width2)/2, height/4]) letter("110");
    } 
}

module letter(Txt) {
  color("red")
  translate([ 0, 0, height-letter_height]) linear_extrude(height = letter_height) {
  translate([ -1, 0,0]) text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

module Corps() {
    union() {
        // First pilar
        translate([0 , 0, height/2]) cube([long,width,height], center = true);
        translate([0 , (width+width2)/2, height/4]) cube([long2,width2,height*0.5], center = true);
        translate([0 , 0, height+(lh/2)]) difference(){
              cylinder(h=lh,r=diam_ext/2,center = true);
              cylinder(h=lh+1,r=(diam_ext/2)-(nz+0.05),center = true);
        }
    }
}

//---------------------------
// Flow Test % by 5@axes
//---------------------------

Texte = "90";


font = "Agency FB:style=Bold";
$fn=100;

nz = 0.4;
height = 1.2;
long = 24;
width = 12;
diam_ext = width*0.8;
lh = 0.25;
long2 =15;
width2=10;
letter_size = width2*0.6;
letter_height = height*0.9;


translate([0, 0, 0]) Model();

module Model() {
    difference() {
      Corps();
      translate([letter_size/6 , (width+width2)/2.1, height/4]) letter(Texte);
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
        // First rectangle
        translate([0 , 0, height/2]) cube([long,width,height], center = true);
        translate([0 , (width+width2)/2, height*0.3]) cube([long2,width2,height*0.6], center = true);
        translate([long/4.5 , 0, height+(lh/2)]) difference(){
              cylinder(h=lh,r=diam_ext/2,center = true);
              cylinder(h=lh+1,r=(diam_ext/2)-(nz+0.02),center = true);
        }
        
        translate([-long/4.5 , 0, height+(lh/2)]) union(){
              cube([diam_ext,(nz+0.02),lh],center = true);
              cube([(nz+0.02),diam_ext,lh],center = true);
        }
    }
}

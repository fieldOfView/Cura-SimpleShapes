// Overhang Test
// 5@axes

$fn=20;

font = "Arial:style=Bold"; //  Police text
letter_size = 5;  //  Size text
letter_height = 1;  //  Thichness text

translate([-32.12260,0,-38.877]) union(){
        translate([33.384,0,39.877]) cube([50,12,2],center=true);
        for (a =[10:10:50]){
         translate([70*sin(a),0,70*cos(a)]) rotate(a,[0,1,0]) union(){
             cube([12.43,12,2],center=true);
             txt=str(90-a,"°");
             translate([0,0,0.2]) rotate(90,[0,0,1]) letter(txt);}
        }
}

module letter(l) {
  color("Red")
  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center");
  }
}
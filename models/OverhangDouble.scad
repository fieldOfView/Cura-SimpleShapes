// Overhang Test
// 5@axes

$fn=20;

font = "Arial:style=Bold"; //  Police text
letter_size = 5;  //  Size text
letter_height = 1;  //  Thichness text

translate([-30,-16.449,0]) union(){
        translate([33.84,0,17.449]) cube([70,12,2],center=true);
        for (a =[10:10:70]){
         translate([70*sin(a),0,70*cos(a)]) rotate(a,[0,1,0]) union(){
             cube([12.43,12,2],center=true);
             txt=str(90-a,"°");
             translate([0,0,0.2]) rotate(90,[0,0,1]) letter(txt);}
        }
        
        translate([33.84,15,17.449]) cube([70,12,2],center=true);
        for (a =[15:10:65]){
         translate([70*sin(a),15,70*cos(a)]) rotate(a,[0,1,0]) union(){
             cube([12.43,12,2],center=true);
             txt=str(90-a,"°");
             translate([0,0,0.2]) rotate(90,[0,0,1]) letter(txt);}
        }
        
        translate([33.84,10,17.449]) cube([70,12,2],center=true);
        translate([66.34,13.5,22]) cube([5,15,8],center=true);
}

module letter(l) {
  color("Red")
  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center");
  }
}
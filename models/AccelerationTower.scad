//-------------------------------------------------------
// AccelerationTower
// Accleration & Riging test Part
// 5@xes 16/01/2021
// -------------------------------------------------------
// Test model based on the Klipper Documentation articles
//  https://www.klipper3d.org/Resonance_Compensation.html
//--------------------------------------------------------

$fn = 120;
font = "Arial:style=Regular";
length = 121;
thickness= 10;
height = 5;
step =9;

size = 4;
gap=0.1;
pocket = 12;

dec = 4;

radius=height+1;

letter_size=height*(step+1)+1;
letter_height=thickness/8;

translate([-length/2,-length/2,0]) Shape();


module Shape() {
 difference() {
union() {
    OneSide();
    translate([0,length,0]) rotate([0,0,270]) OneSide();

}
    translate([length/2,thickness-letter_height,letter_size/2-1]) rotate([90,0,180])letter("Y");
    translate([thickness-letter_height,length/2,letter_size/2-1]) rotate([90,0,90])letter("X");
}

}

module letter(Txt) {
  color("Red")
  linear_extrude(height = letter_height, scale=[1.2,1]) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

module OneSide() {
    for (a =[0:step]) translate([0,0,height*a]) OneStep();
}

module OneStep() {
    Rad=radius+gap*0.5;
    difference() {
    intersection() {
    union() {

        difference() {
            cube([length,thickness/2,height], center =false);
            translate([length/3-radius*2.025,0,height/2]) rotate([90,0,-20]) cylinder(thickness*5,Rad,Rad,center = true);
            translate([2*length/3+radius,0,height/2]) rotate([90,0,45]) cylinder(thickness*5,Rad,Rad,center = true);
            translate([2*length/3-pocket/2,0,0]) cube([pocket,thickness/2,height],center = false);

        }
        color("red",1.0)
        translate([length/3-(gap+radius*2),0,height/2]) rotate([90,0,20]) cylinder(thickness*5,radius,radius,center = true);
        cube([length/5,thickness/2,height], center =false);
        translate([length/2*3,0,height/2]) rotate([90,0,-45]) cylinder(thickness*5,radius,radius,center = true);
        color("blue",1.0)
        translate([0,thickness/2,0]) cube([length,thickness/2,height], center = false);
        translate([length/3*2-pocket+gap,0,height/2]) rotate([90,0,-45]) cylinder(thickness*5,radius,radius,center = true);
    }
    cube([length,thickness,height], center =false);
    }
    translate([length/10,-height+0.5,height/2]) rotate([90,0,0]) cylinder(thickness,height/2.5,height/2.5,center = true);
}
            
}




                
//---------------------------
// Test Retract by 5@xes
//---------------------------

$fn=100;

Hc=0.16; // Layer Height
Line_Width = 0.4; // line Width

cylinder_size = 4*Line_Width;
cylinder_height = 100*Hc;

translate([0, 0, 3*Hc-0.0214]) Model();

module Model() {
    union() {
      Base();
      Etage();
    } 
}

module Base() {
    minkowski() {
    cube([20,5,4*Hc], center = true);
    //cylinder(r=1,h=Hc, center = false);
        sphere(Hc,$fn=5);
    }
}

module Etage() {
    difference() {
        union() {
            // First pilar
            translate([-3.5*cylinder_size, 0, 0])  cylinder(cylinder_height,cylinder_size,cylinder_size, center = false);
            
            // Second pilar
            translate([3.5*cylinder_size, 0, 0])  cylinder(cylinder_height,cylinder_size,2*Line_Width, center = false);
  
        }
    }
}

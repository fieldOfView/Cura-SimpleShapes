//------------------------------------------------------
// XY calibration test
// Simple Calibration Z Axis
// 5@xes 16/11/2021
//------------------------------------------------------

$fn=120;


// 150mm x 150mm ; 10mm steps
lg_x = 15;
lg_y = 15;

height = 4.8;
height2 = 7.8;
letter_height = 5.2;
letter_size =8;

dec =8;

minkowski()
{
    union() {
    translate([dec,dec,0]) cube(size =[8,8,4.8], center =false);
    translate([-dec,dec,0]) cube(size =[8,8,9.8], center =false);
    translate([-dec,-dec,0]) cube(size =[8,8,24.8], center =false);
    translate([dec,-dec,0]) cube(size =[8,8,0.8], center =false);
    
    translate([0,dec,0]) cube(size =[8,8,74.8], center =false);     
    translate([dec,0,0]) cube(size =[8,8,49.8], center =false);    
    cube(size =[8,8,150], center =false);
    translate([-dec,0,0]) cube(size =[8,8,99.8], center =false); 
    translate([0,-dec,0]) cube(size =[8,8,124.8], center =false);    
}
  cylinder(r=1,h=0.1);
}


                
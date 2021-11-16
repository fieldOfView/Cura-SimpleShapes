//------------------------------------------------------
// XY calibration test
// Simple Calibration Z Axis
// 5@xes 16/11/2021
//------------------------------------------------------

$fn = 120;

size = 4;
dec = 4;
minh = 0.1;

minkowski()
{
    union() {
    translate([dec,dec,0]) cube(size =[size,size,5-2*minh], center =false);
    translate([-dec,dec,0]) cube(size =[size,size,10-2*minh], center =false);
    translate([-dec,-dec,0]) cube(size =[size,size,25-2*minh], center =false);
    translate([dec,-dec,0]) cube(size =[size,size,1-2*minh], center =false);
    
    translate([0,dec,0]) cube(size =[size,size,75-2*minh], center =false);     
    translate([dec,0,0]) cube(size =[size,size,50-2*minh], center =false);    
    cube(size =[size,size,150-2*minh], center =false);
    translate([-dec,0,0]) cube(size =[size,size,100-2*minh], center =false); 
    translate([0,-dec,0]) cube(size =[size,size,125-2*minh], center =false);    
}
  cylinder(r=1,h=minh);
}


                
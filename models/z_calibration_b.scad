//------------------------------------------------------------
// Z calibration           
//------------------------------------------------------------
Diameter = 8; //

$fn=150;
Size =4;

union(){ 
    for (i=[0:7.5:120])
    {
        rotate(i*3)
        translate([Diameter,0,0])
        rotate(-i*3) translate([0,0,0.5*(i+30)]) cube( [Size,Size,i+30], center=true);
    }
}
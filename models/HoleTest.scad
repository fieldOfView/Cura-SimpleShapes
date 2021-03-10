// Hole test
// Initial design : https://www.thingiverse.com/thing:2380801
//
DIAMETER = 24; //

$fn=100;

union(){ 
    for (i=[3:17])
    {
        Inc=i*i;
        rotate(Inc*1.2)
        translate([DIAMETER,0,0])
        difference(){
            cylinder( h=5,r=(i*0.5+0.3), center=false);
            cylinder( h=8,r=(i*0.5-1) , center=false, $fn=200);
        }
    }
}
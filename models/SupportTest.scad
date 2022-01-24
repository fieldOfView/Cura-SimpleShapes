//--------------------------------------------
// Support Test
// 
// by Dotdash32 (JDeWitt)
// https://github.com/dotdash32
//
// rendering aids
// $fa = 3; //min segment angle
// $fs = 0.5; // min segment size
//--------------------------------------------

$fn=45; // number of segments

//parameters
thickness = 2; //primary thickness of walls
height = 20; //height of tower
length = 15; //extension of objects from tower
width = 10; // width of extension tabs, also controls feature size
bottomPerimeterMultiplier = 1.25; //how much extra for parts with matieral under (test "Everywhere" supports)
towerSize = 10; //diameter of riser tower

module FloatingSphere(length, width, rotation) { 
// Create a sphere floating in air with a dangling tab
// rotate about center point with 'rotation' for both sphere and cube
    rotate([0,0, rotation]){
        union() {
            translate([length/2,0,-thickness/2]) cube([length, width, thickness], center=true);
            difference() {
                translate([length, 0,0]) sphere(d=width);
                translate([length, 0, width]) cube(width*2,center=true);
            }
        }
    }
}

module FloatingCube(length, width, rotation) {
// Create a cube floating in air with a dangling tab
    rotate([0,0,rotation]){
        union() {
            translate([length/2,0,-thickness/2]) cube([length, width, thickness], center=true);
            translate([length,0, -width/4]) cube([width,width,width/2], center=true);
        }
    }
}

module SupportTest(length, width, towerSize) {
    union() {
        //create bottom tab for floating sphere
        difference() {
            translate([-length,0,0]) sphere(d=width*bottomPerimeterMultiplier);
            translate([-length,0,-width*bottomPerimeterMultiplier/2]) cube(width*bottomPerimeterMultiplier,center=true);
        }
        
        translate([-length/2,0,thickness/2]) cube([length,width,thickness],center=true);

        // create bottom tab for floating cube
        translate([0,-length,thickness/2]) cube([width*bottomPerimeterMultiplier,width*bottomPerimeterMultiplier,thickness],center=true);
        translate([0,-length/2,thickness/2]) cube([width,length,thickness],center=true);

        // finish bottom with little circle
        translate([0,0,thickness/2]) cube([towerSize, towerSize,thickness], center=true);

        translate([0,0,height/2]) difference() {
            union() {
                cube([towerSize, towerSize, height],center=true); // main tower
                translate([0,0,height/2]) {
                    FloatingSphere(length, width,180);  //sphere for Everywhere
                    FloatingCube(length, width, 270);   //cube   for Everywhere
                    FloatingSphere(length, width,0);    //sphere for Touching Buildplate
                    FloatingCube(length, width,90);     //cube   for Touching Buildplate
        }
            }
            cube([towerSize-2*thickness, towerSize-2*thickness, height],center=true); // hollow center
        }
        
    }
}

SupportTest(length,width,towerSize); //

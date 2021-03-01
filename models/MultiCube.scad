//---------------------------
// Multi Cube Test by 5@axes
// Size of each cube = 10 mm
//---------------------------

$fn=100;
Cube_S = 10;

translate([-Cube_S*2, Cube_S*2, 0]) rotate(-90,[0, 0, 1]) Model();

module Model() {
    union() {
      cube(Cube_S,center=false);
      translate([Cube_S,0,0]) cube(Cube_S,center=false);
      translate([Cube_S*2,0,0]) cube(Cube_S,center=false);
      translate([Cube_S*3,0,0]) cube(Cube_S,center=false);
      translate([0,Cube_S,0]) cube(Cube_S,center=false);
      translate([0,Cube_S*2,0]) cube(Cube_S,center=false);
      translate([0,Cube_S*3,0]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S,0]) cube(Cube_S,center=false);
      translate([Cube_S*2,Cube_S,0]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S*2,0]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S*3,0]) cube(Cube_S,center=false);
      translate([Cube_S*2,Cube_S*2,0]) cube(Cube_S,center=false); 
      translate([Cube_S*3,Cube_S,0]) cube(Cube_S,center=false);   
        
      translate([0,0,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S,0,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S*2,0,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S*3,0,Cube_S]) cube(Cube_S,center=false);
      translate([0,Cube_S,Cube_S]) cube(Cube_S,center=false);
      translate([0,Cube_S*2,Cube_S]) cube(Cube_S,center=false);
      translate([0,Cube_S*3,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S*2,Cube_S,Cube_S]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S*2,Cube_S]) cube(Cube_S,center=false);   
 
      translate([0,0,Cube_S*2]) cube(Cube_S,center=false);
      translate([Cube_S,0,Cube_S*2]) cube(Cube_S,center=false);
      translate([Cube_S*2,0,Cube_S*2]) cube(Cube_S,center=false);
      translate([0,Cube_S,Cube_S*2]) cube(Cube_S,center=false);
      translate([0,Cube_S*2,Cube_S*2]) cube(Cube_S,center=false);
      translate([Cube_S,Cube_S,Cube_S*2]) cube(Cube_S,center=false);

      translate([0,0,Cube_S*3]) cube(Cube_S,center=false);
      translate([Cube_S,0,Cube_S*3]) cube(Cube_S,center=false);
      translate([0,Cube_S,Cube_S*3]) cube(Cube_S,center = false);
    } 
}


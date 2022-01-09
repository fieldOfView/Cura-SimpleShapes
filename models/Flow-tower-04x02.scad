//=====================================================
//
// Flow test tower
// Initial model from Alexander Sudarkin
// https://www.thingiverse.com/thing:4179047
// Freely adapted by 5@xes
//
//=====================================================
//
// - Modifications -
// -----------------
//
// 12/2021 : wo=w+(lay/2);  previous value wo=w+0.05;
//
//=====================================================

nz=0.4; // Nozzle Size
lay=0.2; // Layer Height

xy=15; // Size
w5=4;

hs=8; // height
hw=0.8; // height pin
// flow text 110% to 90 % (11 step)
ns=[110,108,106,104,102,100,98,96,94,92,90];
h=hs*11; 

fontMain=hs/1.5;
fontSub=hs/1.5;

rzh=lay;
fs=2.0; // Chamfer size
fsp=2.2; // Pin Chamfer size

w=4; // Pin Width
wo=w+(lay/2); // Housing Width

spw=nz+0.05; // Support Width
spi=3.5; // Support interval

module flowtowerMain(){
difference() {

translate([0,0,h/2]) cube([xy,xy,h],true);

// Hole
color("red",1.0)
for (i=[0:hs:h-hs])
translate([0,0,(hs/2)+i]) cube([wo,xy+1,hs-hw*2],true);

// Interval
for (i=[0:hs:h-hs])
translate([0,0,hs+i]) cube([xy+1,xy+1,rzh],true);

for (i=[0:hs:h-hs]) {
        // Text % on Main Tower
        translate([-xy/2,0,hw+i]) rotate([90,0,-90]) linear_extrude(height=0.8, center=true) text(str(ns[i/hs]), size=fontMain, valign="bottom", halign="center");

        translate([+xy/2,0,hw+i]) rotate([90,0,90]) linear_extrude(height=0.8, center=true) text(str(ns[i/hs]), size=fontMain, valign="bottom", halign="center");
    
        // Chamfer Int
        color("red",1.0)
        for (yi=[-xy/2,xy/2])
        for (xii=[-w/2,w/2])
        translate([-xii,yi,hs/2+i]) rotate([0,0,45]) cube([fs,fs,hs-hw*2],true);
} // for

// Chamfer Ext
color("blue",1.0)
for (ri=[0,90,180,270]) rotate([0,0,ri])
translate([-xy/2,-xy/2,h/2]) rotate([0,0,45]) cube([fs,fs,h+1],true);

} // df


} // mod

module flowtowerpin() {
union(){
difference(){
union(){   
translate([0,-xy/2-w5/2,h/2]) cube([xy,w5,h],true);
for (i=[0:hs:h-hs])
translate([0,0,hs/2+i]) cube([w,xy,hs-hw*2-lay*6],true);
} //un

for (i=[0:hs:h-hs])
translate([0,0,hs+i]) cube([xy+w5*2+1,xy+w5*2+1,rzh],true);

// Pin Chamfer 
for (xii=[-w/2,w/2])
translate([xii,xy/2,h/2]) rotate([0,0,45]) cube([fsp,fsp,h],true);

for (i=[0:hs:h-hs]) {
for (ri=[0]) rotate([0,0,ri])
translate([0,-xy/2-w5,hs/2+i]) rotate([90,0,0]) linear_extrude(height=0.5, center=true) text(str(ns[i/hs]), size=fontSub, valign="center", halign="center");
}

translate([0,-xy/2-w5/2,0])
// Back Pin Chamfer 
for (my=[0,1]) mirror([0,my,0])
for (mx=[0,1]) mirror([mx,0,0])
translate([-xy/2,-w5/2,h/2]) rotate([0,0,45]) cube([fs,fs,h+1],true);


} // df
//base support
color("red",1.0)    
translate([0,lay*4,lay]) cube([w+spw*2,xy,lay*2],true);
}

//Support
color("red",1.0)
for (i=[0:hs:h-hs]) {
translate([0,0,hs/2+i])
for (mz=[0,1]) mirror([0,0,mz]) {
for (yi=[0:spi:xy-spi])
if (!(i==h-hs && mz==1))
translate([0,(xy/2-spw/2-yi)-(fs/2),-hs/2+hw/2+lay*2/2]) cube([w+spw,spw,hw+lay*2],true);
} // for
} // for

} // mod

//Main bloc
flowtowerMain();

//Pin bloc
translate([0,-xy-5,0]) flowtowerpin();



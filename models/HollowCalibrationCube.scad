// XYZ 20mm Hollow Calibration Cube
// Based on the design proposed by iDig3Dprinting https://www.thingiverse.com/thing:1278865
// Freely adapted by 5@xes

font = "Arial:style=Bold";

$fn=100;

cube_size = 20;
letter_size = 0.5*cube_size;
letter_height = 0.2*letter_size;

o = cube_size / 2 - letter_height / 2;

module letter(Txt) {
  color("Yellow")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}

translate([0, 0, 10]) difference() {
  color("gray") 
  cube(cube_size, center = true);
  translate([0, -o, 0]) rotate([90, 0, 0]) letter("X");
  translate([o, 0, 0]) rotate([90, 0, 90]) letter("Y");
  translate([0, 0, o])  letter("Z");
  cube((cube_size-letter_height), center = true);
}

// XYZ 20mm Hollow Calibration Cube

$fn=100;

cube_size = 20;
letter_size = 0.5*cube_size;
letter_height = 0.2*letter_size;


translate([0, 0, 10]) cube((cube_size-letter_height), center = true);


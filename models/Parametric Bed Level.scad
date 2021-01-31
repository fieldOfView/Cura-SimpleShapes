// Bed Level
// 5@axes

$fn = 20;

t_bed_width = 220;
t_bed_depth = 220;
t_bed_border = 8;
t_shape_xcount = 3;
t_shape_ycount = 3;
t_shape_xsize = 25;
t_shape_ysize = 25;
t_line_width = 1.6;
t_thickness = 0.2;


// Bed size
t_print_width = t_bed_width - t_shape_xsize - (2*t_bed_border);
t_print_depth = t_bed_depth - t_shape_ysize - (2*t_bed_border);

// Grid area
translate([t_bed_width/2,t_bed_depth/2]){
    %square([t_print_width,t_print_depth], true);
}

// Print area
translate([t_bed_width/2,t_bed_depth/2]){
    %square([t_bed_width-(2*t_bed_border),t_bed_depth-(2*t_bed_border)], true);
}

linear_extrude(height = t_thickness) { 
    // shift everything to center in print area
    translate([(t_shape_xsize/2)+t_bed_border,(t_shape_ysize/2)+t_bed_border,0]){
        // intervals between printed shapes
        t_increment_x = t_print_width / (t_shape_xcount-1);
        t_increment_y = t_print_depth / (t_shape_ycount-1);

        // draw grid
        // draw horizontal lines along X axis
        for(t_curr_x = [0:t_shape_xcount-1]){
            translate([t_center_x, t_print_depth/2, 0]){
                square([t_line_width,t_print_depth], true);
            }
            t_center_x = t_curr_x * t_increment_x;
        }
        // draw vertical lines along Y axis
        for(t_curr_y = [0:t_shape_ycount-1]){
            translate([t_print_width/2, t_center_y, 0]){
                square([t_print_width, t_line_width], true);
            }
            t_center_y = t_curr_y * t_increment_y;
        }
        
        // draw shapes
        for(t_curr_x = [0:t_shape_xcount-1]){
            for(t_curr_y = [0:t_shape_ycount-1]){
                translate([t_center_x,t_center_y]){
                    square([t_shape_xsize,t_shape_ysize],true);
                }
                t_center_y = t_curr_y * t_increment_y;
            }
            t_center_x = t_curr_x * t_increment_x;
        }
    }
}
// Bed Level
// 5@axes

$fn = 20;

t_bed_width = 100;
t_bed_depth = 100;
t_bed_border = 4;
t_shape_xcount = 3;
t_shape_ycount = 3;
t_shape_xsize = 10;
t_shape_ysize = 10;
t_line_width = 0.8;
t_thickness = 0.21;


// Bed size
t_print_width = t_bed_width - t_shape_xsize - (2*t_bed_border);
t_print_depth = t_bed_depth - t_shape_ysize - (2*t_bed_border);


rotate(90,[-1, 0, 0]) translate([-t_bed_width*0.5, -t_bed_depth*0.5, 0]) linear_extrude(height = t_thickness) { 
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
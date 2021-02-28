// Bed Level
// 5@axes
// Size must be set to 100/100 final shape will be scaled by the plugin 

$fn = 40;

bed_width = 100;
bed_depth = 100;
bed_border = 4;
square_xcount = 3;
square_ycount = 3;
square_size = 10;
line_width = 0.8;
thickness = 0.21;


// Build plate size
print_width = bed_width - square_size - (2*bed_border);
print_depth = bed_depth - square_size - (2*bed_border);


translate([-bed_width*0.5, -bed_depth*0.5, 0]) linear_extrude(height = thickness) { 
    // translate everything to center in print area
    translate([(square_size/2)+bed_border,(square_size/2)+bed_border,0]){
        // intervals between printed shapes
        incremenx = print_width / (square_xcount-1);
        incremeny = print_depth / (square_ycount-1);

        // draw connection lines along X axis
        for(curr_x = [0:square_xcount-1]){
            translate([center_x, print_depth/2, 0]){
                square([line_width,print_depth], true);
            }
            center_x = curr_x * incremenx;
        }
        // draw connection lines along Y axis
        for(curr_y = [0:square_ycount-1]){
            translate([print_width/2, center_y, 0]){
                square([print_width, line_width], true);
            }
            center_y = curr_y * incremeny;
        }
        // draw square shapes
        for(curr_x = [0:square_xcount-1]){
            for(curr_y = [0:square_ycount-1]){
                translate([center_x,center_y]){
                    square([square_size,square_size],true);
                    //circle(d=square_size);
                }
                center_y = curr_y * incremeny;
            }
            center_x = curr_x * incremenx;
        }
    }
}
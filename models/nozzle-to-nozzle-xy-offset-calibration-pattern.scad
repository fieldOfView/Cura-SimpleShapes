/**
 *
 * Run:
 *
 *    openscad <file_name>.scad
 *    openscad [options] <file_name>.scad
 *
 * Options with -D <var=val>:
 * 
 *    teeth_count      number of teeth, recommended: 10 for positive offset + 10 for negative offset + 1 center = 21
 *    tooth_width      width of one single tooth
 *    tooth_height     height of teeth / comb, should be n * layer_height
 *    tooth_length     length of one single tooth
 *    teeth_gap        space in between teeth of the unscaled comb
 *    comb_clearance   comb to comb distance, should not be > (2 * tooth_width)
 *    base_height      comb base (optional), set to 0 to disable
 *    render_mode      0 ... all, 1 ... verification comb + base, 2 ... alignment comb
 *    extra_clearance  deprecated: extra clearance in case the comb pairs overlap (usually on small twidth and/or tgap)
 * 
 */

// Author : rubienr (https://github.com/rubienr)
// Source : https://github.com/rubienr/cad/blob/master/creality-ender-5-plus/printer-test-objects/nozzle-to-nozzle-offset-calibration-pattern/nozzle-to-nozzle-xy-offset-calibration-pattern.scad
// Origin : https://github.com/5axes/Calibration-Shapes/issues/15
// ------------------------------------------------------------------------------------------------------------------------

module drawComb (
    _num_teeth, 
    _teeth_gap,
    _tooth_width,
    _tooth_height,
    _tooth_length,
    _base_height,
    _render_mode) // 3 ... none, 4 ... bed only, 5 ... comb only, 6 ... all
{
  
  // base for better adhesion (optional)
  if (_base_height > 0 && (_render_mode == 4 || _render_mode == 6)) 
  {
    _comb_length = (_num_teeth - 1) * _teeth_gap + (_num_teeth + 2) * _tooth_width;
    _comb_width  =  _tooth_width + _tooth_length + 2 * _tooth_width;
    
    color("grey")
      translate ([-_tooth_width, -2*_tooth_width, 0])
        cube([_comb_length, _comb_width, _base_height]);
  }

  // comb
  if (_render_mode == 5 || _render_mode == 6) 
  {
    color_value = _render_mode == 1 ? "blue": (_render_mode == 2 ? "red" : "orange");
  
    // teeth
    for (t = [0:_num_teeth-1]) 
    {
      let (translation = [t * (_teeth_gap + _tooth_width), 0, _base_height])
      {
        translate (translation) color(color_value) cube ([_tooth_width, _tooth_length, _tooth_height], false);
        
        // center tooth mark
        if (t == (((_num_teeth - 1) / 2)))
        {
          translate (translation + [0, -_tooth_width, _tooth_height]) color(color_value) cube ([_tooth_width, _tooth_length / 2 + _tooth_width, _tooth_height]);
        }
      }
    }
    
    // comb back
    translate ([0, - _tooth_width, _base_height]) 
      color(color_value) 
        cube ([_num_teeth * _tooth_width + (_num_teeth - 1) * _teeth_gap, _tooth_width, _tooth_height], false);      
  }
}

// ------------------------------------------------------------------------------------------------------------------------

module drawCombPair(
    _teeth_count, 
    _teeth_gap,
    _tooth_width,
    _tooth_height,
    _tooth_length,
    _comb_clearance,
    _base_height,
    _render_mode) 
{
  _comb_displacement = [0, -_tooth_length - (_comb_clearance / 2), 0];
  _second_comb_teeth_displacement = _teeth_gap / ((_teeth_count - 1) / 2);
  _second_comb_teeth_gap = _teeth_gap + _second_comb_teeth_displacement;
  _second_comb_displacement = [-_teeth_gap, 0 , 0];

  // default comb
    translate(_comb_displacement)
      drawComb(_teeth_count, _teeth_gap, _tooth_width, _tooth_height, _tooth_length, _base_height,  
        _render_mode == 0 ? 6 :             // all
          (_render_mode == 2 ? 5 :          // comb only
            (_render_mode == 1 ? 4 : 3)));  // bed only

  // verification comb (stretched)
    mirror ([0,1,0]) 
      translate (_second_comb_displacement) // sync middle tooth with default comb 
        translate(_comb_displacement)
          drawComb(_teeth_count, _second_comb_teeth_gap, _tooth_width, _tooth_height, _tooth_length, _base_height, 
            _render_mode == 0 ? 6 :          // all
              (_render_mode == 1 ? 6 : 3));  // comb and bed
}

// ------------------------------------------------------------------------------------------------------------------------

module drawXYCalibrationCombs( 
    _teeth_count, 
    _teeth_gap,
    _tooth_width,
    _tooth_height,
    _tooth_length,
    _comb_clearance,
    _base_height,
    _render_mode,
    _extra_clearance) 
{
  _comb_width = _tooth_length + _tooth_width + _comb_clearance / 2;
  _t_x = [_comb_width + 2 * _tooth_width + _extra_clearance , 0, 0];
  _t_y = [0, -_comb_width + _tooth_width, 0];
  _r_y = [0, 0, 90];
  
  // X aligned comb pair
  translate(_t_x)
    drawCombPair(_teeth_count, _teeth_gap, _tooth_width, _tooth_height, _tooth_length, _comb_clearance, _base_height, _render_mode);

  // Y aligned comb pair
  translate(_t_y)
    rotate(_r_y) 
      drawCombPair(_teeth_count, _teeth_gap, _tooth_width, _tooth_height, _tooth_length, _comb_clearance, _base_height, _render_mode); 
}

// ------------------------------------------------------------------------------------------------------------------------

module draw()
{
  teeth_count    = is_undef(teeth_count)    ?  21 : teeth_count;     // number of teeth, recommended: 10 for positive offset + 10 for negative offset + 1 center = 21
  tooth_width    = is_undef(tooth_width)    ?   2 : tooth_width;     // width of one single tooth
  tooth_height   = is_undef(tooth_height)   ? 0.2 : tooth_height;    // height of teeth / comb, should be n * layer_height
  tooth_length   = is_undef(tooth_length)   ?  10 : tooth_length;    // length of one single tooth
  teeth_gap      = is_undef(teeth_gap)      ?   2 : teeth_gap;       // space in between teeth of the unscaled comb
  comb_clearance = is_undef(comb_clearance) ?   1 : comb_clearance;  // comb to comb distance, should not be > (2 * tooth_width)
  base_height    = is_undef(base_height)    ?   0 : base_height;     // comb base (optional), set to 0 to disable
  render_mode    = is_undef(render_mode)    ?   0 : render_mode;     // 0 ... all, 1 ... verification comb + base, 2 ... alignment comb; (>= 3 ... reserved for internal usage)
  
  // TODO rr - remove the need of the extra_clearance parameter: swap draw order (draw verification comb first, then align the default one)
  extra_clearance = is_undef(extra_clearance) ? 0 : extra_clearance; // extra clearance in case the comb pairs overlap (usually on small twidth and/or tgap)
  
  assert(teeth_count % 2 == 1, "An odd number of teeth is required.");
  drawXYCalibrationCombs(teeth_count, teeth_gap, tooth_width, tooth_height, tooth_length, comb_clearance, base_height, render_mode, extra_clearance);
}

// ------------------------------------------------------------------------------------------------------------------------
// Translate to center the part
translate([-44,-30.5,0]) draw();
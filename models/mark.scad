//------------------------------------------------------
// Mark
// Simple texte
// 5@xes 04/03/2022
//------------------------------------------------------

$fn=120;
// font = "Roboto:style=Bold";
// font = "Leelawadee:style=Bold";
font = "Gill Sans MT:style=Bold";

letter_height = 0.8;
letter_size =10;

translate([0,0,0]) letter("8");


module letter(Txt) {
  color("Red")
  linear_extrude(height = letter_height) {
    text(Txt, size = letter_size, font = font, halign = "center", valign = "center");
  }
}                
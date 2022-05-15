use <polyScrewThread_r2.scad>
use <mirrorCopy.scad>
include <mcad/units.scad>

module nuts_and_bolts() {
  outer_diameter = 8;
  head_height = 4;
  step = 2;
  step_shape_degrees = 45;
  distance_across_flats = 12;
  distance_across_corners = 13.8;
  threaded_length = 35;
  res = 1;
  hex_screw(
    outer_diameter, // Outer diameter of the thread
    step, // Thread step
    step_shape_degrees, // Step shape degrees
    threaded_length, // Length of the threaded section of the screw
    res, // Resolution (face at each 2mm of the perimeter)
    1, // Countersink in both ends
    distance_across_flats, // Distance between flats for the hex head
    head_height, // Height of the hex head (can be zero)
    0, // Length of the non threaded section of the screw
    0 // Diameter for the non threaded section of the screw
  );
  // translate([distance_across_corners + 5, 0, 0])
  // hex_nut(
  //   distance_across_flats, // Distance between flats
  //   head_height, // Height
  //   step, // Step height (the half will be used to countersink the ends)
  //   step_shape_degrees, // Degrees (same as used for the screw_thread example)
  //   outer_diameter, // Outer diameter of the thread to match
  //   res // Resolution, you may want to set this to small values
  // );
}
nuts_and_bolts();

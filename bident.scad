use <missile/missile.scad>
use <mirrorCopy.scad>
use <mcad/polyholes.scad>
include <mcad/units.scad>
use <polyScrewThread_r2.scad>
use <mcad/regular_shapes.scad>
// Clamp dims
hClamp = 14;
sClamp = 0.75;

// Tip dims
hCone = 5;
rCone = 2;
hCylinder = 40;

module tip(cH = 1, cR = 1, cyH = 1, centered = true) {
  union(){
    translate([0, 0, -cH - 0.001]) {
      cone(height = cH, radius = cR, center = centered);
      translate([0, 0, -cyH + 0.001])
      cylinder(cyH, cR, cR, center = centered);
    }
  }
}

module clamp() {
  mirrorCopy(Z) {
    difference() {
      linear_extrude(height = hClamp, scale=[sClamp, sClamp])
      import("bidentProj.svg", dpi = 96, center = true);
      translate([0, 0, -5])
      resize([48, 0, 0])
      polyhole(36, 12);
      rotate([90, 0, 0]) {
        translate([-12, 0, -hClamp]) polyhole(100, hClamp * sClamp / 2);
        translate([ 12, 0, -hClamp]) polyhole(100, hClamp * sClamp / 2);
      }
      echo(str("clamp hole diameter = ", hClamp * sClamp / 2, " mm"));
    };
  }
}
module nuts_and_bolts() {
  outer_diameter = 4.9;
  head_height = 3.6;
  step = 2;
  step_shape_degrees = 45;
  distance_across_flats = 7.95;
  distance_across_corners = 9.2;
  hex_screw(
    outer_diameter, // Outer diameter of the thread
    step, // Thread step
    step_shape_degrees, // Step shape degrees
    35, // Length of the threaded section of the screw
    2, // Resolution (face at each 2mm of the perimeter)
    2, // Countersink in both ends
    distance_across_flats, // Distance between flats for the hex head
    head_height, // Height of the hex head (can be zero)
    0, // Length of the non threaded section of the screw
    0 // Diameter for the non threaded section of the screw
  );
  translate([distance_across_corners + 5, 0, 0])
  hex_nut(
    distance_across_flats, // Distance between flats
    head_height, // Height
    step, // Step height (the half will be used to countersink the ends)
    step_shape_degrees, // Degrees (same as used for the screw_thread example)
    outer_diameter, // Outer diameter of the thread to match
    2 // Resolution, you may want to set this to small values
  );
}


module main() {
  union() {
    clamp();
    mirrorCopy(X) {
      translate([17, 8, hCylinder +5])
      tip(hCone, rCone, hCylinder, false);
    }
  }
  mirrorCopy(X) {
    translate([40, 0, 0])
    nuts_and_bolts();
  }
}

main();

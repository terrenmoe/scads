include <mcad/units.scad>
use <mcad/regular_shapes.scad>

// Tip dims
// hCone = 16;
// rCone = 8;
// hCylinder = 40;

module spike(cH = 1, cR = 1, cyH = 1, centered = true) {
  union() {
    translate([0, 0, cH/2 - epsilon])
    cone(height = cH, radius = cR, center = centered);
    translate([0, 0, -cyH/2 + epsilon])
    cylinder(cyH, cR, cR, center = centered);
  }
}

// spike(cH = hCone, cR = rCone, cyH = hCylinder, centered=true);

use <mirrorCopy.scad>
use <mcad/polyholes.scad>
include <mcad/units.scad>
use <mcad/regular_shapes.scad>

// Clamp dims
hClamp = 14;
sClamp = 0.75;

// Tip dims
hCone = 8;
rCone = 4;
hCylinder = 20;

module tip(cH = 1, cR = 1, cyH = 1, centered = true) {
  union() {
    translate([0, 0, -cH - epsilon]) {
      cone(height = cH, radius = cR, center = centered);
      translate([0, 0, -cyH + epsilon])
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
      union() {
        cube([50, 5, 40], center=true);
        resize([30, 0, 0])
        polyhole(36, 12);
      }
      echo(str("Clamp hole diameter = ", hClamp * sClamp, " mm"));
    };
  }
}

module main() {
  difference() {
    union() {
      clamp();
      mirrorCopy(X) {
        translate([14.5, 7, hCylinder + 5])
        tip(hCone, rCone, hCylinder, false);
      }
    }
    rotate([90, 0, 0]) {
      translate([-15.5, 0, -hClamp]) polyhole(100, hClamp * sClamp / 2);
      translate([ 15.5, 0, -hClamp]) polyhole(100, hClamp * sClamp / 2);
    }
  }
}
scale(2)
main();

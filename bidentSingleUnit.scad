use <offset_3d.scad>
use <spike.scad>
include <mcad/units.scad>
use <mcad/regular_shapes.scad>
use <mcad/utilities.scad>
use <missile/missile.scad>
use <mirrorCopy.scad>

// echo(str("1 inch is ", i2mm(1), " mm"));
out_len = i2mm([1.25, 2.75, 6]);
in_len = i2mm([0.75, 1 + 67/128, 4]);
$fn = 12;
// Tip dims
hCone = 12;
rCone = out_len.x / 8;
hCylinder = 30;

// ellipse(width = out_len.x, height = out_len.y);
// oval_prism(height = 10, rx = out_len.x, ry = out_len.y, center = true);

difference() {
  union() {
    cylinder(h = out_len[2], d2 = out_len[0], d1 = out_len[1], center=true);
    offset_3d(r = 1, size = 100)
    union() {
      translate(out_len.z * Z / 2)
      sphere(d = out_len.x);
      mirrorCopy(Y)
      translate([0, out_len.x / 3, (out_len.x + out_len.z) / 1.7])
      spike(cH = hCone, cR = rCone, cyH = hCylinder, centered=true);
    }
  }
  translate(-out_len.z * Z / 1.96)
  linear_extrude(height = in_len.z + epsilon, scale = [1, 63/64])
  square(reverse(tail(reverse(in_len))), center = true);
}
// echo(reverse(tail(reverse(in_len))));  //* which_axis("xy"));
// echo([0, out_len.x / 8, (out_len.x + out_len.z) / 1.5]);  //* which_axis("xy"));
// in_len[1]/in_len[0]
// https://reprap.org/wiki/Triffid_Hunter%27s_Calibration_Guide

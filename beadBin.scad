use <lineUp.scad>
use <mcad/utilities.scad>
use <mcad/regular_shapes.scad>
use <mirrorCopy.scad>

octoH = 76;
octoR = 1.2;
$fn=6;
union(){
  // sidewalls
  linear_extrude(height = 5, scale=[1.2, 1.2])
  import("beadBin.svg", dpi = 96, center = true);

  // base plate
  translate([0, 0, -1])
  linear_extrude(height = 2, scale=[1.01, 1.01])
  import("beadBin2.svg", dpi = 96, center = true);
  // octoribs
  rotate([0, 90, 0])
  translate([0, 0, -35]){
    mirrorCopy([0, 1, 0]){
      difference(){
        for (i = [0 : 5]){
          translate([0, -i*4, i*4]){
            octagon_prism(height = octoH -i * 4, radius = octoR);
          }
        };
        translate([0.5, -octoH + 10, -1])
        cube([50, octoH, 88]);
      }
    }
  }
}

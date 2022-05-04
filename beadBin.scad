use <lineUp.scad>
use <mcad/utilities.scad>

baseShapeHeight = 10;
origin = [0, 0];
common = [56, 126];
max_points = [56, 136];
cylinderHeight = 100;
cylinderD1 = 0.4;
cylinderD2 = 0.4;
spacing = 4;
numOfCylinders = 13;
rotationVector = [270, 90, 0];
translationVector = [-6.5, -spacing * numOfCylinders, 0];
$fa = 1;
$fs = 8;

nose_points = [
  [origin.x, common.y],
  common,
  [39, max_points.y],
  [19, max_points.y]
];

sq_points = [
  origin,
  [common.x, origin.y],
  common,
  [origin.x, common.y]
];

module baseShape(h = 0) {
  linear_extrude(
    slices = 2,
    twist = 0,
    height = baseShapeHeight + h,
    convexity = 3,
    scale = [1, 12/16]
  )
  union() {
    polygon(nose_points);
    polygon(sq_points);
  }
}

module binShape() {
  difference() {
    baseShape();
    scale([0.99, 1.08, 63/64])
    translate([0.25, 0.15, -3.5])
    baseShape();
  }
}

module mainShape() {
  union() {
    binShape();
    rotate(rotationVector) {
      lineUp(numOfCylinders, spacing, "y", translationVector) {
         intersection(){
           resize([0, 2, 0]) translate([0, -0.5, 0.5])
           cube(size = [cylinderD1, cylinderD2 * 1.5, cylinderHeight - 0.1], center = false);
           translate([0, 0, 0.5])
           cylinder(cylinderHeight - 0.1, cylinderD1, cylinderD2, $fn = 6);
        }
      }
    };
  }
}

mainShape();

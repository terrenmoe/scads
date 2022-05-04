use <lineUp.scad>
use <mcad/utilities.scad>

baseShapeHeight = 10;
eps = 0.001;
origin = [0, 0];
common = [48, 70];
max_points=[48, 85];
cylinderHeight = 50;
cylinderD1 = 0.5;
cylinderD2 = 0.5;
spacing = 4;
numOfCylinders = 11;
rotationVector = [270, 90, 0];
translationVector = [-6.5, -spacing * numOfCylinders, 0];
nose_points = [
  [origin.x, common.y],
  common,
  [29, max_points.y],
  [19, max_points.y]
];

sq_points = [
  origin,
  [common.x, origin.y],
  common,
  [origin.x, common.y]
];

module baseShape(h=0) {
  linear_extrude(,
    slices = 10,
    twist = 0,
    height = baseShapeHeight + h,
    convexity = 10,
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
      scale([0.99, 1.05, 63/64])
      translate([0.25, 0.15, -3.5])
      baseShape();
    }
}

// create constant for number of cylinders and use it in spacing calc with distance from utilites
module mainShape() {
  union() {
    binShape();
    rotate(rotationVector) {
      lineUp(numOfCylinders, spacing, "y", translationVector) {
         intersection(){
           resize([0,2,0]) translate([0,-0.5,0])
           cube(size=[cylinderD1, cylinderD2*1.5, cylinderHeight], center=false);
           cylinder(cylinderHeight, cylinderD1, cylinderD2, $fn = 12);
        }
      }
    };
  }
}

mainShape();

include <mcad/utilities.scad>
include <mcad/regular_shapes.scad>
include <transpose.scad>
include <missile/missile.scad>

base = [10,10,10];
function dia(r) = ((r * 2)^2 / 2) ^ 0.5;
echo(dia(1));

//basic 2d profile used for fillet shape
module profile(radius) {
  difference()
  {
    square(radius);
    circle(r=radius);
  }
}

// $fn = 30;
  // linear_extrude(
  //   4,
  //   center=true,
  //   convexity=10,
  //   twist=360,
  //   slices=20,
  //   scale=[0.6, 0.2],
  //   $fs=0.2,
  //   $fa=0.8
  // )
  // profile(1);

echo(
  str("\n distance = ", distance([2,2,2], base)),
  str("\n length2 = ", length2(base)),
  str("\n normalized10 = ", normalized(base * 10)),
  str("\n normalized25 = ", normalized(base * 25)),
  str("\n normalized10 = ", normalized(base * -10)),
  str("\n normalized25 = ", normalized(base * -25)),
  str("\n normalized distance = ", distance(normalized(base), normalized([5,2,1])))
);

// minkowski(convexity = 10) {
  //   $fn=6;
  //   difference() {
  //     cube(base, center = true);
  //     linear_extrude(2)
  //     nonagon(7, $fn=9);
  //   }
  //   sphere(20);
// }

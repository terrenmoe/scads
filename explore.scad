include <mcad/utilities.scad>

base = [10,10,10];

//basic 2d profile used for fillet shape
module profile(radius) {
  difference()
  {
    square(radius);
    circle(r=radius);
  }
}
// $fn = 30;
linear_extrude(
  4,
  center=true,
  convexity=10,
  twist=360,
  slices=20,
  scale=[0.6, 0.2],
  $fs=0.2,
  $fa=0.8
)
profile(1);
echo(
  str("\n distance = ", distance([2,2,2], base)),
  str("\n length2 = ", length2(base)),
  str("\n normalized10 = ", normalized(base * 10)),
  str("\n normalized25 = ", normalized(base * 25)),
  str("\n normalized10 = ", normalized(base * -10)),
  str("\n normalized25 = ", normalized(base * -25)),
  str("\n normalized distance = ", distance(normalized(base), normalized([5,2,1])))
);

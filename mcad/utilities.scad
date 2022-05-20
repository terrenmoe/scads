/*
 * Utility functions.
 *
 * Originally by Hans Häggström, 2010.
 * Dual licenced under Creative Commons Attribution-Share Alike 3.0 and LGPL2 or later
 */

include <units.scad>
function dia(r) = ((r * 2)^2 / 2) ^ 0.5;
function i2mm(inches) = inches * mm_per_inch;
function squ(a) = a * a;
function which_axis(axis = "x") = [
  len(search("x", axis, 1)),
  len(search("y", axis, 1)),
  len(search("z", axis, 1))
];
// Takes 2 3d vectors and returns
// the square root of
//   the summation of
//     the squares of
//       the diffs of
// cooresponding coordinates from each vector.
function distance(a, b) = sqrt(
  squ(a[0] - b[0]) + // (a[0] - b[0])² +
  squ(a[1] - b[1]) + // (a[1] - b[1])² +
  squ(a[2] - b[2])   // (a[2] - b[2])² =
);

// Takes 1 2d vector
function length2(a) = sqrt( squ(a[0]) + squ(a[1]) );

// max is used to handle rounding errors in division by 0

function normalized(a) = a / (max(distance([0,0,0], a), 0.00001));

function normalized_axis(a) = a == "x" ? X:
                   a == "y" ? Y:
                   a == "z" ? Z: normalized(a);

function angleOfNormalizedVector(n) = [0, -atan2(n[2], length2([n[0], n[1]])), atan2(n[1], n[0]) ];

function angle(v) = angleOfNormalizedVector(normalized(v));

function angleBetweenTwoPoints(a, b) = angle(normalized(b-a));


CENTER = 0;
LEFT = -0.5;
RIGHT = 0.5;
TOP = 0.5;
BOTTOM = -0.5;

FlatCap =0;
ExtendedCap =0.5;
CutCap =-0.5;


module fromTo(from=[0,0,0], to=[1*m,0,0], size=[1*cm, 1*cm], align=[CENTER, CENTER], material=[0.5, 0.5, 0.5], name="", endExtras=[0,0], endCaps=[FlatCap, FlatCap], rotation=[0,0,0], printString=true) {

  angle = angleBetweenTwoPoints(from, to);
  length = distance(from, to) + endCaps[0]*size[0] + endCaps[1]*size[0] + endExtras[0] + endExtras[1];

  if (length > 0) {
    if (printString) echo(str("  " ,name, " ", size[0], "mm x ", size[1], "mm, length ",length,"mm"));

    color(material)
      translate(from)
        rotate(angle)
          translate( [ -endCaps[0]*size[0] - endExtras[0], size[0]*(-0.5-align[0]), size[1]*(-0.5+align[1]) ] )
            rotate(rotation)
              scale([length, size[0], size[1]]) children();
  }
}

module part(name) {
  echo("");
  echo(str(name, ":"));
}

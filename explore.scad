include <utilities.scad>

base = [1, 2, 5];

echo(
  str("\n distance = ", distance([0, 0, 0], base)),
  str("\n length2 = ", length2(base)),
  str("\n normalized10 = ", normalized(base * 10)),
  str("\n normalized25 = ", normalized(base * 25)),
  str("\n normalized10 = ", normalized(base * -10)),
  str("\n normalized25 = ", normalized(base * -25)),
  str("\n normalized distance = ", distance(normalized(base), normalized([5,2,1])))
);

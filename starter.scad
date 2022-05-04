SIZE = [10, 10];
$fn = 25;
module extrude_square(size = [1, 1], center = true) {
  linear_extrude(
    height = size.x,
    center = center,
    convexity = 10,
    twist = 360,
    // segments = 1,
    scale = [2, 1/2],
    slices = 10
  ) {
    translate(size) {
      scale(size)
      intersection() {
          polygon(points = [
            [0, 0],
            [0, 1],
            [2.25, 2.25],
            [2.25, -1]
        ]);
      square(size = size, center = center);
      square(size = size.x, center = center);
      circle(d = size * 2);
      }
    }
  }
}

extrude_square(size = SIZE);

// lineUp uses children(0) to get the first child passed to the module
//+ to create a line-up.

function whichAxis(axis = "x") = [
  len(search("x", axis, 1)),
  len(search("y", axis, 1)),
  len(search("z", axis, 1))
];

module lineUp(
  num = 2,
  space = 1,
  axis = "x",
  offsetVector = [0, 0, 0],
  scalar = [1, 1, 1]
) {
  // echo(num, space, whichAxis(axis));
  if (num > 1) {
    for (i = [0 : num - 1])
      scale(scalar * whichAxis(axis))
      translate(offsetVector + whichAxis(axis) * (space * i))
      children(0);
  } else {
    echo ("num must be positive but is :", num);
  }
}

// size = [10, 10, 10];
// lineUp(10, 10, "x  "){cube(size=size, center = true);}
// lineUp(10, 10, "  z"){cube(size=size, center = true);}
// lineUp(10, 10, " y "){cube(size=size, center = true);}
// lineUp(10, 10, "xy "){cube(size=size, center = true);}
// lineUp(10, 10, " yz"){cube(size=size, center = true);}
// lineUp(10, 10, "x z"){cube(size=size, center = true);}
// lineUp(10, 10, "xyz"){cube(size=size, center = true);}

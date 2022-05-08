use <unit.scad>
use <transpose.scad>
use <identity.scad>

// computes the rotation with minimum angle that brings a to b
// the code fails if a and b are opposed to each other
function rotate_from_to(a,b) =
  let( axis = unit(cross(a,b)) )
  axis*axis >= 0.99 ?
    transpose([unit(b), axis, cross(axis, unit(b))]) *
      [unit(a), axis, cross(axis, unit(a))] :
    identity(3);

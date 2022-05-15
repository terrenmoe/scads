/*
 *  polyScrewThread_r1.scad  by aubenc @ Thingiverse
 *
 * Modified by mike_mattala @ Thingiverse 1/1/2017 to remove deprecated assign
 * Modified by Alex Rossiter @ Real Life 5/22/2022 to clean this mess up ;-P
 *
 * This script contains the library modules that can be used to generate
 * threaded rods, screws and nuts.
 *
 * http://www.thingiverse.com/thing:8796
 *
 * CC Public Domain
 */

TAU = 2*PI;
EPSILON = 0.01;
FACETS=6;
function half(n) = n / 2;
function cos_over_sin(angle) = cos(angle)/sin(angle);
// Outer diameter of the thread
// Step, traveling length per turn, also, tooth height, whatever...
// Degrees for the shape of the tooth (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
// Length (Z) of the tread
// Resolution, one face each "PI/2" mm of the perimeter,
// Countersink style:
    //  -2 - Not even flat ends
    //  -1 - Bottom (countersink'd and top flat)
    //   0 - None (top and bottom flat)
    //   1 - Top (bottom flat)
    //   2 - Both (countersink'd)
module screw_thread(outer_diameter,step,step_shape_angle,length_thread,res,countersink) {
  outer_radius=outer_diameter/2;
  inner_radius=outer_radius-step/2*cos_over_sin(step_shape_angle);
  pf=TAU*outer_radius;
  sn=floor(pf/res);
  lfxy=360/sn;
  ttn=round(length_thread/step+1);
  zt=step/sn;

  intersection() {
    if (countersink >= -1) thread_shape(countersink,length_thread,outer_radius,inner_radius,sn,step);
    full_thread(ttn,step,sn,zt,lfxy,outer_radius,inner_radius);
  }
}

// Distance between flats
// Height
// Step height (the half will be used to countersink the ends)
// Degrees (same as used for the screw_thread example)
// Outer diameter of the thread to match
// Resolution, you may want to set this to small values
// (quite high res) to minimize overhang issues
module hex_nut(distance_across_flats,height,sth,clf,countersink_outer_diameter,crs) {
  difference() {
    hex_head(height,distance_across_flats);

    hex_countersink_ends(sth/2,countersink_outer_diameter,clf,crs,height);

    screw_thread(countersink_outer_diameter,sth,clf,height,crs,-2);
  }
}

// Outer diameter of the thread
// Thread step
// Step shape degrees
// Length of the threaded section of the screw
// Resolution (face at each 2mm of the perimeter)
// Countersink in both ends
// Distance between flats for the hex head
// Height of the hex head (can be zero)
// Length of the non threaded section of the screw
// Diameter for the non threaded section of the screw
  //    -1 - Same as inner diameter of the thread
  //     0 - Same as outer diameter of the thread
  // value - The given value
module hex_screw(outer_diameter,step,step_shape_angle,lt,res,cs,distance_across_flats,height,non_threaded_length,non_threaded_diameter) {
  not_threaded_radius=outer_diameter/2-(step/2)*cos_over_sin(step_shape_angle);

  union() {
    hex_head(height,distance_across_flats);
    translate([0,0,height])
    if ( non_threaded_length == 0 ) cylinder(h=EPSILON, r=not_threaded_radius, center=true);
    else if ( non_threaded_diameter == -1 ) cylinder(h=non_threaded_length+EPSILON, r=not_threaded_radius, $fn=floor(outer_diameter*PI/res), center=false);
    else if ( non_threaded_diameter == 0 ) union() {
      cylinder(h=non_threaded_length-step/2, r=outer_diameter/2, $fn=floor(outer_diameter*PI/res), center=false);
      translate([0,0,non_threaded_length-step/2])
      cylinder(h=step/2, r1=outer_diameter/2, r2=not_threaded_radius, $fn=floor(outer_diameter*PI/res), center=false);
    } else cylinder(h=non_threaded_length, r=non_threaded_diameter/2, $fn=non_threaded_diameter*PI/res, center=false);
    translate([0,0,non_threaded_length+height]) screw_thread(outer_diameter,step,step_shape_angle,lt,res,cs);
  }
}

module hex_screw_0(outer_diameter,step,step_shape_angle,lt,res,cs,distance_across_flats,height,non_threaded_length,non_threaded_diameter) {
  not_threaded_radius=outer_diameter/2-(step/2)*cos_over_sin(step_shape_angle);

  union() {
    hex_head_0(height,distance_across_flats);

    translate([0,0,height])
    if ( non_threaded_length == 0 )
      cylinder(h=EPSILON, r=not_threaded_radius, center=true);
    else if ( non_threaded_diameter == -1 )
      cylinder(h=non_threaded_length+EPSILON, r=not_threaded_radius, $fn=floor(outer_diameter*PI/res), center=false);
    else if ( non_threaded_diameter == 0 ) union() {
      cylinder(h=non_threaded_length-step/2, r=outer_diameter/2, $fn=floor(outer_diameter*PI/res), center=false);
      translate([0,0,non_threaded_length-step/2])
      cylinder(h=step/2, r1=outer_diameter/2, r2=not_threaded_radius, $fn=floor(outer_diameter*PI/res), center=false);
    } else cylinder(h=non_threaded_length, r=non_threaded_diameter/2, $fn=non_threaded_diameter*PI/res, center=false);
    translate([0,0,non_threaded_length+height]) screw_thread(outer_diameter,step,step_shape_angle,lt,res,cs);
  }
}

module thread_shape(cs,lt,outer_radius,inner_radius,sn,step) {
  if ( cs == 0 ) {
    cylinder(h=lt, r=outer_radius, $fn=sn, center=false);
  }
  else {
    union() {
      translate([0,0,step/2])
      cylinder(h=lt-step+0.005, r=outer_radius, $fn=sn, center=false);

      if ( cs == -1 || cs == 2 ) {
        cylinder(h=step/2, r1=inner_radius, r2=outer_radius, $fn=sn, center=false);
      }
      else {
        cylinder(h=step/2, r=outer_radius, $fn=sn, center=false);
      }

      translate([0,0,lt-step/2])
      if ( cs == 1 || cs == 2 ) {
        cylinder(h=step/2, r1=outer_radius, r2=inner_radius, $fn=sn, center=false);
      }
      else {
        cylinder(h=step/2, r=outer_radius, $fn=sn, center=false);
      }
    }
  }
}

module full_thread(ttn,step,sn,zt,lfxy,outer_radius,inner_radius) {
  if(inner_radius >= 0.2) {
    for(i=[0:ttn-1], j=[0:sn-1]) {
      pt = [
        [0, 0, i*step-step],
        [inner_radius*cos(j*lfxy), inner_radius*sin(j*lfxy), i*step+j*zt-step],
        [inner_radius*cos((j+1)*lfxy), inner_radius*sin((j+1)*lfxy), i*step+(j+1)*zt-step],
        [0, 0, i*step],
        [outer_radius*cos(j*lfxy), outer_radius*sin(j*lfxy), i*step+j*zt-step/2],
        [outer_radius*cos((j+1)*lfxy), outer_radius*sin((j+1)*lfxy), i*step+(j+1)*zt-step/2],
        [inner_radius*cos(j*lfxy), inner_radius*sin(j*lfxy), i*step+j*zt],
        [inner_radius*cos((j+1)*lfxy), inner_radius*sin((j+1)*lfxy), i*step+(j+1)*zt],
        [0, 0, i*step+step]
      ];
      polyhedron(
        points = pt,
        faces = [
          [1,0,3],
          [1,3,6],
          [6,3,8],
          [1,6,4],
          [0,1,2],
          [1,4,2],
          [2,4,5],
          [5,4,6],
          [5,6,7],
          [7,6,8],
          [7,8,3],
          [0,2,3],
          [3,2,7],
          [7,2,5]
        ]
      );
    }
  }
 else {
  echo("Step Degrees too aggressive, the thread will not be made!!");
  echo("Try to increase de value for the degrees and/or...");
  echo(" decrease the pitch value and/or...");
  echo(" increase the outer diameter value.");
 }
}

module hex_head(height,distance_across_flats) {
  rd0=distance_across_flats/2/sin(60);

  x0=0;
  x1=distance_across_flats/2;
  x2=x1+height/2;

  y0=0;
  y1=height/2;
  y2=height;
  intersection() {
    cylinder(h=height, r=rd0, $fn=FACETS, center=false);
    rotate_extrude(convexity=10, $fn=FACETS*round(distance_across_flats*TAU/6))
    polygon([
      [x0,y0],
      [x1,y0],
      [x2,y1],
      [x1,y2],
      [x0,y2]
    ]);
  }
}

module hex_head_0(height,distance_across_flats) {
  cylinder(h=height, r=distance_across_flats/2/sin(60), $fn=6, center=false);
}

module hex_countersink_ends(countersink_height,countersink_outer_diameter,clf,crs,height) {
  translate([0,0,-0.1])
  cylinder(
    h=countersink_height+EPSILON,
    r1=countersink_outer_diameter/2,
    r2=countersink_outer_diameter/2-(countersink_height+0.1)*cos_over_sin(clf),
    $fn=floor(countersink_outer_diameter*PI/crs),
    center=false
  );

  translate([0,0,height-countersink_height+0.1])
  cylinder(
    h=countersink_height+EPSILON,
    r1=countersink_outer_diameter/2-(countersink_height+0.1)*cos_over_sin(clf),
    r2=countersink_outer_diameter/2,
    $fn=floor(countersink_outer_diameter*PI/crs),
    center=false
  );
}

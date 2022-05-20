module offset_3d(r = 1, size = 1000) {
  $fn = $fn == 0 ? 8 : $fn;
  if(r == 0) children();
  else if( r > 0 ) minkowski(convexity = 10) {
    children();
    sphere(r);
  }
  else {
    size2 = size * [1, 1, 1];// this will form the positv
    size1 = size2 * 2;    // this will hold a negative inside
    difference() {
      cube(size2, center = true);// forms the positiv by substracting the negative
      minkowski(convexity = 10) {
        difference() {
          cube(size1, center = true);
          children();
        }
        sphere(-r);
      }
    }
  }
}

// test_offset_3d() {
//   difference() {
//     // exterior fillets
//     offset_3d(2)
//     offset_3d(-2)
//     // interior fillets
//     offset_3d(-4)
//     offset_3d(4)
//     basic_model();
//     // hole without fillet
//     translate([0,0,10])
//     cylinder(r=18,h=50);
//   }

//   module basic_model() {
//     cylinder(r = 25, h = 55, $fn = 6);// $fn=6 for faster calculation
//     cube([80, 80, 10], center=true);
//   }
// }

// test2_offset_3d() {
//   // simpler (faster) example of a negative offset
//   offset_3d(-10, 100) {
//     difference() {
//       cube([50,50,50],center=true);
//       cube([50,50,50],center=false);
//     }
//   }
// }

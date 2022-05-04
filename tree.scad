module branch(h=3) {
  union() {
    cylinder(h, h * 0.6, center=true);
    translate([0, 0, h * 1.5]) sphere(h *1.5);
  }
}

module tree(h=3) {
  union(){
    branch(h);
    translate([h, 0, 0]) scale(0.3) rotate([0,60,0]) branch(h);
  }
}

union() {
for (i=[1:10:50]){
  translate([i*i, 0, 0]) tree(i);
};
};

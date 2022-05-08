s=["Happy", "Mother's", "Day"];
union(){
  linear_extrude(4, center=true, twist=0, slices=5)
  for(i=[0:2])
  translate([0, -i * 10, 0])
  text(s[i], 5);

  translate([-2, -22, -10])
  cube(size=[30, 30, 10], center=false);
}

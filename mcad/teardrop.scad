/* From http://www.thingiverse.com/thing:3457
   © 2010 whosawhatsis

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
*/


/*
This script generates a teardrop shape at the appropriate angle to prevent overhangs greater than 45 degrees. The angle is in degrees, and is a rotation around the Y axis. You can then rotate around Z to point it in any direction. Rotation around X or Y will cause the angle to be wrong.
*/

module teardrop(radius, length, angle) {
  $fn = $fn ? $fn : 12;
  r_sin45=radius * sin(45);
	rotate([0, angle, 0]) union() {
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			circle(r = radius);
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			projection(cut = false) rotate([0, -angle, 0]) translate([0, 0, r_sin45 * 1.5]) cylinder(h = r_sin45, r1 = r_sin45, r2 = 0, center = true);
	}

	//I worked this portion out when a bug was causing the projection above to take FOREVER to calculate. It works as a replacement, and I figured I'd leave it here just in case.
	/*
		#polygon(points = [[radius * cos(-angle / 2), radius * sin(-angle / 2), 0],[radius * cos(-angle / 2), radius * -sin(-angle / 2), 0],[(sin(-angle - 45) + cos(-angle - 45)) * radius, 0, 0]], paths = [[0, 1, 2]]);
		#polygon(points = [[radius * -cos(-angle / 2), radius * sin(-angle / 2), 0],[radius * -cos(-angle / 2), radius * -sin(-angle / 2), 0],[(sin(-angle - 45) + cos(-angle - 45)) * radius, 0, 0]], paths = [[0, 1, 2]]);
		#polygon(points = [[radius * sin(-angle / 2), radius * cos(-angle / 2), 0],[radius * sin(-angle / 2), radius * -cos(-angle / 2), 0],[(sin(-angle - 45) + cos(-angle - 45)) * radius, 0, 0]], paths = [[0, 1, 2]]);
	*/
}

/*
 * Simple intersection method to implement a flat/truncated teardrop
 */
module flat_teardrop(radius, length, angle) {
	intersection() {
		rotate([0, angle, 0]) {
			cube(size=[radius * 2, radius * 2, length], center=true);
		}
		teardrop(radius, length, angle);
	}
}

module test_teardrop(){
  difference() {
    for (i=[0:30:180]) translate([0, i, 0]) teardrop(15, 20, i);

  }
}
$fn=12;
r_sin45 = 10 * sin(45);
angle = 100;
// rotate([0, 0, -45]) // only rotate in the z to maintain angle.
// test_teardrop();
//rotate_extrude(angle=360, convexity=12)
projection(cut = true)
rotate([0,0,0])
rotate_extrude(angle=180, convexity=12)
projection(cut = false) rotate([0, -angle, 0]) translate([0, 0, r_sin45 * 1.5]) cylinder(h = r_sin45, r1 = r_sin45, r2 = 0, center = true);

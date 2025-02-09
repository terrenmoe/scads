// Parameters
cylinder_diameter = 20;
cylinder_height = 50;
set_screw_diameter = 5;
set_screw_offset = 12; // Distance from cylinder center to set screw center
set_screw_depth = 8;  // How deep the set screw hole goes

// Create the cylinder
cylinder(h = cylinder_height, d = cylinder_diameter);

// Create the set screw hole (using difference)
translate([set_screw_offset, 0, cylinder_height/2]) { // Position the hole
  rotate([0, 90, 0]) { // Rotate for correct orientation
    cylinder(h = set_screw_depth, d = set_screw_diameter);
  }
}

// Subtract the set screw hole from the cylinder
difference() {
  cylinder(h = cylinder_height, d = cylinder_diameter);

  translate([set_screw_offset, 0, cylinder_height/2]) {
    rotate([0, 90, 0]) {
      cylinder(h = set_screw_depth + 1, d = set_screw_diameter + 0.1); // Add a little extra for clean subtraction. Important!
    }
  }
}


// Optional: Add a small flat spot for the set screw to grip better
set_screw_flat_width = 3;
translate([set_screw_offset, 0, cylinder_height/2]) {
  rotate([0, 90, 0]) {
    translate([0, set_screw_diameter/2 + 0.1, -set_screw_flat_width/2]) { // Position flat
      cube([set_screw_depth + 1, set_screw_flat_width, set_screw_flat_width], center=true); // Create the flat
    }
  }
}

difference() {
  cylinder(h = cylinder_height, d = cylinder_diameter);

  translate([set_screw_offset, 0, cylinder_height/2]) {
    rotate([0, 90, 0]) {
      cylinder(h = set_screw_depth + 1, d = set_screw_diameter + 0.1); // Add a little extra for clean subtraction. Important!
    }
  }

    translate([set_screw_offset, 0, cylinder_height/2]) {
    rotate([0, 90, 0]) {
      translate([0, set_screw_diameter/2 + 0.1, -set_screw_flat_width/2]) { // Position flat
        cube([set_screw_depth + 1, set_screw_flat_width, set_screw_flat_width], center=true); // Create the flat
      }
    }
  }
}


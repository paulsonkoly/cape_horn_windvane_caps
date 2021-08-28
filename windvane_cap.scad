// (C) Paul Sonkoly -2021
// Cape Horn Wind vane closing caps


// bottom thickness - aka flush plate thickness
// bottom diam - flush plate diameter

// shaft diam - part that goes in the tube
// shaft height - how deep it goes in the metal tube

// cut hole in the middle 
// hole_diam - if we cut hole.. diameter 

module cap(bottom_thickness,
           bottom_diam,
           shaft_diam,
           shaft_height,
           cut_hole = false,
           hole_diam) {

    bottom_rad = bottom_diam / 2;

    module torus(r1, r2) {
        rotate_extrude() {
        translate([r2 - r1, 0, 0])
          circle(r1);
        }
    }
    
    module bottom() {
        torus(r1 = bottom_thickness / 2, r2 = bottom_rad);
        translate([0, 0, -bottom_thickness / 2])
          cylinder(h = bottom_thickness, d = bottom_diam - bottom_thickness);
        cylinder(h = bottom_thickness / 2, d = bottom_diam);
    }
    
    module shaft() {   
        translate([0, 0, bottom_thickness / 2])
          cylinder(h=shaft_height, d = shaft_diam);
    }
    
    module mid_hole() {
        translate([0, 0, - bottom_thickness / 2])
          cylinder(d = hole_diam, h = shaft_height + bottom_thickness);
    }

    translate([0, 0, bottom_thickness / 2]) {
        if (cut_hole) {
            difference() {
                union() {
                    bottom();
                    shaft();
                }
    
                mid_hole();
            }
        }
        else {
            bottom();
            shaft();
        }      
  }
}


/*cap(bottom_thickness = 3.2,
    bottom_diam = 34.75,
    shaft_diam = 31.66,
    shaft_height = 13.66,
    cut_hole = true,
    hole_diam = 3
);*/
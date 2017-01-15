$fn=100; // Better circles


hole_sizes = [0.5, 1, 2, 5, 10];
bar_sizes = [0.1, 0.2, 0.5, 1, 2];

union() {
    difference() {
        cube([80, 80, 15], true);
        union() {
            cube([50, 50, 100], true);

            for (i = [0:len(hole_sizes) - 1]) {
                // Horizontal circular
                translate([10*((len(hole_sizes)-1)/2-i), 35, 0])
                rotate([90, 0, 0])
                cylinder(h=30, d=hole_sizes[i], center=true);
                
                // Horizontal rectangular
                translate([10*(i-(len(hole_sizes)-1)/2), -35, 0])
                rotate([90, 0, 0])
                cube([hole_sizes[i],hole_sizes[i],30], center=true);
                
                
                // Vertical circular
                translate([32.5, 10*((len(hole_sizes)-1)/2-i), 0])
                {
                    cylinder(h=30, d=hole_sizes[i], center=true);
                    if (i != len(hole_sizes)-1)
                        translate([6, 0, 6.5])
                        linear_extrude(2)
                        text(str(hole_sizes[i]), font="Arial", size=2.5, valign="center", halign="right");
                }
                
                // Vertical rectangular
                translate([-32.5, 10*(i - (len(hole_sizes)-1)/2), 0])
                cube([hole_sizes[i],hole_sizes[i],30], center=true);
            }
            
            for (i = [0:len(bar_sizes) - 1]) {
                // Negative knobs
                translate([10*((len(hole_sizes)-1)/2-i), -32.5, 15-bar_sizes[i]])
                cylinder(h=15, d=5, center=true);
            }
            
            // Cutout for the corner sphere
            translate([25, 25, -15]) cube(30);
            
            // Cutout for the corner Cylinder
            translate([-25, -25, -15]) rotate([0, 0, 180]) cube(30);
            
            // Cutout for the wires
            translate([-28, +28, -5]) rotate([0, 0, 90]) cube(30);
            
            
            translate([39.5, -7, 0])
                        rotate([90, 0, 90])
                        linear_extrude(2)
                        text("Hello world!", font="Arial", size=8, valign="center", halign="center");
            
            translate([-39.5, 0.5, 3])
                        rotate([90, 0, -90])
                        linear_extrude(2)
                        text("80x80x15mm", font="Arial", size=4, valign="center", halign="center");
            
            translate([-39.5, 0.5, -3])
                        rotate([90, 0, -90])
                        linear_extrude(2)
                        text("50x50mm cutout", font="Arial", size=4, valign="center", halign="center");
        }
    }
    // Corner sphere
    intersection(){
        translate([25, 25, 0]) sphere(r=12);
        translate([25, 25, -7.5]) cube(15);
    }
    // Corner cylinder
    intersection(){
        translate([-25, -25, 0]) cylinder(r=15, h=15, center=true);
        translate([-25, -25, -15]) rotate([0, 0, 180])cube(30);
    }
    //Corner wires
    union(){
        translate([-38, 38, 0]) cylinder(h=10, d=1, center=true);
        translate([-38, 33, 5]) rotate([90, 0, 0]) cylinder(h=10, d=1, center=true);
        translate([-33, 38, 5]) rotate([0, 90, 0]) cylinder(h=10, d=1, center=true);
        
        translate([-38, 33, 0]) rotate([135, 0, 0]) cylinder(h=15, d=1, center=true);
        translate([-33, 38, 0]) rotate([0, 135, 0]) cylinder(h=15, d=1, center=true);
        translate([-33, 33, 5]) rotate([90, 0, 45]) cylinder(h=15, d=1, center=true);
          
        translate([-33, 33, 0]) rotate([124, 0, 45]) cylinder(h=18, d=1, center=true);
        
        translate([-38, 38, 5]) sphere(d=2);
    }
    
    for (i = [0:len(bar_sizes) - 1]) {
        // Internal bars
        translate([0, 10*((len(bar_sizes)-1)/2-i), 0])
        cube([50, bar_sizes[i], 15], center=true);
        

        // Positive knobs
        translate([10*((len(bar_sizes)-1)/2-i), 32.5, 7.5])
        {
            translate([0, 2.5, bar_sizes[i]/2]) cylinder(h=bar_sizes[i], d=5, center=true);
            translate([0, -3, 0])
                linear_extrude(1)
                text(str(bar_sizes[i]), font="Arial", size=4, valign="center", halign="center");
        }
    }
}
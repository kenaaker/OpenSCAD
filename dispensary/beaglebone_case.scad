/* Cylinder based aligner orienter. */

/* Rounded corners in x and y */
module rounded_cube_x2(size, radius, center=false) {
	x = size[0];
	y = size[1];
	z = size[2];

	if (center == false) {
		linear_extrude(height=z) hull() {
			// place 4 circles in the corners, with the given radius
			translate([radius, radius, 0]) circle(r=radius, $fn=30);
			translate([(x - (radius)), radius, 0]) circle(r=radius, $fn=30);
			translate([radius, (y - (radius)), 0]) circle(r=radius, $fn=30);
			translate([(x - (radius)), (y - (radius)), 0]) circle(r=radius, $fn=30);
		}
	} else {
		translate([-x/2, -y/2, -z/2]) linear_extrude(height=z) hull() {
			// place 4 circles in the corners, with the given radius
			translate([radius, radius, 0]) circle(r=radius, $fn=30);
			translate([(x - (radius)), radius, 0]) circle(r=radius, $fn=30);
			translate([radius, (y - (radius)), 0]) circle(r=radius, $fn=30);
			translate([(x - (radius)), (y - (radius)), 0]) circle(r=radius, $fn=30);
		}
	}
}

m3_for_thread = 3;
m3_clearance = 3.7;
m3_head = 5.7;
m2_for_thread = 2.1;

e_shell_size = [156,71,42];
e_shell_hollow = [152,67,38];
$fn=50;

module mounting_posts(post_base_size = [66, 48.5, 7], board_base_size = [86.25, 55.0, 2]) {
	translate([board_base_size.x/2-5,(board_base_size.y/2-6.5),0])
		difference() {
			cylinder(r=m3_for_thread/2*2, h=post_base_size.z);
			cylinder(r=m3_for_thread/2, h=post_base_size.z+0.1);
		} /* difference */
	translate([board_base_size.x/2-5,-(board_base_size.y/2-6.5),0])
		difference() {
			cylinder(r=m3_for_thread/2*2, h=post_base_size.z);
			cylinder(r=m3_for_thread/2, h=post_base_size.z+0.1);
		} /* difference */
	translate([-post_base_size.x/2+5,(post_base_size.y/2),0])
		difference() {
			cylinder(r=m3_for_thread/2*2, h=post_base_size.z);
			cylinder(r=m3_for_thread/2, h=post_base_size.z+0.1);
		} /* difference */
	translate([-post_base_size.x/2+5,-(post_base_size.y/2),0])
		difference() {
			cylinder(r=m3_for_thread/2*2, h=post_base_size.z);
			cylinder(r=m3_for_thread/2, h=post_base_size.z+0.1);
		} /* difference */
} /* mounting_posts */

module mounting_base(board_base_size = [86.25, 55.0, 2]) {
	rounded_cube_x2(board_base_size, radius=5, center=true);
} /* mounting_base */

module bottom_electronics_shell() {
	difference() {
		union() {
			rounded_cube_x2(e_shell_size, radius=4, center=true);
		} /* union */
		difference() {
			rounded_cube_x2(e_shell_hollow, radius=4, center=true);
			/* Screw pillars to screw case together */
			translate([(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([-(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([-(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);

			/* Access hole to round button */
			translate([10,0,10]) cylinder(r1=20, r2=26, h=16, center=true);
		} /* union */
		/* Ventilation grill on bottom */
		translate([-e_shell_size.x/5,6*-3,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*-2,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*-1,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*0,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*1,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*2,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);
		translate([-e_shell_size.x/5,6*3,-e_shell_size.z/2+1])
			rounded_cube_x2([e_shell_size.x/3, 2, 6], radius=1, center=true);

		/* Holes for mounting screws to base */
		translate([(-15.25),(e_shell_size.y/2-7.25),-e_shell_size.z/2-1])
			cylinder(r=m3_clearance/2, h=8);
		translate([(-15.25),-(e_shell_size.y/2-7.25),-e_shell_size.z/2-1])
			cylinder(r=m3_clearance/2, h=8);
		translate([-(e_shell_size.x/2-30),(e_shell_size.y/2-7.25),-e_shell_size.z/2-1])
			cylinder(r=m3_clearance/2, h=8);
		translate([-(e_shell_size.x/2-30),-(e_shell_size.y/2-7.25),-e_shell_size.z/2-1])
			cylinder(r=m3_clearance/2, h=8);
		/* LCD opening */
		translate([54,0,18]) rounded_cube_x2([35,35,5], radius=4, center=true);
		/* wiring harness opening */
		translate([-44,0,18]) rounded_cube_x2([45,45,5], radius=4, center=true);
		/* Opening for round button access */
		translate([10,0,10]) cylinder(r1=18, r2=24, h=18, center=true);
		/* Screw holes for m3 screws */
		translate([(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
			cylinder(r=m3_for_thread/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
			cylinder(r=m3_for_thread/2, h=e_shell_hollow.z, center=true);
		translate([(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
			cylinder(r=m3_for_thread/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
			cylinder(r=m3_for_thread/2, h=e_shell_hollow.z, center=true);
		/* Cut off the top */
		translate([0, 0,(100/2)]) cube([300,100,100], center=true);
		/* Holes for RJ45 and power sockets */
 		translate([-34,0,-18]) {
			translate([-44.5,26.5,7]) { 
				translate([0,-32.5,0.8]) cube([12,17,15]);
				translate([0,-49.5,0.8]) cube([8,10,12]);
			}
		}
	}
	translate([-34,0,-18]) {
		translate([1.6,0,0]) mounting_posts();
		/* display mounting posts  */
		translate([100,+29/2,0])
			difference() {
				cylinder(r=m3_for_thread/2*2, h=30);
				translate([0,0,23]) cylinder(r=m2_for_thread/2, h=10+0.1);
			} /* difference */
		translate([100,-29/2,0])
			difference() {
				cylinder(r=m3_for_thread/2*2, h=30);
				translate([0,0,23])cylinder(r=m2_for_thread/2, h=10+0.1);
			} /* difference */
	} /* translate */
} /* bottom electronics_shell */

module top_electronics_shell() {
	difference() {
		union() {
			rounded_cube_x2(e_shell_size, radius=4, center=true);
		} /* union */
		difference() {
			rounded_cube_x2(e_shell_hollow, radius=4, center=true);
			/* Screw pillars to screw case together */
			translate([(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([-(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			translate([-(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, 0])
				cylinder(r=7/2, h=e_shell_hollow.z, center=true);
			/* Button shell */
			translate([13,0,17.1]) cylinder(r1=17, r2=19, h=8, center=true);
		} /* union */
		/* LCD opening */
		translate([50,0,19]) rounded_cube_x2([19,33,5], radius=4, center=true);
		/* wiring harness opening */
		translate([-23,0,19]) rounded_cube_x2([25,45,5], radius=4, center=true);
		/* Button opening */
		translate([13,0,17]) cylinder(r1=16, r2=18, h=10, center=true);
		/* Section it down the middle */
*		translate([-e_shell_size.x/2-1, 0,-e_shell_size.z/2-3]) cube([300,100,100]);
		/* Cut off the bottom */
		translate([0, 0,-(100/2)]) cube([300,100,100], center=true);
		translate([-34,0,-18]) {
			translate([-44.5,26.5,7]) { 
				translate([0,-32.5,0.8]) cube([12,17,15]);
				translate([0,-49.5,0.8]) cube([8,10,12]);
*				model_electronics();
			}
		}
		/* Screw holes for m3 screws */
		translate([(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, e_shell_size.z/2-3])
			cylinder(r=m3_clearance/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, e_shell_size.z/2-3])
			cylinder(r=m3_clearance/2, h=e_shell_hollow.z, center=true);
		translate([(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, e_shell_size.z/2-3])
			cylinder(r=m3_clearance/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, e_shell_size.z/2-3])
			cylinder(r=m3_clearance/2, h=e_shell_hollow.z, center=true);
		/* Recess holes for m3 screw heads */
		translate([(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, e_shell_size.z-2-4])
			cylinder(r=m3_head/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, e_shell_size.z-2-4])
			cylinder(r=m3_head/2, h=e_shell_hollow.z, center=true);
		translate([(e_shell_hollow.x-7/2)/2, -(e_shell_hollow.y-7/2)/2, e_shell_size.z-2-4])
			cylinder(r=m3_head/2, h=e_shell_hollow.z, center=true);
		translate([-(e_shell_hollow.x-7/2)/2, (e_shell_hollow.y-7/2)/2, e_shell_size.z-2-4])
			cylinder(r=m3_head/2, h=e_shell_hollow.z, center=true);
	}
	translate([-36,0,-18]) {
*		translate([-45,27.5,7]) 
			model_electronics();
	}
} /* top_electronics_shell */

	translate([0,0,e_shell_size.z/2]) {
		bottom_electronics_shell();
		translate([0,100,0]) rotate([180,0,0])
			top_electronics_shell();
	}


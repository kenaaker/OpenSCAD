/* Cylinder based aligner orienter. */

include <rounded_cube.scad>
include <dispenser_parms.scad>

$fn=50;

pi=3.1415926535897932384626433832795;

module hollow_cylinder(r=10, h=1, w_thickness=.8) {
	difference() {
		union() {
			cylinder(r=r-0.2, h=h);
		} /* union */
		translate([0,0,-0.1])cylinder(r=r-w_thickness, h=h+0.2);
	} /* difference */
} /* hollow_cylinder */

module dispenser_base() {
	difference() {
		/* Full object shapes */
		union() {
			translate([0,0,base_size.z/2]) {
				rounded_cube_x2(base_size, radius=base_radius, center=true);
				rotate([0,0,45]) rounded_cube_x2(base_size, radius=15, center=true);
				/* Mount for electronics case */
				translate([0,25,0]) hull() {
					translate([90, -20, (pillar_height-16)/2-base_size.z/2]) 
						rounded_cube_x2([e_shell_size.y+35, e_shell_size.y+0, pillar_height-16], radius=3, center=true);
					translate([104.5, 0, (pillar_height)/2*3+6]) 
						rounded_cube_x2([e_shell_size.y+6, e_shell_size.y-40, pillar_height], radius=3, center=true);
				} /* hull */
			} /* translate */
			/* Screw post for bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=dispenser_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=dispenser_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=dispenser_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=dispenser_height, w_thickness=5-5/2);
			/* Body  for drawer */
			translate([0,0,dispenser_body_size.z/2])
				union() {
					rounded_cube_x2(dispenser_body_size, radius=5, center=true);
				} /* union */
		} /* union */
		/* Spaces in objects */
		/* Space for next layer */
		translate([0,0,1.5*pillar_height+5/2]) rotate([0,0,45])
			rounded_cube_x2([base_size.x*1.02, base_size.y*1.02, pillar_height+5+5], radius=base_radius, center=true);
		/* Space for electronics case */
		translate([104,15,(e_shell_size.x/2*sin(45) + e_shell_size.z/2*sin(45) + 10)]) {
			rotate([0,-45,90]) {
					rounded_cube_x2(e_shell_size*1.02, radius=4, center=true);
					translate([-15,0,-20]) {
						rounded_cube_x2(e_shell_size*.6, radius=4, center=true);
						translate([0,-e_shell_size.y/2*0.8,-14]) cylinder(r=m3_for_thread/2, h=16);
						translate([0,e_shell_size.y/2*0.8,-14]) cylinder(r=m3_for_thread/2, h=16);
						translate([-(e_shell_size.x/2*0.8-29.75),-e_shell_size.y/2*0.8,-10])
							cylinder(r=m3_for_thread/2, h=12);
						translate([-(e_shell_size.x/2*0.8-29.75),e_shell_size.y/2*0.8,-10])
							cylinder(r=m3_for_thread/2, h=12);
					} /* translate */
			} /* rotate */
		} /* translate */

		/* Screw holes for next layer of case. */
		rotate([0,0,45]) {
			translate([-(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=pillar_height+3);
			/* Screw holes through bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=pillar_height+3);
			/* Screw holes through bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=pillar_height+3);
			/* Screw holes through bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=pillar_height+3);
		} /* rotate */
		/* Space for drawer */
		translate([0,-5, wall_thickness+dispenser_body_size.z/2+0.1])
			union() {
				rounded_cube_x2(dispenser_void_size, radius=5, center=true);
			} /* union */
	} /* difference */
} /* dispenser_base */

module dispenser_drawer() {
	difference() {
		/* Full object shapes */
		union() {
			rounded_cube_x2(dispenser_drawer_size, radius=5, center=true);
			translate([0,-dispenser_drawer_size.y/2,0]) rotate([0,90,0])
				scale([1.0,0,.75,1]) cylinder(r=dispenser_drawer_size.z/2, h=4);
		} /* union */
		/* Spaces in objects */
			/* Space inside drawer */
			translate([0,0,wall_thickness])
				union() {
					rounded_cube_x2(dispenser_drawer_void, radius=5, center=true);
*					rotate([0,0,45]) rounded_cube_x2(dispenser_drawer_void, radius=5, center=true);
				} /* union */
	} /* difference */
} /* dispenser_drawer */

//translate([0,-180,dispenser_drawer_size.z/2+wall_thickness]) {
translate([0,-140,dispenser_drawer_size.z/2]) {
	dispenser_drawer();
}

translate([0,0,0]) rotate([0,0,0]) {
	dispenser_base();
}


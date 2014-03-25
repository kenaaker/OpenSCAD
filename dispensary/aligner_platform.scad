/* Cylinder based aligner orienter. */

include <rounded_cube.scad>

include <dispenser_parms.scad>

$fn=50;

pi=3.1415926535897932384626433832795;


module aligner_platform(platform_size = [100, 100, 1.4]) {
	difference() {
		union() translate([0,0,platform_size.z/2]) {
			rounded_cube_x2(platform_size, radius=15, center=true);
			rotate([0,0,45]) rounded_cube_x2(platform_size, radius=15, center=true);
			/* Arena rotation track cylinder */
			translate([0,0,platform_size.z/2]) cylinder(r=(platform_size.x-35)/2, h=0.4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,45])translate([(platform_size.x-platform_radius-26/2)/2,
						(platform_size.y-platform_radius-26/2)/2,0])
				cylinder(r=4, h=4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,165])translate([(platform_size.x-platform_radius-26/2)/2,
						(platform_size.y-platform_radius-26/2)/2,0])
				cylinder(r=4, h=4);
			/* Mounting boss with screw hole to clamp down arena. */
			rotate([0,0,-75]) translate([(platform_size.x-platform_radius-26/2)/2,
						(platform_size.y-platform_radius-26/2)/2,0])
				cylinder(r=4, h=4);
		} /* union */
		/* empty out rotation track cylinder */
		translate([0,0,platform_size.z-0.2]) cylinder(r=(platform_size.x-35)/2-wall_thickness,
					 h=wall_height);
		/* Arena Drive shaft hole */
		translate([0,0,-platform_size.z]) cylinder(r=m3_clearance/2, h=wall_height);
		/* Arena Platform Drive shaft hole */
		translate([-(platform_size.x-2)*cos(0)/2,-(platform_size.y-2)*sin(0)/2,-platform_size.z])
			cylinder(r=12/2, h=wall_height);
		/* Pill exit hole */
		translate([(platform_size.x/2-12)*cos(pill_exit_angle),
					(platform_size.x/2-12)*sin(pill_exit_angle),-platform_size.z/2])
			cylinder(r1=(pill_size+2)/2, r2=(pill_size+4)/2, h=wall_height+2);
		/* Unload Pills exit hole */
		translate([(platform_size.x/2-12)*cos(pill_exit_angle+90-45/2),
					(platform_size.x/2-12)*sin(pill_exit_angle+90-45/2),-platform_size.z/2])
			cylinder(r1=(pill_size+2)/2, r2=(pill_size+4)/2, h=wall_height+2);
		/* Screw hole for bracket clamp. */
		rotate([0,0,45]) translate([(platform_size.x-platform_radius-26/2)/2,
					(platform_size.y-platform_radius-26/2)/2,1])
			cylinder(r=4/2, h=5);
		/* Screw hole for bracket clamp. */
		rotate([0,0,165]) translate([(platform_size.x-platform_radius-26/2)/2,
					(platform_size.y-platform_radius-26/2)/2,1])
			cylinder(r=4/2, h=5);
		/* Screw hole for bracket clamp. */
		rotate([0,0,-75]) translate([(platform_size.x-platform_radius-26/2)/2,
					(platform_size.y-platform_radius-26/2)/2,1])
			cylinder(r=4/2, h=5);
		/* Screw hole to mount base. */
		translate([-(platform_size.x-platform_radius-5/2)/2,
			-(platform_size.y-platform_radius-5/2)/2,-1])
			cylinder(r=5/2, h=5);
		/* Screw hole to mount base. */
		translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-1])
			cylinder(r=5/2, h=5);
		/* Screw hole to mount base. */
		translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-1])
			cylinder(r=5/2, h=5);
		/* Screw hole to mount base. */
		translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-1])
			cylinder(r=5/2, h=5);
	} /* difference */
} /* aligner_platform */


*translate([0,0,al_base_height+platform_size.z/2])
	aligner_platform();
translate([0,0,0])
	aligner_platform();

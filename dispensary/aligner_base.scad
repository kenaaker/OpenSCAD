/* Cylinder based aligner orienter. */

include <rounded_cube.scad>
include <MCAD/stepper.scad>
include <gear_motor_model.scad>
use <parametric_involute_gear_v5.1.scad>

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

module exit_ramp_solid() {
	union () {
		hull() {
			translate([0,-5,al_base_height-2]) cylinder(r=(pill_size*1.5+4)/2, h=1);
			translate([0,-13,0]) cylinder(r=(pill_size*1.5+4)/2, h=1);
		} /* hull */
	} /* union */
} /* exit_ramp */

module exit_ramp_space() {
	/* Hollow the solid out */
	difference() {
		translate([0,1*sin(25.5),1]) hull() {
			translate([0,-5,al_base_height-2]) cylinder(r=(pill_size*1.5+2)/2, h=1);
			translate([0,-13,-1.1])
				cylinder(r=(pill_size*1.5+2)/2, h=2);
		} /* hull */
	} /* difference */
	/* exit hole */
} /* exit_ramp */

module exit_ramp() {
	difference() {
		exit_ramp_solid();
		exit_ramp_space();
	} /* difference */
} /* exit_ramp */

module exit_ramp_with_reflector_mount() {
	difference() {
		union() {
			exit_ramp_solid();
			rotate([0,0,180])
			translate([0,3,al_base_height-8]) {
				translate([(pill_size*1.5+13)/2,(pill_size*1.5/2),0]) {
					hull() {
						rotate([0,0,180]) reflected_light_sensor_mount();
						translate([-((pill_size*1.5)/2-1),-(pill_size*1.5/2-4),-6])
							sphere(r=1);
					} /* hull */
				} /* translate */
			} /* translate */
		} /* union */
		exit_ramp_space();
		rotate([0,0,180]) translate([6.5,3,al_base_height-8]) {
			translate([(pill_size*1.5+0)/2,(pill_size*1.5/2),0]) {
				rotate([0,0,180]) reflected_light_sensor_mount_space();
			} /* translate */
		} /* rotate */
	} /* difference */
} /* exit_ramp_with_sensor_mounts */

module gear_motor_mount_bottom(gm_mount_size = [15, 30, 30], motor_offset=-1) {
	translate([0,0,gm_mount_size.x/2]) rotate([-90,0,0])
	difference() {
		union() {
			translate([0,0,0]) rotate([0,0,90])
				rounded_cube_x2(gm_mount_size, radius=2, center=true);
		} /* union */
		/* Remove the motor shape from the block */
		translate([0,motor_offset,0+3.8])
			scale([1.07,1.07,1.0]) gear_motor();
		/* Remove a shaft clearance cylinder from the block */
*		translate([0,motor_offset,gm_mount_size.z/2-5])
			rotate([0,0,0]) cylinder(r=4, h=8);
		/* Screw holes for top clamp and mount */
		translate([(gm_mount_size.y/3*2/2),motor_offset,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_for_thread/2, h=48,center=true);
		translate([-(gm_mount_size.y/3*2/2),motor_offset,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_for_thread/2, h=48,center=true);
		/* Remove the top half of the block for insertion */
		translate([0,-gm_mount_size.y,0])
			cube([gm_mount_size.x*3, gm_mount_size.y*2, gm_mount_size.z*2], center=true);
	} /* difference */
} /* gear_motor_mount_bottom */

module gear_motor_mount_top(gm_mount_size = [15, 30, 30], motor_offset=-1) {
	translate([0,0,gm_mount_size.x/2]) rotate([90,0,0])
	difference() {
		union() {
			translate([0,0,0]) rotate([0,0,90])
				rounded_cube_x2(gm_mount_size, radius=2, center=true);
		} /* union */
		/* Cut the bottom section away */
		translate([0,-gm_mount_size.y/2-motor_offset+1,-gm_mount_size.z/2+0.1])
			cube([gm_mount_size.y*2, gm_mount_size.x*2, gm_mount_size.z], center=true);
		/* Remove the motor shape from the block */
		translate([0,motor_offset,0+2.9])
			scale([1.02,1.02,1.0]) gear_motor();
		/* Remove a shaft clearance cylinder from the block */
*		translate([0,motor_offset,gm_mount_size.z/2-5])
			rotate([0,0,0]) cylinder(r=4, h=8);
		/* Screw holes for top clamp and mount */
		translate([gm_mount_size.y/3*2/2,motor_offset,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_clearance/2, h=28,center=true);
		translate([-gm_mount_size.y/3*2/2,motor_offset,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_clearance/2, h=28,center=true);
		/* Screw cap holes for top clamp and mount */
		translate([gm_mount_size.y/3*2/2,motor_offset-4.01,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_head/2, h=7,center=true);
		translate([-gm_mount_size.y/3*2/2,motor_offset-4.01,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=m3_head/2, h=7,center=true);
		/* Remove the bottom half of the block */
		translate([0,gm_mount_size.y,0.1])
			cube([gm_mount_size.x*3, gm_mount_size.y*2, gm_mount_size.z*2], center=true);
*		translate([16,-2,6])
			cube([10, 10, 30], center=true);
	} /* difference */
	/* Support Structure for screw cap holes for top clamp and mount */
	translate([0,0,gm_mount_size.x/2]) rotate([90,0,0]) {
		translate([-gm_mount_size.y/3*2/2,motor_offset-3.5,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=(m3_head-0.8)/2, h=6,center=true);
		translate([gm_mount_size.y/3*2/2,motor_offset-3.5,gm_mount_size.z/2-5])
			rotate([90,0,0]) cylinder(r=(m3_head-0.8)/2, h=6,center=true);
	} /* translate */
} /* gear_motor_mount_top */

module aligner_base() {
	difference() {
		/* Full object shapes */
		union() {
			rounded_cube_x2(base_size, radius=base_radius, center=true);
			rotate([0,0,45]) rounded_cube_x2(base_size, radius=15, center=true);

			rotate([0,0,180]) translate([0, 8, al_base_height-32/2]) rotate([90,0,0])
				gear_motor_mount_bottom(gm_mount_size = [14, 30, 32]);
*			rotate([0,0,180]) translate([0,-6.1,al_base_height-32/2]) rotate([-90,0,0])
				gear_motor_mount_top(gm_mount_size = [14, 30, 32]);

			rotate([0,0,180-90]) translate([0,55-14-0.1, al_base_height-32/2]) rotate([90,0,180])
				gear_motor_mount_bottom(gm_mount_size = [14, 30, 32]);
*			rotate([0,0,180-90]) translate([0,55,al_base_height-32/2]) rotate([-90,0,180])
				gear_motor_mount_top(gm_mount_size = [14, 30, 32]);

			/* Screw post for bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=al_base_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=al_base_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=al_base_height, w_thickness=5-5/2);
			/* Screw post for bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,0])
				hollow_cylinder(r=5, h=al_base_height, w_thickness=5-5/2);
		} /* union */

		/* Spaces in objects */
		union() {
			/* Drive shaft alignment */
			translate([0,0,45/2]) cylinder(r=1/2, h=45);
		} /* union */
		/* Hole through plate for pill exit */
		translate([platform_size.x/2-13.75,0,-2]) rotate([0,0,-90])  {
			exit_ramp_space();
		} /* translate */

		/* Screw holes through bottom of case. */
		rotate([0,0,0]) {
			translate([-(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
		} /* rotate */

		/* Screw holes for next layer of case. */
		rotate([0,0,45]) {
			translate([-(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			/* Screw holes through bottom of case. */
			translate([-(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			/* Screw holes through bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						-(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
			/* Screw holes through bottom of case. */
			translate([(platform_size.x-platform_radius-5/2)/2,
						(platform_size.y-platform_radius-5/2)/2,-2])
				cylinder(r=5-5/2, h=al_base_height+3);
		} /* rotate */
		/* Space for unload funnel */
		render() translate([40-10,70+4,al_base_height-5]) rotate([180,0,90-45/2])
			bent_cylinder(cyl_r=10+1.4-2, curve_r=20,
					start_angle=0, finish_angle=180);
	} /* difference */
} /* aligner_base */

module reflected_light_sensor_module() {
	lip_width = 4.8;
	lip_depth = 1.8;
	package_size = [4, 6.5, 8.7];
	wire_hole = [13, 4.5, 8.7];
	front_package_size = [lip_depth, lip_width, 4.7];

	union() {
		translate([package_size.x/2+1, package_size.y/2, package_size.z/2])
			cube(package_size, center=true);
		translate([package_size.x+1+front_package_size.x/2-0.1,
						package_size.y/2,front_package_size.z/2])
			cube(front_package_size, center=true);
		translate([package_size.x/2-2, package_size.y/2, package_size.z/2])
			cube(wire_hole, center=true);
	} /* union */
} /* reflected_light_sensor_module */

module reflected_light_sensor_mount() {
	lip_width = 4.6;
	lip_depth = 1.6;
	package_size = [4.8, 6.1, 4.5];
	front_package_size = [lip_depth, lip_width, 4.5];
	outer_package_size = ([4.8, 6.1, 5.5]*1.4);

	translate([0, -1, -1])
			cube(outer_package_size);
} /* reflected_light_sensor_module */

module reflected_light_sensor_mount_space() {
	lip_width = 4.6;
	lip_depth = 1.6;
	package_size = [4.8, 6.1, 4.5];
	front_package_size = [lip_depth, lip_width, 4.5];
	outer_package_size = ([4.8, 6.1, 4.5]*1.4);

	translate([0, -1, -1])
		translate([-0.1, (outer_package_size.y-package_size.y)/2,
							(outer_package_size.z-package_size.z)/2])
			reflected_light_sensor_module();
} /* reflected_light_sensor_module */

module full_aligner_base() {
	translate([0,0,base_size.z/2]) {
		translate([platform_size.x/2-13,0,base_size.z/2]) rotate([0,0,-90])  {
				exit_ramp_with_reflector_mount();
		} /* translate */
		aligner_base();
	}
} /* full_aligner_base */

*translate([-40,40,0]) rotate([0,0,0])
	gear_motor_mount_bottom();

*translate([50,0,0]) rotate([0,0,0])
	gear_motor_mount_top();
*translate([0,0,0]) rotate([0,0,0])
	gear_motor_mount_top();

full_aligner_base();

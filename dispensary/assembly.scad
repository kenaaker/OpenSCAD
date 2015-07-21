include <rounded_cube.scad>
include <dispenser_parms.scad>
include <MCAD/stepper.scad>
include <gear_motor_model.scad>
include <dispenser_parms.scad>
include <screw_dims.scad>

use <base_and_drawer.scad>
use <aligner_base.scad>
use <aligner_platform.scad>
use <aligner_arena.scad>
use <../beaglebone_case.scad>


translate([0,0,0]) rotate([0,0,0]) {
	dispenser_base();
}

translate([0,0,dispenser_height+base_size.z/2]) rotate([0,0,90+45]) {
	full_aligner_base();
}

translate([0,0,dispenser_height+base_size.z/2+al_base_height+base_size.z/2]) rotate([0,0,90+45]) {
	aligner_platform();
}

*translate([0,0,dispenser_height+base_size.z/2+al_base_height+base_size.z+0.2]) rotate([0,0,90+45]) {
	aligner_arena();
}
translate([0,0,dispenser_height+base_size.z/2+al_base_height+base_size.z+0.2]) rotate([0,0,-90-45-45/2]) {
	aligner_arena();
}

translate([0,0,dispenser_height+base_size.z/2+al_base_height+base_size.z+0.2+wall_thickness]) rotate([0,0,45]) {
	aligner_arena_bracket();
}

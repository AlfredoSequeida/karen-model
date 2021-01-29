use <threadlib/threadlib.scad>
//use <openscad-rpi-library/misc_boards.scad>

//--------------------- all values are in mm -------------

$fn = 60;

// -------------------- shared values --------------------

speaker_driver_r = 78.95/2;

// M2.5 standoffs a little larger for printing shinking
// diameter = 2.75
standoff_r = 2.75/2;

//// values for base
// thickness/height for a base
base_h = 3;

// base radius
base_r = 127/2;

// padding for base mounting holes
outer_radius_padding = 5;
standoff_mount_radius_from_center = base_r - outer_radius_padding;

// -------------------- shared values --------------------

//rpi_base();
module rpi_base(){
    
    //to fit rca plugs and usbc power
    offset = 11;
    
    handle_mount_w = 10;
    
    handle_w = 85 + handle_mount_w *2;
    
    difference(){
        base();
        
        //r_pi holes
        //color("yellow")
        rotate(90)
        translate([-56/2,-85/2 + offset,0])
        raspberrypi_3_model_b_holes_for_base();
        
        //handle holes
        translate([-handle_mount_w, -handle_w/2 ,0])
        handle_holes();
    }
}

translate([0,0,20])
rotate([0,90,0])
handle();
module handle(){
    l = 20;
    w = 85;
    h = 55;
    
    thickness = 2;
    
    mount_w = 10;
    
    difference(){
    translate([0,mount_w,0])
    union(){
    //top
    translate([0,0,h])
    cube([l,w,thickness]);
    
    //sides
    cube([l,thickness,h]);
    
    translate([0,w - thickness,0])
    cube([l,thickness,h]);
    
    //mount

    translate([0,-mount_w, 0])
    cube([l,mount_w,thickness]);

    translate([0,w, 0])
    cube([l,mount_w,thickness]);
    }
    color("red")
    translate([0,(w + (mount_w *2)) /2  ,h])
    cube([l/2*2, l*1.5, 20],center = true);
    
    handle_holes();
    }

}

module handle_holes(){
    
    l = 20;
    w = 85;
    
    mount_w = 10;
    
    translate([0,mount_w,0])
    union(){
    translate([l/2, -mount_w/2,0])
    cylinder(r=standoff_r, h=base_h);
    
    translate([l/2, w + mount_w/2,0])
    cylinder(r=standoff_r, h=base_h);
    }
}

//elec_components_base();
module elec_components_base(){
    
    outside_size = 1.2;
    
    //holes for OEP30Wx2 Audio Module
    difference(){
        base(cable_access_hole=false);
        translate([0,-base_r/2,0])
        rotate([0,0,-45])
        OEP30W_holes();
        
        translate([-base_r/2,0,0])
        rotate([0,0,45])
        LM2596_holes();
    }
    
    
    translate([cos(-45)*base_r-0.6,-sin(-45)*base_r -0.6,10.2])
    rotate([0,0,-45]){
    difference(){
        
    translate([0,-10,-7])
    color("green")
    cube([17.15,20,5], true);
        
    scale([outside_size,outside_size,outside_size])

    dc_female_adapter();
        
        }

    difference(){

    dc_female_plug_insert();
     
        
    //translate([0,-20,10])
    //cube([20,40,20], true);
    

}
}
}

module LM2596_holes(){
    angle = 60;
    x_dist = 30;
    y_dist = 15;
    
    
    union(){
        translate([0, y_dist, 0])
        cylinder(r=standoff_r, h=base_h);
        translate([x_dist, 0, 0])
        cylinder(r=standoff_r, h=base_h);
    }
    
}

module OEP30W_holes(){
    // measured with caliper
    x_dist = 20;
    
    translate([-x_dist/2,0,0])
    union(){
        cylinder(r=standoff_r, h=base_h);
        translate([x_dist,0,0])
        cylinder(r=standoff_r, h=base_h);
    }
}

//speaker_base();
module speaker_base(){
    //left speaker
    //the right speaker is the same
    
    driver_size_r = 79/2;

    difference(){
        base();
        
        speaker_holes();
        
        // driver hole
        cylinder(r=driver_size_r, h=base_h);
    }
}

//dual_speaker_base();
module dual_speaker_base(){
    driver_size_r = 40/2;


    difference(){
        base();
        
        // driver holes
        translate([base_r/2 - 13, 0, 0]){
        cylinder(r=driver_size_r, h=base_h);
        dual_speaker_holes();
        }
        
        // driver holes
        translate([-base_r/2, 0, 0]){
        dual_speaker_holes();
        cylinder(r=driver_size_r, h=base_h);
        }
    }
}

module dual_speaker_holes(){
    mounting_bracket_y = 52/2;
    // adding 0.25 for shrinking
    speaker_hole_r = 4/2 + 0.25;
    
    translate([0,mounting_bracket_y,0])
    cylinder(r=speaker_hole_r, h=base_h);
   
    translate([0,-mounting_bracket_y,0])
    cylinder(r=speaker_hole_r, h=base_h);
}

module speaker_holes(){
    // get speaker hole size for screws
    // using caliper -> M4
    
    // adding 0.25 for shrinking
    speaker_hole_r = 4/2 + 0.25;
    
    // mounting bracket using caliper
    mounting_bracket_diagonal_l = 95/2;
    
    for (i = [0:3]){
        //solve using trig to get the corect
        //placement
        translate([cos(90*i+45)*mounting_bracket_diagonal_l, sin(90*i+45)*mounting_bracket_diagonal_l, 0 ])
        cylinder(r=speaker_hole_r, h=base_h);
    }
}

module base(cable_access_hole=true, standoff_holes=true){
    // cable access hole
    cable_access_seperation = 10;
    cable_access_r = 5;
    
    // cordinate locations for the access hole
    cable_access_y = 25.4/2;
    
    cable_access_x = base_r - cable_access_y*2 + cable_access_seperation;
    
    slot_width = 4;
    

    difference(){
        cylinder(h=base_h , r=base_r);
        
    if (standoff_holes){
        for (i = [0:3]){
            translate([cos(i*90) * standoff_mount_radius_from_center,sin(i*90) * standoff_mount_radius_from_center])
            cylinder(h=base_h, r=standoff_r);
        }
    }

        if (cable_access_hole){
            // integrating cable access hole
            hull() {
                translate([cable_access_x,cable_access_y,0]) cylinder(r=cable_access_r,h=base_h);
                translate([cable_access_x,-cable_access_y,0]) cylinder(r=cable_access_r,h=base_h);
            }
        }
    
    // slot for container
    translate([-cos(45)*base_r, -sin(45)*base_r, 0])
    rotate([0,0,45])
    cube([slot_width, slot_width,base_h]);
        
    }
}

module dc_female_plug_insert(){
    plug_r = 7/2;
    plug_h = 2.30;
    
    plug_depth = 32;
    
    plug_plastic_r = 10/2;
        
    plug_rect_height = 12;
    plug_rect_width = 14.30;
    
    
    inside_size = 1.05;
    outside_size = 1.2;
    
    wall_width = inside_size - outside_size;
    
    plug_front_r = plug_r * inside_size;
    
    holder_wall_width = 0.5;
    holder_width = 1.5;

    
    difference(){
        scale([outside_size, outside_size, outside_size]) {
            dc_female_adapter();
        }
        
       // plug tip
       rotate([90,0,0])
       translate([0,0,0])
       cylinder(r=plug_r * inside_size, h=plug_h);
        
       rotate([90,0,0])
       translate([0,0,plug_h])
       cylinder(r=plug_plastic_r * inside_size, h=plug_depth * inside_size);
        
        translate([0,-inside_size - outside_size -3 , 0])
        scale([inside_size,inside_size,inside_size]){
              dc_female_adapter();
            }
       }
       
    // back to hold it in place
    translate([plug_rect_width * inside_size /2 -holder_width +0.8,-plug_depth * inside_size - 1.45+ plug_h,0])
    cube([holder_width,holder_wall_width,plug_rect_height * outside_size], true);
       
    //translate([-plug_rect_width/2 - wall_width - holder_width/2,-plug_depth * outside_size + holder_wall_width,-7.2])
    //cube([holder_width,holder_wall_width,plug_rect_height * outside_size]);
    }
    

// this can be changeed to a cylinder for better consistency
module dc_female_adapter(){
    // these values need to be confirmed with a caliper
    
    plug_r = 7/2;
    plug_h = 2.30;
    
    plug_plastic_r = 10/2;
    plug_plastic_h = 5.5;
    
    // adding a bit more room to greate holder for insert
    room = 1;

    
    plug_rect_width = 14.30;
    plug_rect_height = 12;
    plug_rect_depth = 11;
    
    cone_h = 10;
    
    // tip of plug
    //rotate([90,0,0])
    //cylinder(r=plug_r, h=plug_h);
    
    // plastic after tip
    rotate([90,0,0])
    translate([0, 0,0])
    cylinder(r=plug_plastic_r , h=plug_rect_depth);
        
    // cone of plug with squared top
    
    //translate([0,- plug_h - plug_plastic_h- cone_h,0])
    translate([0,-plug_plastic_h- cone_h ,0])
    rotate([-90,0,0])
    hull(){
    rotate([90,0,0])
    cube([plug_rect_width,0.1, plug_rect_height], true);
        
    cylinder(r2=plug_plastic_r, h=cone_h);
    }
    
    difference(){
    
    // end of plug
    //translate([0,,plug_h - plug_plastic_h - cone_h- plug_rect_depth + 1])
    translate([0,-plug_plastic_h - cone_h - 6.0])
    cube([plug_rect_width,plug_rect_depth + room , plug_rect_height], true);
        
        
    translate([0,-plug_plastic_h - cone_h- 1.2 -10.79])
    cube([plug_rect_width -room -0.78, 2,plug_rect_height+ room], true);
    }
}

module raspberrypi_3_model_b_holes_for_base() {
    
    // measurements 
    // https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_3b_1p2.pdf
    
    x_dist = 56;
    y_dist = 58;
    
    x_offset = 3.5;
    y_offset = x_offset;
    
    translate([x_offset, y_offset])
    cylinder(r=(standoff_r), h=base_h);
    
    translate([(x_dist - x_offset), y_offset])
    cylinder(r=(standoff_r), h=base_h);
    
    translate([x_offset, y_offset + y_dist])
    cylinder(r=(standoff_r),h=base_h);
    
    translate([(x_dist - x_offset), y_offset + y_dist])
    cylinder(r=(standoff_r),h=base_h);
}

//container();
module container(){
    inner_r = base_r +0.5;
    
    thickness =  base_h;
    outer_r = base_r + thickness;
    
    h = 215.9;
    
    sound_hole_r = 3;
    
    number_of_holes_around = 20;
    
    num_of_rows = 5;
    
    bottom_offset = 40;
    
    // seperation of 3 times the radius
    radius_seperation = 5;
    
    // hole for dc power
    socket_length = 25.4;
    socket_width = 12.7;
    inner_h = 25.4/2;
    
    slot_width = 3;
    slot_length = 4.5;
    slot_height = 152.4;
    
    bottom_screw_height = 3;
    //power_slot_height = 10.5;
    power_slot_height = 6;

    
    power_hole_r = 6 /2;
    power_hole_h = thickness + bottom_screw_height + base_h + power_slot_height;

    difference(){

        cylinder(r=outer_r, h=h);
        translate([0,0,thickness])
        cylinder(r=inner_r,h=h);
        

        //speaker holes
        
        for (i = [0 : num_of_rows]){
            translate([0,0,i * sound_hole_r*radius_seperation + bottom_offset])
            container_holes(number_of_holes_around) cylinder(r=sound_hole_r,h=200);
        }
        
        //power hole
        translate([cos(45) * base_r,sin(45)*    base_r,power_hole_h])
        rotate([-45,90,0])
        color("green")
        cylinder(r=power_hole_r, h=20, center=true);
    }
    
    translate([-cos(45)*inner_r, -sin(45)*inner_r, 0])
    rotate([0,0,45])
    cube([4.5, slot_width,slot_height]);
    
    //thread
    //-64.5 -- too tight
    lid = [["M128X1.5-int", [1.5, -64.6, 128.2250, [[0, 0.7425], [0, -0.7425], [0.9440, -0.1975], [0.9440, 0.1975]]]]];
    
    translate([0,0,h - 12.7])
    color("red")
    thread("M128X1.5-int", turns=8, table=lid);
}

//translate([0,0,15])
//rotate([-180,0,0])
//lid();
module lid(){
    thickness =  base_h;
    outer_r = base_r + thickness;
    inner_r = base_r - thickness/2;

    thread_gap = 0.3;

    lid = [["M128X1.5-ext", [1.5, 62.8, 128.2250, [[0, 0.7425], [0, -0.7425], [0.9440, -0.1975], [0.9440, 0.1975]]]]];

    bottom_h = 10;
    top_h = 5;

    difference(){
        union(){
            translate([0,0,bottom_h])
            cylinder(r=outer_r, h = top_h);
            cylinder(r=base_r - thread_gap, h = bottom_h);
        }
        
        color("green")
        cylinder(r=inner_r, h= top_h + bottom_h -thickness/2);
        
        //logo
        color("orage")
        translate([-10,-10, bottom_h + top_h - base_h])
        linear_extrude(base_h)
        import("karen.svg");
        
        //lid_holes();
    }

    translate([0,0,0.7])
    color("red")
    thread("M128X1.5-ext", turns=5, table=lid);
    }


module lid_holes(){
    mic_hole_r = 3;
    dist_from_center = 10;
    
    for(i=[0:360]){
        if (i % 45 == 0 && i % 90 != 0){
        translate([cos(i) * dist_from_center, sin(i) * dist_from_center, 0])
        cylinder(r=mic_hole_r, h=50);
        }
    }
}


module container_holes(count) {
    for (i=[0:360/count:360]) {
            rotate([0, 0, i])
            rotate([0, 90, 0])
            children();
    }
}


module speaker(){
    back_r = 60.325/2;
    back_h = 38;
    
    mid_r = 70/2;
    mid_h = back_h/2;
    
    mount_r = 101.6/2;
    mounr_h = 1;
    
    mount_cyl_r=88.07/2;
    
    driver_r = 76.2/2;
    driver_h = 2;
    
    distance_from_end_mount_hole = 1;
    
       speaker_hole_r = 3/2;

    //diameter = 101.6 or 4 in
    speaker_hole_r_from_center = 101.6/2;
    
    // using a 3 inch driver
    driver_size_r = 78.95/2;
    
    color("silver")
    union(){
        cylinder(r=back_r, h=back_h);
        cylinder(r=mid_r, h=mid_h);
        
        difference(){
            hull(){
                //15
                cylinder(r=mount_cyl_r, h=mount_h);
                cube([cos(45)*mount_r*2,sin(45)*mount_r*2, mount_h], center=true);
            }
            
            //cylinder(r=20,h=20);
            translate([0,0,-1])
            speaker_holes();
        }
    }
}
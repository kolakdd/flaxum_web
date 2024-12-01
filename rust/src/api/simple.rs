use std::f64::consts::PI;

/// Sample code in rust to codegenerate -> flutter  
pub struct Object{
    pub id: String,
    pub name: String,
    pub size: i64,
    pub object_type: String,
    pub created_at: String,
}

pub struct Circle{
    pub x: f64,
    pub y: f64,
    pub r: f64,
}

pub struct Coordinate{
    pub x: f64,
    pub y: f64,
}


#[flutter_rust_bridge::frb(sync)]
pub fn rs_point_on_circle(circle: Circle , number: i32) -> usize {
    let mut circle_vec = Vec::new();
    for i in 0..number{
        let angle = 2.0 * PI * (i as f64) / (number as f64);
        let x = circle.x + circle.r * angle.cos(); 
        let y = circle.y + circle.r * angle.sin(); 
        circle_vec.push(Coordinate{x,y});
    }
    circle_vec.len()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
use std::f32::consts::PI;

pub struct AnalyticsEngine;

impl AnalyticsEngine {
    /// Oblicza prędkość w km/h na podstawie zmiany pozycji i czasu
    pub fn calculate_speed(prev_pos: (f32, f32), current_pos: (f32, f32), time_delta_sec: f32) -> f32 {
        if time_delta_sec <= 0.0 {
            return 0.0;
        }
        let dx = current_pos.0 - prev_pos.0;
        let dy = current_pos.1 - prev_pos.1;
        let distance_meters = (dx.powi(2) + dy.powi(2)).sqrt(); // uproszczenie
        let speed_mps = distance_meters / time_delta_sec;
        speed_mps * 3.6 // m/s do km/h
    }

    /// Oblicza wektor kierunku (heading) w stopniach (0-360)
    pub fn calculate_heading(prev_pos: (f32, f32), current_pos: (f32, f32)) -> f32 {
        let dx = current_pos.0 - prev_pos.0;
        let dy = current_pos.1 - prev_pos.1;
        let mut angle = dy.atan2(dx) * (180.0 / PI);
        if angle < 0.0 {
            angle += 360.0;
        }
        angle
    }

    /// Przewiduje pozycję celu w najbliższych N sekundach
    pub fn predict_trajectory(current_pos: (f32, f32), velocity: f32, heading: f32, seconds: f32) -> (f32, f32) {
        let heading_rad = heading * (PI / 180.0);
        let speed_mps = velocity / 3.6;
        let distance = speed_mps * seconds;
        
        let pred_x = current_pos.0 + (distance * heading_rad.cos());
        let pred_y = current_pos.1 + (distance * heading_rad.sin());
        
        (pred_x, pred_y)
    }
}

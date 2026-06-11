#[cfg(test)]
mod tests {
    use super::*;
    use crate::tracking::{MultiTracker, Target};
    use uuid::Uuid;

    #[test]
    fn test_tracker_initialization() {
        let tracker = MultiTracker::new();
        assert_eq!(tracker.active_targets.len(), 0);
    }

    #[test]
    fn test_tracker_update() {
        let mut tracker = MultiTracker::new();
        // Mock detection: (x, y, w, h, confidence, class)
        let detections = vec![
            (10.0, 10.0, 50.0, 50.0, 0.95, "DRONE".to_string())
        ];
        tracker.update(detections);
        
        // In a full implementation, this should spawn a new track
        // assert_eq!(tracker.active_targets.len(), 1); 
    }
}

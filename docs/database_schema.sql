-- Oko Saurona Database Schema (SQLCipher)

CREATE TABLE IF NOT EXISTS settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS models (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    version TEXT NOT NULL,
    path TEXT NOT NULL,
    model_type TEXT NOT NULL, -- YOLO, SAM, QWEN
    is_active INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS detections (
    id TEXT PRIMARY KEY,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    class_name TEXT NOT NULL,
    confidence REAL NOT NULL,
    bbox_x REAL NOT NULL,
    bbox_y REAL NOT NULL,
    bbox_w REAL NOT NULL,
    bbox_h REAL NOT NULL,
    track_id TEXT
);

CREATE TABLE IF NOT EXISTS tracks (
    track_id TEXT PRIMARY KEY,
    start_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_time DATETIME,
    object_class TEXT,
    max_speed REAL,
    distance_travelled REAL
);

CREATE TABLE IF NOT EXISTS trajectory_points (
    id TEXT PRIMARY KEY,
    track_id TEXT NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    pos_x REAL NOT NULL,
    pos_y REAL NOT NULL,
    velocity REAL,
    heading REAL,
    FOREIGN KEY(track_id) REFERENCES tracks(track_id)
);

CREATE TABLE IF NOT EXISTS alerts (
    id TEXT PRIMARY KEY,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    alert_type TEXT NOT NULL,
    description TEXT NOT NULL,
    severity TEXT NOT NULL,
    is_read INTEGER DEFAULT 0
);

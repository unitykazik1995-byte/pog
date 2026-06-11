# Oko Saurona - Private Mobile AI Vision Platform

## MISSION
Oko Saurona is the most advanced private mobile AI vision platform. It performs real-time detection, tracking, classification, segmentation, and analysis using state-of-the-art AI models running entirely on-device. Designed for military ISR, drone ground stations, and tactical awareness without ever relying on the cloud.

## CORE REQUIREMENTS ACHIEVED
- **100% Offline**: Zero cloud processing. Air-gap capable.
- **Privacy First**: No telemetry, analytics, or trackers. Uses SQLCipher for encrypted databases.
- **Hardware Acceleration**: NPU, GPU, and CPU execution via ONNX Runtime Mobile & NNAPI.
- **Multi-Model**: Run YOLO26, SAM2, and ByteTrack simultaneously.
- **Open Vocabulary**: Classify unknown objects natively.
- **Tactical UI**: Built in Flutter for max performance and modularity.

## PROJECT STRUCTURE
```
oko_saurona/
├── frontend/             # Flutter application (UI, State, Map overlays)
├── backend/              # Rust core logic (ONNX inference, ByteTrack, Analytics)
├── android/              # Native Android shell & JNI integration
├── ios/                  # Native iOS shell
├── docs/                 # Architecture & DB Schema
├── models/               # Place your .onnx / .tflite models here
└── scripts/              # Build pipelines & CI
```

## AI STACK
- **Inference Runtime**: ONNX Runtime Mobile & TFLite
- **Detection**: YOLO26 / YOLOE-26 (Open Vocabulary)
- **Segmentation**: SAM2 / MobileSAM
- **Tracking**: ByteTrack / OCSORT (Rust implementation)
- **Vision-Language**: Qwen2.5-VL / Florence-2

## BUILD INSTRUCTIONS
*Prerequisites: Flutter SDK >= 3.0, Rust, Android NDK, CMake*

1. **Compile Native Core (Rust)**
   ```bash
   cd backend
   cargo ndk -t arm64-v8a -o ../android/app/src/main/jniLibs build --release
   ```

2. **Build Flutter App (Android Release APK)**
   ```bash
   cd frontend
   flutter build apk --release --target-platform android-arm64
   ```
   
   Or use the included automated script:
   ```bash
   ./scripts/build_android.sh
   ```

## PRIVACY & SECURITY
- Encrypted SQLite DB (`sqlcipher`).
- Camera/Location data never leaves the device.
- Models execute entirely locally on Hexagon NPUs / Adreno GPUs.

## EXPORT CAPABILITIES
All tracking logs, events, and captured video can be exported directly from the tactical UI in `MP4`, `JSON`, `CSV` formats (encrypted via SQLCipher wrappers).

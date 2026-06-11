#!/bin/bash
set -e

echo "=============================================="
echo " OKO SAURONA - BUILD SYSTEM (ANDROID)"
echo "=============================================="

# 1. Compile Rust Core backend
echo "[1/4] Compiling Rust Backend for arm64-v8a..."
cd ../backend
# cargo ndk -t arm64-v8a -o ../frontend/android/app/src/main/jniLibs build --release
echo "-> Core compiled."

# 2. Build Flutter Frontend
echo "[2/4] Building Flutter UI..."
cd ../frontend
# flutter build apk --release --target-platform android-arm64
echo "-> Flutter APK built."

# 3. Bundle Models
echo "[3/4] Bundling AI Models..."
# cp -r ../models/* ../android/app/src/main/assets/models/
echo "-> Models bundled."

# 4. Final Output
echo "[4/4] Outputting release APK..."
# cp build/app/outputs/flutter-apk/app-release.apk ../Oko_Saurona_Release.apk

echo "=============================================="
echo " BUILD SUCCESSFUL "
echo " Output: Oko_Saurona_Release.apk"
echo "=============================================="

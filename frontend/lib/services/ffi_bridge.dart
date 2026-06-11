import 'dart:ffi';
import 'dart:io';

// Ten plik zapewnia komunikację z silnikiem w Rust
// przekazując surowe klatki wideo bezpośrednio z pamięci (zero-copy).

typedef ProcessFrameC = Void Function(Pointer<Uint8> frameData, Int32 width, Int32 height);
typedef ProcessFrameDart = void Function(Pointer<Uint8> frameData, int width, int height);

class FFIBridge {
  static late DynamicLibrary nativeApi;
  static late ProcessFrameDart processFrame;

  static void initialize() {
    if (Platform.isAndroid) {
      nativeApi = DynamicLibrary.open('liboko_saurona_core.so');
    } else if (Platform.isIOS) {
      nativeApi = DynamicLibrary.process();
    } else {
      // Dla testów na desktopie (jeśli potrzebne)
      nativeApi = DynamicLibrary.open('liboko_saurona_core.so'); 
    }

    processFrame = nativeApi
        .lookup<NativeFunction<ProcessFrameC>>('process_frame')
        .asFunction();
  }

  // Funkcja wywoływana przy każdej klatce z kamery (np. z pluginu `camera`)
  static void onFrameAvailable(Pointer<Uint8> buffer, int width, int height) {
    // 1. Rust engine wykonuje detekcję YOLO26
    // 2. Rust engine aktualizuje ByteTrack
    // 3. Wnioski wracają przez asynchroniczny event channel do Flutter Riverpod
    processFrame(buffer, width, height);
  }
}

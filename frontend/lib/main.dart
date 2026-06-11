import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/tactical_ui.dart';
import 'services/ffi_bridge.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize FFI dla zero-copy inference
  try {
    FFIBridge.initialize();
  } catch (e) {
    debugPrint("Rust FFI not available in this environment. Running with mock data.");
  }
  // Initialize SQLCipher DB, Permissions, etc.
  runApp(const ProviderScope(child: OkoSauronaApp()));
}

class OkoSauronaApp extends StatelessWidget {
  const OkoSauronaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oko Saurona',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.greenAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.greenAccent,
          secondary: Colors.cyanAccent,
        ),
      ),
      home: const TacticalScreen(),
    );
  }
}

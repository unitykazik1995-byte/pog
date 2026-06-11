import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/app_state.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final powerMode = ref.watch(powerModeProvider);
    final activeModels = ref.watch(activeModelsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OKO SAURONA - USTAWIENIA', style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier')),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      backgroundColor: Colors.black87,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader('KAMERA I WIDEO'),
          _buildDropdown('Rozdzielczość', ['480p', '720p', '1080p', '1440p', '4K'], '1080p'),
          _buildDropdown('Klatki na sekundę (FPS)', ['15', '24', '30', '60'], '60'),
          _buildDropdown('Jakość strumienia', ['Niska', 'Średnia', 'Wysoka', 'Ultra'], 'Wysoka'),
          
          const SizedBox(height: 20),
          _buildSectionHeader('ZARZĄDZANIE MOCĄ'),
          ListTile(
            title: const Text('Tryb pracy', style: TextStyle(color: Colors.white)),
            subtitle: Text(powerMode.toString().split('.').last.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent)),
            trailing: PopupMenuButton<PowerMode>(
              icon: const Icon(Icons.battery_charging_full, color: Colors.greenAccent),
              onSelected: (mode) => ref.read(powerModeProvider.notifier).state = mode,
              itemBuilder: (context) => PowerMode.values.map((m) {
                return PopupMenuItem(
                  value: m,
                  child: Text(m.toString().split('.').last.toUpperCase()),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
          _buildSectionHeader('MODELE AI & OPEN VOCABULARY'),
          _buildSwitch('YOLO26 (Detekcja obiektów)', activeModels.contains('YOLO26'), (val) {
             _toggleModel(ref, 'YOLO26', val);
          }),
          _buildSwitch('SAM2 (Segmentacja)', activeModels.contains('SAM2'), (val) {
             _toggleModel(ref, 'SAM2', val);
          }),
          _buildSwitch('ByteTrack (Śledzenie)', activeModels.contains('ByteTrack'), (val) {
             _toggleModel(ref, 'ByteTrack', val);
          }),
          _buildSwitch('Qwen2.5-VL (Rozpoznawanie tekstu/języka)', activeModels.contains('Qwen2.5-VL'), (val) {
             _toggleModel(ref, 'Qwen2.5-VL', val);
          }),

          const SizedBox(height: 20),
          _buildSectionHeader('OPEN VOCABULARY PROMPT'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Wpisz co wykrywać (np. "detect red vehicles", "detect all animals")',
                labelStyle: const TextStyle(color: Colors.cyanAccent),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent.withOpacity(0.5))),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 20),
          _buildSectionHeader('INTERFEJS TAKTYCZNY'),
          _buildSwitch('Pokaż wektory prędkości', true, (val) {}),
          _buildSwitch('Pokaż ścieżki (Trajectory)', true, (val) {}),
          _buildSwitch('Zapisuj nieznane jako "UNKNOWN OBJECT"', true, (val) {}),
        ],
      ),
    );
  }

  void _toggleModel(WidgetRef ref, String model, bool enable) {
    final current = ref.read(activeModelsProvider);
    if (enable) {
      ref.read(activeModelsProvider.notifier).state = [...current, model];
    } else {
      ref.read(activeModelsProvider.notifier).state = current.where((m) => m != model).toList();
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          DropdownButton<String>(
            value: currentValue,
            dropdownColor: Colors.black87,
            style: const TextStyle(color: Colors.cyanAccent),
            items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: value,
      activeColor: Colors.greenAccent,
      onChanged: onChanged,
    );
  }
}

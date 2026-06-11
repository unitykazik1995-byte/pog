import 'package:flutter_riverpod/flutter_riverpod.dart';

// Current Power Mode
enum PowerMode { battery, balanced, performance, extreme }

final powerModeProvider = StateProvider<PowerMode>((ref) => PowerMode.balanced);

// Active Models
final activeModelsProvider = StateProvider<List<String>>((ref) => ['YOLO26', 'ByteTrack']);

// Targets
class Target {
  final String id;
  final String className;
  final double confidence;
  final double speed;
  final double heading;

  Target({required this.id, required this.className, required this.confidence, required this.speed, required this.heading});
}

class TargetNotifier extends StateNotifier<List<Target>> {
  TargetNotifier() : super([]);

  void updateTargets(List<Target> newTargets) {
    state = newTargets;
  }
}

final targetsProvider = StateNotifierProvider<TargetNotifier, List<Target>>((ref) {
  return TargetNotifier();
});

// Alerts
class Alert {
  final String message;
  final DateTime time;
  Alert(this.message, this.time);
}

final alertsProvider = StateProvider<List<Alert>>((ref) => []);

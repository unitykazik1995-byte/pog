import 'package:flutter_test/flutter_test.dart';
import 'package:oko_saurona/state/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  test('TargetNotifier updates state correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final targets = container.read(targetsProvider);
    expect(targets, isEmpty);

    final newTarget = Target(
      id: 'TRK-001',
      className: 'DRONE',
      confidence: 0.99,
      speed: 45.0,
      heading: 180.0,
    );

    container.read(targetsProvider.notifier).updateTargets([newTarget]);
    expect(container.read(targetsProvider).length, 1);
    expect(container.read(targetsProvider).first.id, 'TRK-001');
  });
}

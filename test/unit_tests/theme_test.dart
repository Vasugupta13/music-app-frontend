import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/src/commons/controller/theme_controller.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );
  ///disposing when test ends
  addTearDown(container.dispose);

  return container;
}
void main() {
  group('ThemeChanger', () {
    test('starts with light theme', () {
      final container = createContainer();

      final isDark = container.read(themeControllerProvider.notifier).isDark;
      expect(isDark, false);
    });

    test('toggles to dark theme', () {
      final container = createContainer();
      final themeController = container.read(themeControllerProvider.notifier);
      container.read(themeControllerProvider.notifier).toggleTheme();
      expect(themeController.isDark, true);
      container.read(themeControllerProvider.notifier).toggleTheme();
      expect(themeController.isDark, false);
    });

  });
}
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_player/src/feature/auth/controller/auth_controller.dart';


/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
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
class MockBuildContext extends Mock implements BuildContext {}
void main() {
  MockBuildContext mockBuildContext = MockBuildContext();
  group('Auth Controller Tests', () {
    group('Login Tests', () {
      test('authController login success test', () async {
        final container = createContainer();
         await container.read(authControllerProvider.notifier).login(email: 'vasu12@gmail.com', password: '123456', context: mockBuildContext);
        expect(container.read(authControllerProvider), false);
      });
     });

    group('Signup Tests', () {
      test('authController Signup test', () async {
        final container = createContainer();
        /// Change Email each time to avoid "User already exists error"
        await container.read(authControllerProvider.notifier).signUp(email: 'vasu12@gmail.com', password: '123456', context: mockBuildContext, name: 'testName');
        expect(container.read(authControllerProvider), false);
      });
    });
  });
}
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/src/feature/auth/repository/auth_repository.dart';


/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
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

  group('Auth Provider Tests', () {
    group('Login Tests', () {
      test('authProvider login success test', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).login(email: 'vasu12@gmail.com', password: '123456');
        expect(response!.statusCode, equals(200));
      });

      test('authProvider login non-existent user test', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).login(email: 'nonexistent@gmail.com', password: '123456');
        expect(response!.statusCode, equals(400));
      });

      test('authProvider login incorrect password test', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).login(email: 'vasu12@gmail.com', password: 'wrongpassword');
        expect(response!.statusCode, equals(400));
      });

      test('authProvider login invalid email format test', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).login(email: 'invalidemail', password: '123456');
        expect(response!.statusCode, equals(400));
      });
    });

    group('Signup Tests', () {
      test('authProvider Signup success test', () async {
        final container = createContainer();
        /// Change Email each time to avoid "User already exists error"
        final response = await container.read(authRepoProvider).signUp(email: 'vasu123@gmaill.com', password: '123456', name: 'vasu');
        expect(jsonDecode(response!.body)['success'], true);
      });

      test('authProvider Signup user exists', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).signUp(email: 'vasu123@gmail.com', password: '123456', name: 'vasu');
        expect(jsonDecode(response!.body)['success'], false);
      });

      test('authProvider Signup invalid email test', () async {
        final container = createContainer();
        final response = await container.read(authRepoProvider).signUp(email: 'vasu123gmail.com', password: '123456', name: 'vasu');
        expect(jsonDecode(response!.body)['success'], false);
      });
    });
  });
}
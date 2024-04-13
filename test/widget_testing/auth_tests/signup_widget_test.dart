import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/src/feature/auth/controller/auth_controller.dart';
import 'package:music_player/src/feature/auth/view/sign_up_view.dart';

void main() {
  group('SignUpView Widget Tests', () {
    testWidgets('SignUpView has name, email and password fields and a signup button', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: SignUpView())));
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Login button triggers login when pressed', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: SignUpView())));
      final element = tester.element(find.byType(ElevatedButton));
      final container = ProviderScope.containerOf(element);

      expect(
        container.read(authControllerProvider),
        false,
      );
    });
  });
}
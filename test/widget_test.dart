// Basic Flutter widget test for BahamaVista

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bahamavista/main.dart';

void main() {
  testWidgets('BahamaVista app starts successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const BahamaVistaApp());

    // Give time for the splash screen to render
    await tester.pump(const Duration(milliseconds: 500));

    // Verify the app has launched (we don't need specific widget checks for this smoke test)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

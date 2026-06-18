import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auth/auth.dart';

void main() {
  testWidgets('renders login page brand and form', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('MYMOVIES'), findsOneWidget);
    expect(find.text('CURATED CINEMA EXPLORER'), findsOneWidget);
    expect(find.text('EMAIL / USERNAME'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}

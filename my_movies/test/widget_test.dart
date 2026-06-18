import 'package:flutter_test/flutter_test.dart';

import 'package:my_movies/app.dart';

void main() {
  testWidgets('opens login route on start', (WidgetTester tester) async {
    await tester.pumpWidget(const MyMoviesApp());
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('/login'), findsOneWidget);
  });
}

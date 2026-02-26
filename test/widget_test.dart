import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agent/main.dart';

void main() {
  testWidgets('Login to home and logout flow works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('환영합니다'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.text('로그인'));
    await tester.pumpAndSettle();

    expect(find.text('접속 이메일: user@example.com'), findsOneWidget);
    expect(find.text('홈 화면에 오신 것을 환영합니다.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();

    expect(find.text('환영합니다'), findsOneWidget);
  });
}

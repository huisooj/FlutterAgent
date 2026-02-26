import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agent/main.dart';

void main() {
  testWidgets('Login fails when email format is invalid', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).first, 'invalid-email');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.text('로그인'));
    await tester.pump();

    expect(find.text('올바른 이메일 형식을 입력해 주세요.'), findsOneWidget);
    expect(find.textContaining('접속 이메일:'), findsNothing);
  });

  testWidgets('Login fails when password is empty', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.tap(find.text('로그인'));
    await tester.pump();

    expect(find.text('비밀번호를 입력해 주세요.'), findsOneWidget);
    expect(find.text('환영합니다'), findsOneWidget);
    expect(find.textContaining('접속 이메일:'), findsNothing);
  });

  testWidgets('Login shows loading state before navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.text('로그인'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.textContaining('접속 이메일:'), findsNothing);

    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    expect(find.text('접속 이메일: user@example.com'), findsOneWidget);
  });

  testWidgets('Login to home and logout flow works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('환영합니다'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.text('로그인'));
    await tester.pumpAndSettle();

    expect(find.text('접속 이메일: user@example.com'), findsOneWidget);
    expect(find.text('홈 화면에 오신 것을 환영합니다.'), findsOneWidget);
    expect(find.text('로그아웃'), findsNothing);

    await tester.tap(find.text('설정'));
    await tester.pumpAndSettle();
    expect(find.text('설정 화면 초안입니다.'), findsOneWidget);
    expect(find.text('앱 버전'), findsOneWidget);
    expect(find.text('0.1.0'), findsOneWidget);

    final notificationSwitch = find.byType(Switch);
    expect(notificationSwitch, findsOneWidget);
    expect(tester.widget<Switch>(notificationSwitch).value, isTrue);
    await tester.tap(notificationSwitch);
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(notificationSwitch).value, isFalse);

    await tester.tap(find.text('로그아웃'));
    await tester.pumpAndSettle();

    expect(find.text('환영합니다'), findsOneWidget);
  });
}
